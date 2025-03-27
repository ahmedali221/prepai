import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepai/features/food_chat/presentation/providers/food_chat_provider.dart';
import 'package:prepai/features/food_chat/presentation/widgets/chat_bubble.dart';
import 'package:prepai/features/food_chat/presentation/widgets/chat_input_field.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessages = ref.watch(chatMessagesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final msg = chatMessages[index];
                return ChatBubble(
                  text: msg.text,
                  isUser: msg.isUser,
                  timestamp: msg.createdAt,
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          ChatInputField(ref: ref),
        ],
      ),
    );
  }
}
