import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint
import 'package:prepai/Core/di/di.dart';
import 'package:prepai/features/food_chat/data/models/message_model.dart';
import 'package:prepai/features/food_chat/domain/use_cases/get_food_suggestion.dart';
import 'package:uuid/uuid.dart';

final chatMessagesProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(getIt<GetFoodSuggestion>(), getIt<FirebaseFirestore>()),
);

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final GetFoodSuggestion _getFoodSuggestion;
  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  ChatNotifier(this._getFoodSuggestion, this._firestore) : super([]) {
    _loadMessages(); // Load messages when initialized
  }

  /// Load chat messages from Firestore
  Future<void> _loadMessages() async {
    try {
      final snapshot = await _firestore
          .collection('chats')
          .orderBy('createdAt', descending: false) // Sort by time
          .get();

      final messages =
          snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList();
      state = messages;
    } catch (e) {
      debugPrint("Error loading chat messages: $e");
    }
  }

  Future<void> sendMessage(String text) async {
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      text: text,
      isUser: true,
      createdAt: DateTime.now(),
      sender: 'user',
    );

    await _saveMessageToFirestore(userMessage);
    state = [...state, userMessage];

    final botResponse = await _getFoodSuggestion.call(text);

    final botMessage = ChatMessage(
      id: _uuid.v4(),
      text: botResponse,
      isUser: false,
      createdAt: DateTime.now(),
      sender: 'user',
    );

    await _saveMessageToFirestore(botMessage);
    state = [...state, botMessage];
  }

  Future<void> _saveMessageToFirestore(ChatMessage message) async {
    try {
      await _firestore
          .collection('chats')
          .doc(message.id)
          .set(message.toMap()); // Use `set` to avoid duplicates
    } catch (e) {
      debugPrint("Error saving chat message: $e");
    }
  }
}
