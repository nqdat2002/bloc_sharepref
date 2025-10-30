import 'package:bloc_sharepref/screens/login_screen.dart';
import 'package:bloc_sharepref/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthPageSwitcher extends StatefulWidget {
  const AuthPageSwitcher({super.key});

  @override
  State<AuthPageSwitcher> createState() => _AuthPageSwitcherState();
}
class _AuthPageSwitcherState extends State<AuthPageSwitcher> {
  bool showLogin = true;
  void toggle() {
    setState(() {
      showLogin = !showLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginScreen(onSwitchToSignUp: toggle)
        : SignUpScreen(onSwitchToLogin: toggle);
  }
}