part of 'login_bloc.dart';

@Freezed()
class LoginState with _$LoginState{
  factory LoginState({
    @Default(FormzStatus.pure) FormzStatus status
}) = _LoginState;
}
