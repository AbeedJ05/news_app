import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hotel_app/components/mybutton.dart';
import 'package:hotel_app/pages/home_page.dart';
import 'package:hotel_app/services/auth_google.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key, required this.toggleButton});
  final void Function() toggleButton;

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  bool _isPasswordVisible = false;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Ensure the currentUser is updated
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        print('Signed in as ${currentUser.email}');
      }

      // Navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      // Handle errors
      print("Error signing in with Google: $e");
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-in failed.")),
      );
    }
  }

 void signUserUp() async {
  if (_formKey.currentState?.validate() ?? false) {
    try {
      // Check if passwords match
      if (_passwordController.text == _passwordConfirmController.text) {
        // Show a loading indicator
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        // Create the user with the email and password
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Hide the loading indicator
        Navigator.of(context).pop();

        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-up successful!")),
        );
      } else {
        // Passwords don't match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Confirm password correctly")),
        );
      }
    } catch (e) {
      // Hide the loading indicator if there was an error
      Navigator.of(context).pop();

      // Handle sign-up errors
      debugPrint("Email Sign-up failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-up failed: $e")),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email field
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value);
                  if (!emailValid) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              _gap(),
              // Password field
              password(_passwordController, "Enter password", "password"),
              const SizedBox(height: 10,),
              password(_passwordConfirmController, "Confirm password", "Confirm password"),
              _gap(),
              // Sign up button
              MyButton(onTap: signUserUp, text: "Sign Up"),
              _gap(),
              // Register button
              const Text("Already you have account!", style: TextStyle(color: Colors.grey)),
              const SizedBox(width: 4),
              InkWell(
                  onTap: widget.toggleButton,
                  child: const Text(
                    "Log in Now",
                    style: TextStyle(color: Colors.blue),
                  )),
              _gap(),
              // Google Sign-in button
                const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SignInButton(
                    Buttons.google,
                    text: "Sign in with Google",
                    onPressed: AuthGoogle.signInWithGoogle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
  Widget password(controller, text, hintText) => TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters';
          }
          return null;
        },
        obscureText: !_isPasswordVisible,
        decoration: InputDecoration(
          labelText: text,
          hintText: hintText,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
        ),
      );
}
