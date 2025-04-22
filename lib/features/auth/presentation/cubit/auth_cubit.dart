import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moi_market/features/auth/domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repos;
  AuthCubit(this.repos, {AuthState? state}) : super(state ?? const AuthState());

  void setAuthUsing (AuthUsing item) {
    emit(state.copyWith(authUsing: item));
  }

}