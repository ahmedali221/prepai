import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepai/features/food_chat/data/data_sources/food_chat_remote_data_source.dart';
import 'package:prepai/features/food_chat/data/models/message_model.dart';
import '../../domain/repositories/food_chat_repository.dart';

class FoodChatRepositoryImpl implements FoodChatRepository {
  final FoodChatRemoteDataSource remoteDataSource;
  final FirebaseFirestore firestore; // Firestore instance

  FoodChatRepositoryImpl(this.remoteDataSource, this.firestore);

  @override
  Future<String> getFoodSuggestion(String prompt) async {
    // Save user message to Firestore
    final userMessage = ChatMessage(
      text: prompt,
      sender: 'user',
      timestamp: DateTime.now(),
    );
    await saveChatMessage(userMessage);

    // Get AI response
    final responseText = await remoteDataSource.getFoodSuggestion(prompt);

    // Save AI response to Firestore
    final aiMessage = ChatMessage(
      text: responseText,
      sender: 'ai',
      timestamp: DateTime.now(),
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
