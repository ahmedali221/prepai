import 'package:flutter/material.dart';
import '../../../../../Core/theme/App_Colors.dart';
import '../../../../../Core/utils/constants.dart';
import '../widget/custom_button.dart';
import '../widget/profile_view_header.dart';
import '../widget/profile_view_image.dart';
import '../widget/side_bar.dart';
import '../widget/text_fields_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const ProfileViewHeader(),
                    const SizedBox(height: 10),
                    const ProfileViewImage(),
                    const SizedBox(height: 10),
                    TextFieldsSection(
                        //userModel: userModel,
                        //userNameController: 'userNameController',
                        //emailController: emailController,
                        //phoneController: phoneController,
                        //passwordController: passwordController,
                        ),
                    const Expanded(child: SizedBox(height: 10)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomButton(
                        text: AppConsts.saveButton,
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.c001A3F,
                        radius: 14,
                        onPressed: () {},
                      ),
                    ),
                    const Expanded(child: SizedBox(height: 10)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
