
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/widgets/auth_register_template.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/default_text_form_field.dart';
import 'package:moi_market/core/widgets/text_between_line.dart';
import 'package:moi_market/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:moi_market/features/auth/presentation/cubit/auth_state.dart';

class AuthUsingPage extends StatefulWidget {
  const AuthUsingPage({super.key});

  @override
  State<AuthUsingPage> createState() => _AuthUsingPageState();
}

class _AuthUsingPageState extends State<AuthUsingPage> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text: '');
 bool _obscure = true;

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }
  @override
  Widget build(BuildContext context) {
    return AuthRegisterTemplate(
      hideLoginUsing: true,
      backgroundColor: Style.primaryGreenColor,
        titleText:
            'Зарегистрируйтесь, чтобы получить полный доступ к возможностям платформы:',
        underTitleText: 'персональные настройки',
        content: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                TextBetweenLine(
                  endIndent: 10,
                  text:
                      'Вход с помощью ${state.authUsing == AuthUsing.gmail ? 'Gmail' : state.authUsing == AuthUsing.apple ? 'Apple' : 'Yandex'}',
                ),
                const SizedBox(
                  height: Style.middleSpacing,
                ),
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
                    icon: Icon(
                        _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: _toggleVisibility,
                  ),
                  hintText: 'Пароль',
                  onChanged: (p0) => {setState(() {})},
                ),
                const SizedBox(
                  height: Style.middleSpacing,
                ),
                DefaultElevatedButton(text: 'Далее', onPressed: () {}, canTap: emailController.text.isNotEmpty && passwordController.text.isNotEmpty,)
              ],
            );
          },
        ));
  }
}
