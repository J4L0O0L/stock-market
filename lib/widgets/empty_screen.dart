import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;

  const EmptyScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(
          height: 1.5,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey),
      textAlign: TextAlign.start,
    );
  }
}
