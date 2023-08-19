import 'package:equatable/equatable.dart';
import 'package:test_task_kz/features/login/domain/entity/token.dart';
import 'package:test_task_kz/features/login/domain/entity/user_entity.dart';

class AuthEntity extends Equatable{
  @UserConverter()
  final UserEntity user;
  @TokenConverter()
  final TokenEntity tokens;
  const AuthEntity({this.user = const UserEntity(), this.tokens = const TokenEntity()});
  @override
  List<Object?> get props => [user, tokens];
}