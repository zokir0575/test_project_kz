import 'package:test_task_kz/features/login/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_task_kz/features/login/domain/entity/token.dart';
import 'package:test_task_kz/features/login/domain/entity/user_entity.dart';
part 'auth_model.g.dart';
@JsonSerializable()
class AuthModel extends AuthEntity{
  const AuthModel({super.tokens, super.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}