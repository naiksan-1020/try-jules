import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:try_jules/app_routes.dart'; // Import app_routes.dart

// Define the LoginController
class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  void login() {
    // Implement login logic here
    // For now, just print the email and password
    print('Email: ${emailController.text}');
    print('Password: ******'); // Masked password for security

    // Navigate to home screen on successful login
    Get.offAllNamed(AppRoutes.home); // Navigate using AppRoutes.home
  }
}

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _loginController.emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _loginController.passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _loginController.login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
