import 'package:flutter/material.dart';
import '../../../../../Core/helper/formatters.dart';
import '../../../../../Core/utils/constants.dart';
import 'custom_profile_text_field.dart';

class TextFieldsSection extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  const TextFieldsSection({
    super.key,
    required this.userNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomProfileTextField(
          hintText: AppConsts.userNameHintText,
          controller: userNameController,
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          hintText: AppConsts.emailHintText,
          inputFormatters: [Formatters.emailRegExp],
          controller: emailController,
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          hintText: AppConsts.phoneHintText,
          inputFormatters: [Formatters.phoneNumbersRegExp],
          controller: phoneController,
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          obscureText: true,
          enableValidator: false,
          hintText: AppConsts.passwordHintText,
          controller: passwordController,
        ),
      ],
    );
  }
}
