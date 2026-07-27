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
  String? errorMessage;
  bool isLoading = false;

  Future<void> _login() async {
    setState(() { isLoading = true; errorMessage = null; });
    try {
      final user = await authService.login(emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        await AppDatabase.instance.saveSession(user.email ?? "");
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
        await AppDatabase.instance.saveSession(user.email ?? "");
        if (mounted) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => homepage ()));
        }
      }
    } catch (e) {
      setState(() { errorMessage = "Google sign-in failed."; });
    } finally {
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
            Text("Welcome Back", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF5C3D2E))),
            const SizedBox(height: 24),

            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            const SizedBox(height: 12),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Password")),

            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ],

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : _login,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD96C3F)),
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
}