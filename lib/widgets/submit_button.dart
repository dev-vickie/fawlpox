import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  const SubmitButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 43, 68),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
