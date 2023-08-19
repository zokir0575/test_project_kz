import 'package:json_annotation/json_annotation.dart';
import 'package:test_task_kz/features/login/domain/entity/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel extends LoginEntity {
  const LoginModel({super.password, super.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
