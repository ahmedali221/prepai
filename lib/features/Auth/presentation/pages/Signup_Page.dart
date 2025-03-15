import 'package:flutter/material.dart';
import 'package:prepai/features/Auth/presentation/widgets/Signup_view_body.dart';

void main() {
  runApp(SignupPage());
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return SignUpViewBody();
  }
}
