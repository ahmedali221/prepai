import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/services/firebase_service.dart';
import 'package:prepai/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore).signUp(
  //     email: "memmoh76@gmail.com",
  //     phone: "01111240026",
  //     name: "moemen",
  //     password: "123456789");
  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //     .login(email: "memmoh76@gmail.com", password: "123456789");
  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //     .addNewMeal(mealData: {
  //   "meal_name": "shawarma",
  //   "meal_preparation_time": 14,
  //   "meal_text_summary": " ",
  //   "meal_nutrations": {
  //     "protein": 0,
  //     "carp": 0,
  //     "fat": 0,
  //     "kcal": 0,
  //     "vitamens": 0
  //   },
  //   "meal_ingrediants": {"bread": 2},
  //   "meal_steps": {"step1": " ", "step2": " "}
  // });
  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //     .addNewMeal(mealData: {
  //   "meal_name": "mlokhia",
  //   "meal_preparation_time": 14,
  //   "meal_text_summary": " ",
  //   "meal_nutrations": {
  //     "protein": 0,
  //     "carp": 0,
  //     "fat": 0,
  //     "kcal": 0,
  //     "vitamens": 0
  //   },
  //   "meal_ingrediants": {"bread": 2},
  //   "meal_steps": {"step1": " ", "step2": " "}
  // });
  final data =
      await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
          .fetchUserMeals();
  data.fold((l)=>print(l.errorMessage),(r)=>print(r));
  runApp(ProviderScope(child: MyApp()));
}
