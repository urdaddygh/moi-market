import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/auth_register_template.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/default_text_form_field.dart';
import 'package:moi_market/features/auth/presentation/widgets/auth_form_screen.dart';
import 'package:moi_market/features/auth/presentation/widgets/init_auth_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _obscure = true;
  bool showInitAuthScreen = true;

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }
  void _toggleScreen(){
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
    }
    return const AuthFormScreen();
  }
}
