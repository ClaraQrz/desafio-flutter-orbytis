import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspecampo/repositories/auth_repository.dart';
import 'package:inspecampo/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.repo) : super(const LoginState.initial()) {
    on<LoginSubimitted>(_onSubmitted);
    }
    final AuthRepository _repo;

  Future<void> _onSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(const LoginState.failure('Preencha e-mail e senha. '));
      return;
  }
    emit(const LoginState.loading());
    try {
      final user = await _repo.login(event.email,event.password);
      emit(LoginState.success(user));
    } on AuthException catch (e) {
      emit(LoginState.failure(e.message));
    }


  }
}
