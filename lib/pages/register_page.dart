import 'package:flutter/material.dart';
import 'package:hotel_app/components/__logo.dart';
import 'package:hotel_app/components/form_sign_up.dart';
import 'package:hotel_app/pages/login_or_register.dart';


class RegisterPage extends StatefulWidget {
  
    const RegisterPage({super.key, required this.toggleButtons});
  final void Function() toggleButtons;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isSignUp = true; // State to toggle between forms

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: isSignUp
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Logo(),
                  const SizedBox(height: 16),
                  SignUpForm(toggleButton: widget.toggleButtons), // Pass the toggle function
                  const SizedBox(height: 16),
                ],
              )
            : const LoginOrRegister(), // You can create a LoginForm widget here
      ),
    );
  }

  // Function to toggle between sign-up and login
  
}
