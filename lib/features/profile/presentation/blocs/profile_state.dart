part of 'profile_bloc.dart';

@Freezed()
class ProfileState with _$ProfileState{
  factory ProfileState({
    @Default(FormzStatus.pure) FormzStatus status,
    @Default(UserModel()) UserModel profile
}) =_ProfileState;
}
