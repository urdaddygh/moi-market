import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'personal_account_state.dart';

class PersonalAccountCubit extends Cubit<PersonalAccountState> {
  PersonalAccountCubit({PersonalAccountState? state}) : super(state ?? const PersonalAccountState());
}