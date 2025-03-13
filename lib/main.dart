import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepai/features/Auth/presentation/pages/Login_Page.dart';

void main() {
  runApp(const Prepai());
}

class Prepai extends StatelessWidget {
  const Prepai({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: const MaterialApp(
        home: Scaffold(
          body: LoginPage(),
        ),
      ),
    );
  }
}
