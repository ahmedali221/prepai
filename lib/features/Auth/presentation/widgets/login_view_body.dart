import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/app_routes.dart';
import 'package:prepai/Core/theme/app_colors.dart';
import 'package:prepai/Core/utils/assets.dart';
import 'package:prepai/Core/utils/constants.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_provider.dart';
import 'package:prepai/features/Auth/presentation/providers/auth_state.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_button.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_checkbox.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_divider.dart';
import 'package:prepai/features/Auth/presentation/widgets/custom_textfield.dart';
import 'package:prepai/features/Auth/presentation/widgets/social_button.dart';

class LoginViewBody extends ConsumerStatefulWidget {
  const LoginViewBody({super.key});

  @override
  ConsumerState<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends ConsumerState<LoginViewBody> {
  bool isChecked = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  Future<void> _login() async {
    final authNotifier = ref.read(authProvider.notifier);

    final result = await authNotifier.login(
      email: emailController.text.trim(),
      password: passController.text.trim(),
    );

    result.fold(
      (errorMessage) => _showErrorDialog(errorMessage.errorMessage),
      (_) => GoRouter.of(context).pushReplacement(AppRouter.kHomePage),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Login Error"),
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
    final authState = ref.watch(authProvider);

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
                      hintText: AppConsts.emailText,
                      controller: emailController,
                      prefixIcon: const Icon(Icons.email_outlined),
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
                      text: AppConsts.rememberMeText,
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 48),
                    if (authState.status == AuthState.loading())
                      const CircularProgressIndicator()
                    else
                      CustomButton(
                        text: AppConsts.loginText,
                        color: Colors.white,
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          await _login();
                        },
                      ),
                    const SizedBox(height: 24),
                    CustomDivider(text: 'or login with'),
                    const SizedBox(height: 45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          onTap: () {}, // TODO: Implement social login
                          image: AppAssets.facebook,
                          color: const Color.fromARGB(255, 2, 84, 152),
                        ),
                        const SizedBox(width: 53),
                        SocialButton(
                          onTap: () {}, // TODO: Implement social login
                          color: AppColors.primaryColor,
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
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kSignup);
                          },
                          child: const Text(
                            AppConsts.registerNowText,
                            style: TextStyle(color: AppColors.primaryColor),
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
