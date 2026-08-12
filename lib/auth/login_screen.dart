
import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../database/app_database.dart';
import 'signup_screen.dart';
import 'package:book_reminder/home.dart';// adjust to your actual home widget

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  bool obscurePassword = true;
  String? errorMessage;
  bool isLoading = false;

  Future<void> _login() async {
    setState(() { isLoading = true; errorMessage = null; });
    try {
      final user = await authService.login(emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        await AppDatabase.instance.saveSession(user.displayName ?? "", user.email ?? "");
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => homepage ()));
        }
      }
    } on Exception catch (e) {
      setState(() { errorMessage = "Login failed. Check your email and password."; });
    } finally {
      setState(() { isLoading = false; });
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() { isLoading = true; errorMessage = null; });
    try {
      final user = await authService.signInWithGoogle();
      if (user != null) {
        await AppDatabase.instance.saveSession(user.displayName ?? "", user.email ?? "");
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => homepage ()));
        }
      }
    }  catch (e) {
         print("GOOGLE SIGNIN ERROR: $e");
         setState(() { errorMessage = "Google sign-in failed: $e"; });
}  
   finally {
      setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA), // your cream background
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, )),
            const SizedBox(height: 24),

            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
            ),
             Align(
            alignment: Alignment.centerRight,
              child: TextButton(
             onPressed: _showForgotPasswordDialog,
             child: Text("Forgot Password?"),
              ),
                ),
            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ],

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : _login,
              style: ElevatedButton.styleFrom(),
              child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text("Log In"),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: isLoading ? null : _loginWithGoogle,
              icon: Icon(Icons.g_mobiledata),
              label: Text("Continue with Google"),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen()));
              },
              child: Text("Don't have an account? Sign up"),
            ),
            
          ],
        ),
      ),
    );
  }
void _showForgotPasswordDialog() {
  final resetEmailController = TextEditingController(text: emailController.text);
  String? resetError;
  bool isSending = false;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder( // lets the dialog update its own state (loading, error) independently
        builder: (context, setDialogState) {
          return AlertDialog(
            title: Text("Reset Password"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Enter your email and we'll send you a link to reset your password."),
                const SizedBox(height: 16),
                TextField(
                  controller: resetEmailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                if (resetError != null) ...[
                  const SizedBox(height: 8),
                  Text(resetError!, style: TextStyle(color: Colors.red, fontSize: 13)),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: isSending
                    ? null
                    : () async {
                        setDialogState(() { isSending = true; resetError = null; });
                        try {
                          await authService.sendPasswordReset(resetEmailController.text.trim());
                          if (mounted) {
                            Navigator.pop(context); // close the dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password reset email sent! Check your inbox.")),
                            );
                          }
                        } catch (e) {
                          setDialogState(() {
                            resetError = "Couldn't send reset email. Check the address and try again.";
                            isSending = false;
                          });
                        }
                      },
                child: isSending
                    ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text("Send Reset Link"),
              ),
            ],
          );
        },
      );
    },
  );
}
}
