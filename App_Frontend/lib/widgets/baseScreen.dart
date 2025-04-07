import 'package:flutter/material.dart';
import 'appBar.dart'; // Importamos la navbar

class BaseScreen extends StatelessWidget {
  final Widget child;
  final String? title; // Parámetro opcional
  final IconData? icon; // Parámetro opcional

  const BaseScreen({required this.child, this.title, this.icon, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF64A3A3), Colors.white],
          ),
        ),
        child: child,
      ),
    );
  }
}
