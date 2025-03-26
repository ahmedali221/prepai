import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/errors/firebase_errors.dart';
import 'package:prepai/features/Meals/domain/entities/mealEntity.dart';
import 'package:prepai/features/Meals/domain/use_cases/mealsUseCases.dart';
import 'package:prepai/features/Meals/presentation/Riverpod/Meal_State.dart';

class MealNotifier extends StateNotifier<MealState> {
  final GetMealsUseCase mealsUseCase;

  MealNotifier(this.mealsUseCase) : super(MealState.initial());

  Future<Either<FirebaseFailure, List<MealEntity>>> FetchData() async {
    state = MealState.loading();
    final result = await mealsUseCase.call();
    return result;
  }
}
