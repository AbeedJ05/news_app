import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/components/mybutton.dart';
import 'package:hotel_app/pages/home_page.dart';
import 'package:hotel_app/services/auth_google.dart';
import 'package:sign_in_button/sign_in_button.dart';

class FormContent extends StatefulWidget {
  const FormContent({super.key , required this.toggleButton});
  final void Function() toggleButton ;

  @override
  State<FormContent> createState() => FormContentState();
}

class FormContentState extends State<FormContent> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Sign in with Email and Password
  void _signInWithEmailAndPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        // Show a loading indicator
        showDialog(
          context: context,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
          Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );

        // Hide the loading indicator
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-in successful!")),
        );
      } catch (e) {
        // Hide the loading indicator
        Navigator.of(context).pop();

        debugPrint("Email Sign-in failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-in failed: $e")),
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
              TextFormField(
                controller: _passwordController,
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
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              _gap(),
              // Remember me field
              CheckboxListTile(
                value: _rememberMe,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _rememberMe = value;
                  });
                },
                title: const Text('Remember me'),
                controlAffinity: ListTileControlAffinity.leading,
                dense: true,
                contentPadding: const EdgeInsets.all(0),
              ),
              _gap(),
              // Sign in button
            MyButton(onTap: _signInWithEmailAndPassword, text: "Sign In"),
              _gap(),
              // Register button
              const Text("Not a Member!" , style: TextStyle(color: Colors.grey,),),
              const SizedBox(width: 4,),
              InkWell(onTap:widget.toggleButton ,child: const Text("register Now" , style: TextStyle(color: Colors.blue,),)),
              
              _gap(),
              const Divider(height: 10),
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
}