import 'package:flutter/material.dart';

class MakeBox extends StatelessWidget {
  final String text;

  const MakeBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric( vertical: 15),
     // constraints: const BoxConstraints(maxWidth: 400.0), // Set a maximum width

      height: 50.0,
      decoration: BoxDecoration(
        color: const Color(0xff4147D5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}
