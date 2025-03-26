import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/data/repositories/meal_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final mealRepositoryProvider = Provider<MealRepositoryImpl>((ref) {
  return MealRepositoryImpl(firestore: FirebaseFirestore.instance);
});