import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/Meals/data/datasources/meal_remote_data_source.dart';
import 'package:prepai/features/Meals/data/repositories/meal_repository_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final mealRemoteDataSourceProvider = Provider<MealRemoteDataSource>((ref) {
  return MealRemoteDataSourceImpl(firestore: FirebaseFirestore.instance);
});

final mealRepositoryProvider = Provider<MealRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(mealRemoteDataSourceProvider);
  return MealRepositoryImpl(remoteDataSource: remoteDataSource);
});
