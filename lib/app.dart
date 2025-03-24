import 'package:flutter/material.dart';
import 'package:prepai/features/Home/presentation/views/screen/profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}