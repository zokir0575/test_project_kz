part of 'login_bloc.dart';

@Freezed()
  class LoginEvent with _$LoginEvent{
  factory LoginEvent.login({Function()? onSuccess, Function(String message)? onError, required LoginModel userModel}) = _Login;
}
