import 'package:flutter/material.dart';
import 'package:moi_market/features/auth/presentation/widgets/auth_form_screen.dart';
import 'package:moi_market/features/auth/presentation/widgets/init_auth_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showInitAuthScreen = true;

  void _toggleScreen() {
    setState(() {
      showInitAuthScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
      if (showInitAuthScreen) {
        return InitAuthScreen(
        onTap: () => _toggleScreen(),
      );
      } else {
        return const AuthFormScreen();
      }
  }
}
