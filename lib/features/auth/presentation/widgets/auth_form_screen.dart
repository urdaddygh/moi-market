import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/core/theme/style.dart';
import 'package:moi_market/core/utils/text_field_validators.dart';
import 'package:moi_market/core/widgets/default_custom_wrapper.dart';
import 'package:moi_market/core/widgets/default_elevated_button.dart';
import 'package:moi_market/core/widgets/default_text_form_field.dart';
import 'package:moi_market/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:moi_market/features/auth/presentation/cubit/auth_state.dart';
import 'package:moi_market/features/auth/presentation/widgets/auth_text.dart';

class AuthFormScreen extends StatefulWidget {
  const AuthFormScreen({super.key});

  @override
  State<AuthFormScreen> createState() => _AuthFormScreenState();
}

class _AuthFormScreenState extends State<AuthFormScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '+996555112233');
  final TextEditingController _passwordController = TextEditingController(text: '1q2w3e4r');
  bool _obscure = true;

  void _toggleVisibility() {
    setState(() {
      _obscure = !_obscure;
    });
  }
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Style.primaryWhiteColor,
        body: DefaultCustomWrapper(
          onTap: () => FocusScope.of(context).unfocus(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AuthText(),
              const SizedBox(
                height: Style.defaultSpacing * 2,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      DefaultTextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        hintText: 'Номер телефона',
                        validator: TextFieldValidators.cantBeEmptyValidator(context: context),
                      ),
                      const SizedBox(height: Style.defaultSpacing),
                      DefaultTextFormField(
                        controller: _passwordController,
                        validator: TextFieldValidators.cantBeEmptyValidator(context: context),
                        obscureText: _obscure,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Style.hintTextColor,
                          ),
                          onPressed: _toggleVisibility,
                        ),
                        hintText: 'Пароль',
                        onChanged: (p0) => {setState(() {})},
                      ),
                      const SizedBox(height: Style.bigSpacing * 2),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return DefaultElevatedButton(
                            isLoading: state.eventState == AuthEventState.loading,
                            text: 'Войти',
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                await BlocProvider.of<AuthCubit>(context).tryLogin(
                                  password: _passwordController.text,
                                  phone: _phoneController.text,
                                  context: context
                                );
                              }
                            },
                            color: _passwordController.text.isNotEmpty && _phoneController.text.isNotEmpty
                                ? Style.primaryColor
                                : Style.primaryLightGreyColor,
                          );
                        },
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
