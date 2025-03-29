import 'package:flutter/material.dart';
import 'package:prepai/Core/Routes/App_Routes.dart';
import 'package:prepai/features/food_chat/presentation/pages/chat_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
     routerConfig: router,

    );
  }
}