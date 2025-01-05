import 'package:flutter/material.dart';

class MakeBox extends StatelessWidget {
  final String text;

  const MakeBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      // constraints: const BoxConstraints(maxWidth: 400.0), // Set a maximum width
      decoration: BoxDecoration(
        color: const Color(0xff4147D5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
