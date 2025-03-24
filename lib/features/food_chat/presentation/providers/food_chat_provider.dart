import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/features/food_chat/data/models/message_model.dart';
import 'package:prepai/features/food_chat/domain/use_cases/get_food_suggestion.dart';
import 'package:uuid/uuid.dart';


final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(getIt<GetFoodSuggestion>()),
);

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final GetFoodSuggestion _getFoodSuggestion;
  final _uuid = const Uuid();

  ChatNotifier(this._getFoodSuggestion) : super([]);

  Future<void> sendMessage(String text) async {
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      text: text,
      isUser: true,
      createdAt: DateTime.now(),
    );

    state = [...state, userMessage];

    final botResponse = await _getFoodSuggestion.call(text);

    final botMessage = ChatMessage(
      id: _uuid.v4(),
      text: botResponse,
      isUser: false,
      createdAt: DateTime.now(),
    );

    state = [...state, botMessage];
  }
}
