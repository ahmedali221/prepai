import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/app.dart';
import 'package:prepai/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (_, child) => const MyApp(),
      ),
    ),
  );
}
