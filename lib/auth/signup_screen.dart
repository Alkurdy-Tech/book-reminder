import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  String? errorMessage;
  bool isLoading = false;
   bool obscurePassword = true; 

  Future<void> _signUp() async {
    setState(() { isLoading = true; errorMessage = null; });
    try {
      final user = await authService.signUp(nameController.text.trim(), emailController.text.trim(), passwordController.text.trim());
      if (user != null && mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Verify your email"),
            content: Text("We sent a verification link to ${user.email}. Please verify before logging in."),
            actions: [
  TextButton(
    onPressed: () async {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      print("Resent verification email");
           },
         child: Text("Resend Email"),
             ),
          TextButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
    child: Text("OK"),
  ),
],
          ),
        );
      }
    } catch (e) {
      print("SIGNUP ERROR: $e");
      setState(() { errorMessage = "Sign up failed. Try a different email or stronger password."; });
    } finally {
      setState(() { isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)),
            const SizedBox(height: 24),

            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            const SizedBox(height: 12),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Password (min 6 characters)",
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

            if (errorMessage != null) ...[
              const SizedBox(height: 8),
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ],

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: isLoading ? null : _signUp,
              style: ElevatedButton.styleFrom(),
              child: isLoading ? CircularProgressIndicator(color: Colors.white) : Text("Sign Up"),
            ),
            
          ],
        ),
      ),
    );
  }
}