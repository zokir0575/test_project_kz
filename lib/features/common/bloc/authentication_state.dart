part of 'authentication_bloc.dart';


class AuthenticationState {
  final AuthStatus status;
  final UserModel user;
  const AuthenticationState._({required this.status, required this.user});
  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AuthStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(status: AuthStatus.unAuthenticated, user: const UserModel());
}
