import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final double width;
  final double height;
  final double boxRadius;
  final String initialText;

  const InputCard({
    super.key,
    this.width = 285.0,
    this.height = 58.0,
    this.boxRadius = 10.0,
    this.initialText = "Enter Hint Text"
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 5, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(boxRadius)),
        ),
        color: Theme.of(context).colorScheme.secondary,
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: initialText,
            contentPadding: EdgeInsets.only(left:7.0),
            hintStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 128),
            ),
          ),
        ),
      ),
    );
  }
}

