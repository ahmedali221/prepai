import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/app.dart';
import 'package:prepai/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (_, child) => const MyApp(),
      ),
    ),
  );
}

  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore).signUp(
  //     email: "memmoh76@gmail.com",
  //     phone: "01111240026",
  //     name: "moemen",
  //     password: "123456789");
  // final result = await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //     .login(email: "memmoh76@gmail.com", password: "qwertyuiop");
  // result.fold((l) => print(l.errorMessage), (r) => print(r));
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
  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //     .updateUserDocData( data: {
  //       "name":"Ali"
  //     });
  // final data =
  //     await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //         .fetchUserProfileData();
  // data.fold((l) => print(l.errorMessage), (r) => print(r));
  // FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore).logout();
  // final result2 =
  //     await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //         .getPassword();
  // result2.fold((l) => print(l.errorMessage), (r) => print(r));

  // await FirebaseService(firebaseAuth: firebaseAuth, firestore: firestore)
  //     .updatePassword(newPassword: "qwertyuiop");
