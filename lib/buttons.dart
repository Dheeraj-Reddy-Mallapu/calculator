import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final buttonText;
  final buttontapped;

//Constructor
  MyButton({this.buttonText, this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
