import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap; // Declare the onTap function
  final String text;

  const MyButton({super.key, required this.onTap , required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
       // Added margin
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30), // Added a border radius for rounded corners
        ),
        child:  Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
