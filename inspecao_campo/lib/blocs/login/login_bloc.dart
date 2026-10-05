import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/user.dart';
import '../../repositories/auth_repository.dart';
import '../../services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repo) : super(const LoginState.initial()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _repo;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (event.email.trim().isEmpty || event.password.isEmpty) {
      emit(
        const LoginState.failure(
          'Preencha e-mail e senha.',
        ),
      );
      return;
    }

    emit(const LoginState.loading());

    try {
      final user = await _repo.login(
        event.email.trim(),
        event.password,
      );

      emit(LoginState.success(user));
    } on AuthException catch (e) {
      emit(LoginState.failure(e.message));
    } catch (_) {
      emit(
        const LoginState.failure(
          'Ocorreu um erro inesperado. Tente novamente.',
        ),
      );
    }
  }
}