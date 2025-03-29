import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:prepai/features/food_chat/data/data_sources/food_chat_remote_data_source.dart';
import 'package:prepai/features/food_chat/data/models/message_model.dart';
import '../../domain/repositories/food_chat_repository.dart';

class FoodChatRepositoryImpl implements FoodChatRepository {
  final FoodChatRemoteDataSource remoteDataSource;
  final FirebaseFirestore firestore;
  final _uuid = const Uuid(); // Unique ID generator

  FoodChatRepositoryImpl(this.remoteDataSource, this.firestore);

  @override
  Future<String> getFoodSuggestion(String prompt, String mealType) async {
    // Save user message to Firestore
    final userMessage = ChatMessage(
      id: _uuid.v4(), // Unique ID
      text: prompt,
      sender: 'user',
      isUser: true,
      createdAt: DateTime.now(),
      mealType: mealType, // Include meal type
    );
    await saveChatMessage(userMessage);

    // Get AI response
    final responseText = await remoteDataSource.getFoodSuggestion(prompt);

    // Save AI response to Firestore
    final aiMessage = ChatMessage(
      id: _uuid.v4(), // Unique ID
      text: responseText,
      sender: 'ai',
      isUser: false,
      createdAt: DateTime.now(),
      mealType: mealType, // Include meal type
    );
    await saveChatMessage(aiMessage);

    return responseText;
  }

  Future<void> saveChatMessage(ChatMessage message) async {
    try {
      await firestore.collection('chats').add(message.toMap());
    } catch (e) {
      print("Error saving chat message: $e");
    }
  }
}
