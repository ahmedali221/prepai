import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';

abstract class MealRemoteDataSource {
  Future<List<Map<String, dynamic>>> getUserMeals(String userId);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final FirebaseFirestore firestore;

  MealRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Map<String, dynamic>>> getUserMeals(String userId) async {
    final snapshot = await firestore
        .collection(FirebaseConstants.usersCollectionName)
        .doc(userId)
        .collection(FirebaseConstants.usersMealsCollectionName)
        .get();

    return snapshot.docs.map((doc) => {"mealId": doc.id, ...doc.data()}).toList();
  }
}
