import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prepai/features/home/presentation/controllers/riverpods/user_password_riverpod.dart';
import 'package:prepai/features/home/presentation/controllers/riverpods/user_profile_riverpod.dart';
import '../../../../../Core/theme/app_colors.dart';
import '../../../../../Core/utils/constants.dart';
import '../widget/custom_button.dart';
import '../widget/profile_view_header.dart';
import '../widget/profile_view_image.dart';
import '../widget/side_bar.dart';
import '../widget/text_fields_section.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    Future.microtask(() {
      ref.read(userProfileNotifierProvider.notifier).fetchUserData();
      ref.read(userPasswordNotifierProvider.notifier).fetchPassword();
    });
  }

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
                    Consumer(builder: (context, ref, child) {
                      final userProfileState =
                          ref.watch(userProfileNotifierProvider);
                      final userPasswordState =
                          ref.watch(userPasswordNotifierProvider);

                      if (userProfileState.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (userProfileState.hasError) {
                        return Text('Error: ${userProfileState.error}');
                      } else if (userProfileState.value != null) {
                        final userData = userProfileState.value!;
                        final userPassword = userPasswordState.value;

                        userNameController.text = userData.userName;
                        emailController.text = userData.userEmail;
                        phoneController.text = userData.userPhone;
                        passwordController.text = userPassword ?? "";

                        return TextFieldsSection(
                          userNameController: userNameController,
                          emailController: emailController,
                          phoneController: phoneController,
                          passwordController: passwordController,
                        );
                      } else {
                        return const Text('No data available');
                      }
                    }),
                    const Expanded(child: SizedBox(height: 10)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Consumer(builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        final user =
                            ref.read(userProfileNotifierProvider.notifier);
                        final password =
                            ref.read(userPasswordNotifierProvider.notifier);
                        return CustomButton(
                          text: AppConsts.saveButton,
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.c001A3F,
                          radius: 14,
                          onPressed: () async {
                            await user.postUserData(
                                name: userNameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                            await password.changePassword(
                                newPassword: passwordController.text);
                          },
                        );
                      }),
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

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
