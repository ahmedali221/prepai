import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prepai/core/theme/app_colors.dart';
import 'package:prepai/features/food_chat/presentation/providers/food_chat_provider.dart';

class ChatInputField extends StatefulWidget {
  final WidgetRef ref;

  const ChatInputField({super.key, required this.ref});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  String _selectedMealType = 'Breakfast'; 

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      widget.ref
          .read(chatMessagesProvider.notifier)
          .sendMessage(_controller.text, _selectedMealType); 
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 50.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter your ingredients and your goal",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            DropdownButton<String>(
              value: _selectedMealType,
              onChanged: (newValue) {
                setState(() {
                  _selectedMealType = newValue!;
                });
              },
              items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                  .map((mealType) => DropdownMenuItem(
                        value: mealType,
                        child: Text(mealType),
                      ))
                  .toList(),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _sendMessage,
              child: CircleAvatar(
                backgroundColor: AppColors.secondaryColor,
                radius: 24.r,
                child: Icon(Icons.send, color: Colors.white, size: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
