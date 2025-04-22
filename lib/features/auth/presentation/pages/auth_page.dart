
import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/auth_register_template.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/default_text_form_field.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  bool _obscure = true;

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthRegisterTemplate(
      showBackButton: true,
      hideLoginUsing: true,
      titleText:
          'Авторизуйтесь, чтобы получить полный доступ к возможностям платформы:',
      underTitleText: 'персональные настройки',
      content: Form(
        child: Column(
          children: [
            DefaultTextFormField(
              controller: emailController,
              hintText: 'Эл. почта',
              onChanged: (p0) => {setState(() {})},
            ),
            const SizedBox(
              height: Style.middleSpacing,
            ),
            DefaultTextFormField(
              controller: passwordController,
              obscureText: _obscure,
              suffixIcon: IconButton(
                icon: Icon(_obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
                onPressed: _toggleVisibility,
              ),
              hintText: 'Пароль',
              onChanged: (p0) => {setState(() {})},
            ),
            const SizedBox(
              height: Style.middleSpacing,
            ),
            DefaultElevatedButton(
              text: 'Далее',
              onPressed: () {},
              canTap: emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty,
            )
          ],
        ),
      ),
    );
  }
}
