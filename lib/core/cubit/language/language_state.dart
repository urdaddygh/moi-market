import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_state.freezed.dart';

enum Language {
  ru,
  ky,
}

@freezed
class LanguageState with _$LanguageState {
  const factory LanguageState({
    @Default(Language.ru) Language language,
    String? message,
  }) = _Initial;
}