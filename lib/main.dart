import 'package:flutter/material.dart';
import 'home.dart';

//
void main() => runApp(HealthViewApp());

class HealthViewApp extends StatelessWidget {
  final String displayName = 'Health View';
  // Entry point for Health View application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: displayName,
      home: HomePage(title: displayName),
    );
  }
}
