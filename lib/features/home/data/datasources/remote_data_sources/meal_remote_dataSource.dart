// features/meal/data/datasources/meal_remote_data_source.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/Core/utils/firebase_constants.dart';
import 'package:prepai/features/home/data/models/mealsModel.dart';

class MealRemoteDataSource {
  final FlutterSecureStorage storage;
  final FirebaseFirestore firestore;

  MealRemoteDataSource(this.storage, this.firestore);

  Future<Either<FirebaseFailure, List<MealModel>>> fetchUserMeals(
      {int? mealPreparationTime,
      String? mealName,
      String? mealType,
      bool? isFavorite}) async {
    try {
      final userId = await storage.read(key: "userId");

      CollectionReference<Map<String, dynamic>> mealsCollection = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName);

      CollectionReference<Map<String, dynamic>> favoriteMealsCollection =
          firestore
              .collection(FirebaseConstants.usersCollectionName)
              .doc(userId)
              .collection(FirebaseConstants.usersFavoriteMealsCollectionName);

      // التحقق مما إذا كانت هناك وجبات موجودة بالفعل
      QuerySnapshot<Map<String, dynamic>> existingMeals =
          await mealsCollection.get();

      if (existingMeals.docs.isEmpty) {
        print("No meals found, adding default meal...");
        // إضافة وجبة افتراضية فقط إذا لم تكن هناك وجبات
        List<Map<String, dynamic>> fixedMeals = [
          {
            "meal_name": "Kofta",
            "meal_nutrations": {
              "carp": 100,
              "fat": 50,
              "kcal": 400,
              "protein": 300,
              "vitamens": 70,
            },
            "meal_preparation_time": 14,
            "meal_steps": {
              "step_1": "buy bread",
            },
            "meal_text_summary":
                "A flavorful Middle Eastern dish made from minced meat (usually beef or lamb) mixed with herbs, spices, and onions. It's often grilled or baked and served with rice, salad, or tahini sauce.",
            "meals_ingredients": {
              "bread": 1,
              "meat": 2,
            },
            "is_favourite": false,
            "meal_type": "Lunch",
          }
        ];

        DocumentReference<Map<String, dynamic>> docRef =
            mealsCollection.doc(); // إنشاء ID جديد للوجبة
        fixedMeals[0]['meal_id'] = docRef.id; // تخزين الـ meal_id داخل البيانات
        await docRef.set(fixedMeals[0]); // حفظ الوجبة في Firestore
      }

      // إنشاء استعلام للبحث عن الوجبات مع الفلاتر المطلوبة
      Query<Map<String, dynamic>> query =
          isFavorite == true ? favoriteMealsCollection : mealsCollection;

      if (mealName != null) {
        query = query
            .where('meal_name', isGreaterThanOrEqualTo: mealName)
            .where('meal_name', isLessThanOrEqualTo: '$mealName\uf8ff');
      }
      if (mealType != null) {
        query = query.where('meal_type', isEqualTo: mealType);
      }
      if (mealPreparationTime != null) {
        query = query.where('meal_preparation_time',
            isEqualTo: mealPreparationTime);
      }

      // جلب البيانات
      QuerySnapshot<Map<String, dynamic>> mealsSnapshot = await query.get();
      if (mealsSnapshot.docs.isEmpty) {
        return Left(FirebaseFailure('No meals found for this user.'));
      }

      List<MealModel> mealsList = mealsSnapshot.docs
          .map((doc) => MealModel.fromJson(doc.data()))
          .toList();

      print("Fetched meals: $mealsList");
      return Right(mealsList);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

////////////////////edit function to add meal in favortie collection
  Future<Either<FirebaseFailure, String>> addFavoriteMeal({
    required Map<String, dynamic> mealData,
  }) async {
    try {
      mealData['is_favourite'] = true; // تعيين كوجبة مفضلة
      final userId = await storage.read(key: "userId");

      // استخراج meal_id من بيانات الوجبة
      final String mealId = mealData['meal_id'];

      final mealRef = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersFavoriteMealsCollectionName)
          .doc(mealId);
      // استخدم نفس `meal_id`
      await firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName)
          .doc(mealId)
          .update({'is_favourite': true});

      await mealRef.set(mealData); // استخدم `set()` بدلًا من `add()`
      return Right('Meal added successfully!');
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }
  //////////////////////////////////////////////

  Future<Either<FirebaseFailure, void>> updateMealFavoriteStatus({
    required String mealId,
    required bool isFavorite,
  }) async {
    try {
      final userId = await storage.read(key: "userId");

      await firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName)
          .doc(mealId)
          .update({'is_favourite': isFavorite});

      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    } on Exception catch (e) {
      return Left(FirebaseFailure('Unknown error: $e'));
    }
  }

/////////////////////////////////////
  Future<Either<FirebaseFailure, void>> removeFavoriteMeal({
    required String mealId,
  }) async {
    try {
      final userId = await storage.read(key: "userId");
      final mealRef = firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersFavoriteMealsCollectionName)
          .doc(mealId);
      await firestore
          .collection(FirebaseConstants.usersCollectionName)
          .doc(userId)
          .collection(FirebaseConstants.usersMealsCollectionName)
          .doc(mealId)
          .update({'is_favourite': false});
      await mealRef.delete();
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(FirebaseFailure.fromFirestoreError(e));
    }
  }

  // Future<Either<FirebaseFailure, void>> addMeal(MealModel meal) async {
  //   try {
  //     final result = await addNewMeal(mealData: meal.toJson());
  //     return result.fold(
  //       (failure) => Left(failure),
  //       (_) {
  //         return const Right(null);
  //       },
  //     );
  //   } catch (e) {
  //     return Left(FirebaseFailure('Failed to add meal: $e'));
  //   }
  // }
}
