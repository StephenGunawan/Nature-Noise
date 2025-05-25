import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final void Function ()? onPressed;

  const CustomButton({
    super.key, 
    required this.width, 
    required this.height, 
    required this.text,
    required this.onPressed
    });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 5,
          minimumSize: Size(width,height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}