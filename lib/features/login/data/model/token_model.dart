import 'package:test_task_kz/features/login/domain/entity/token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenModel extends TokenEntity{
  const TokenModel({super.refreshToken, super.accessToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}