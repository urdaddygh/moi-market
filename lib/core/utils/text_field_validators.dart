
import 'package:flutter/cupertino.dart';

class TextFieldValidators {
  static String? Function(dynamic) cantBeEmptyValidator({required BuildContext context}) {
    return (text) {
      if (text == null || (text.runtimeType == String ? text?.isEmpty : false)) return 'Поле не может быть пустым';
      return null;
    };
  }

  static String? Function(dynamic) cantBeLessThanFourCharValidator({required BuildContext context}) {
    return (text) {
      if (text == null || (text.runtimeType == String && text.length < 4)) {
        return 'Введите больше 4 символов';
      }
      return null;
    };
  }

  static String? Function(dynamic) requiredField({required BuildContext context}) {
    return (text) {
      if (text == null || (text.runtimeType == String ? text?.isEmpty : false)) return 'Обязательное поле';
      return null;
    };
  }

  static bool isValidPin(String text) {
    int gender = int.parse(text[0]);
    int day = int.parse(text.substring(1, 3));
    int month = int.parse(text.substring(3, 5));
    int year = int.parse(text.substring(5, 9));
    if (!(1 <= gender && gender <= 2)) {
      return false;
    }
    if (!(1 <= day && day <= 31)) {
      return false;
    }
    if (!(1 <= month && month <= 12)) {
      return false;
    }
    if (!(1800 <= year && year <= DateTime.now().year)) {
      return false;
    }
    return true;
  }
}
