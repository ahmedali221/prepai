import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prepai/Core/Routes/App_Routes.dart';
import 'package:prepai/Core/utils/assets.dart';
import 'package:prepai/Core/utils/constants.dart';
import 'package:prepai/features/Auth/presentation/widgets/custome_button.dart';
import 'package:prepai/features/Auth/presentation/widgets/custome_check_box.dart';
import 'package:prepai/features/Auth/presentation/widgets/custome_divider.dart';
import 'package:prepai/features/Auth/presentation/widgets/custome_text_field.dart';
import 'package:prepai/features/Auth/presentation/widgets/social_button.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController fullnameController = TextEditingController();
    TextEditingController PhoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

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
              color: Color(0xff001A3F).withAlpha(180),
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
                    SizedBox(
                      height: 70,
                    ),
                    CustomeTextField(
                      hintText: AppConsts.fullNameText,
                      controller: fullnameController,
                      perfixIcon: Icon(Icons.person),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    CustomeTextField(
                      hintText: AppConsts.emailText,
                      controller: emailController,
                      perfixIcon: Icon(Icons.email_outlined),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    CustomeTextField(
                      hintText: AppConsts.PhoneNumberText,
                      controller: PhoneController,
                      perfixIcon: Icon(Icons.phone),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    CustomeTextField(
                      hintText: AppConsts.passwordText,
                      controller: passController,
                      perfixIcon: Icon(Icons.lock_outline),
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomeCheckBox(
                      text: AppConsts.PolicyMessage,
                      value: isChecked,
                      onChanged: (bool? newValue) {
                        setState(
                          () {
                            isChecked = newValue!;
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    CustomeButton(
                        text: AppConsts.RegisterText,
                        color: Colors.white,
                        onTap: () {}),
                    SizedBox(
                      height: 24,
                    ),
                    CustomeDivider(text: 'or login with'),
                    SizedBox(
                      height: 45,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialButton(
                          onTap: () {},
                          image: AppAssets.facebook,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 53,
                        ),
                        SocialButton(
                            onTap: () {},
                            color: Colors.white,
                            image: AppAssets.google),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppConsts.HaveAnAcountText,
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.kLogin);
                          },
                          child: Text(
                            AppConsts.RegisterNowText,
                            style: TextStyle(color: Colors.white),
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
