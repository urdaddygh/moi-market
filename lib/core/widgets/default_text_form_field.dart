import 'package:flutter/material.dart';
import 'package:moi_market/core/theme/style.dart';

class DefaultTextFormField extends StatefulWidget {
  const DefaultTextFormField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.startsWithPlus = false,
  });

  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool startsWithPlus;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    // Добавляем слушатель для автоматического вставления +
    if (widget.startsWithPlus) {
      _controller.addListener(() {
        final text = _controller.text;
        if (text.isNotEmpty && !text.startsWith('+')) {
          _controller.text = '+$text';
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); // только если мы сами создавали контроллер
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Style.textFormFieldStyle,
      validator: widget.validator,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      controller: _controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}
