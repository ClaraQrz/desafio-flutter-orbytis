part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = AuthStarted;
  const factory AuthEvent.loggedIn(User user) = AuthLoggedIn;
  const factory AuthEvent.logoutRequestd() = AuthLogoutRequested;
  const factory AuthEvent.sessionExpired() = AuthSessionExpired;
}
