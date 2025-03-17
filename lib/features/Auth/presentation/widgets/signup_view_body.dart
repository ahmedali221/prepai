import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/app_routes.dart';
import 'package:prepai/Core/theme/app_colors.dart';
import 'package:prepai/Core/utils/assets.dart';
import 'package:prepai/Core/utils/constants.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_provider.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_button.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_checkbox.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_divider.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_textfield.dart';
import 'package:prepai/features/Auth/presentation/widgets/social_button.dart';

class SignUpViewBody extends ConsumerStatefulWidget {
  const SignUpViewBody({super.key});

  @override
  ConsumerState<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends ConsumerState<SignUpViewBody> {
  bool isChecked = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> _signUp() async {
    final authNotifier = ref.read(authProvider.notifier);

    if (!isChecked) {
      _showErrorDialog("You must agree to the terms and conditions.");
      return;
    }

    final result = await authNotifier.signUp(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passController.text.trim(),
    );

    result.fold(
      (errorMessage) => _showErrorDialog(errorMessage),
      (_) => GoRouter.of(context).pushReplacement(AppRouter.kHomePage),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sign Up Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(224, 4, 27, 61),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 34, horizontal: 25),
                child: Column(
                  children: [
                    Image.asset(AppAssets.loginLogo),
                    const SizedBox(height: 70),
                    CustomTextField(
                      hintText: AppConsts.fullNameText,
                      controller: fullNameController,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 22),
                    CustomTextField(
                      hintText: AppConsts.emailText,
                      controller: emailController,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    const SizedBox(height: 22),
                    CustomTextField(
                      hintText: AppConsts.phoneNumberText,
                      controller: phoneController,
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    const SizedBox(height: 22),
                    CustomTextField(
                      hintText: AppConsts.passwordText,
                      controller: passController,
                      prefixIcon: const Icon(Icons.lock_outline),
                      isPassword: true,
                    ),
                    const SizedBox(height: 15),
                    CustomCheckBox(
                      text: AppConsts.policyMessage,
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 48),
                    CustomButton(
                      text: AppConsts.registerText,
                      color: Colors.white,
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        await _signUp();
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomDivider(text: 'or sign up with'),
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          onTap: () {},
                          image: AppAssets.facebook,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 53),
                        SocialButton(
                          onTap: () {},
                          color: Colors.white,
                          image: AppAssets.google,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          AppConsts.notHaveAnAccountText,
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kLogin);
                          },
                          child: const Text(
                            AppConsts.registerNowText,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
