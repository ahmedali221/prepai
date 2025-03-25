import 'package:flutter/material.dart';
import 'package:prepai/features/home/data/models/user_model.dart';
import '../../../../../Core/helper/formatters.dart';
import '../../../../../Core/utils/constants.dart';
import 'custom_profile_text_field.dart';

class TextFieldsSection extends StatelessWidget {
  final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  //final UserModel userModel;
  const TextFieldsSection({
    super.key,
    //required this.userModel
    required this.userNameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    //required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomProfileTextField(
          hintText: AppConsts.userNameHintText,
          controller: userNameController,
          onSaved: (userName) {
            //userModel.userName = userName!;
          },
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          hintText: AppConsts.emailHintText,
          inputFormatters: [Formatters.emailRegExp],
          controller: emailController,
          onSaved: (email) {
            //userModel.email = email!;
          },
        ),
        const SizedBox(height: 20),
        CustomProfileTextField(
          hintText: AppConsts.phoneHintText,
          inputFormatters: [Formatters.phoneNumbersRegExp],
          controller: phoneController,
          onSaved: (phone) {
            //userModel.phone = phone!;
          },
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
