import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'referrals_state.dart';

class ReferralsCubit extends Cubit<ReferralsState> {
  ReferralsCubit({ReferralsState? state}) : super(state ?? const ReferralsState());
}