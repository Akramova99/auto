import 'package:flutter/material.dart';

class TabElement extends StatelessWidget {
  final String tabItem;
  final bool? isRight; // '?' indicates the variable can be null

  const TabElement({super.key, required this.tabItem, required this.isRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color:
          _getBackgroundColor(), // Delegate color logic to a separate function
      child: Center(child: Text(tabItem)),
    );
  }

  Color _getBackgroundColor() {
    if (isRight == null) {
      return Colors.blue; // Default color if isRight is null
    } else if (isRight!) {
      return Colors.green; // Green if isRight is true
    } else {
      return Colors.red; // Red if isRight is false
    }
  }
}
