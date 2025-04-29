import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moi_market/core/local_storage/local_storage.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({Language? initialLanguage}) : super(LanguageState(language: initialLanguage ?? Language.ky));

  Future<void> changeLanguage(Language language, {Function? callback}) async {
    if (state.language != language) {
      await GetIt.I.get<LocalStorage>().writeLanguageCode(language.name);
      emit(state.copyWith(language: language));
      if (callback != null) await callback();
    }
  }

  Locale currentLocale() {
    return Locale(state.language.name);
  }

  String get langCode => state.language.name;

  Language get language => state.language;
}