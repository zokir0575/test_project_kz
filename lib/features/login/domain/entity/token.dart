import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_task_kz/features/login/data/model/token_model.dart';

class TokenEntity extends Equatable{
  final String accessToken;
  final String refreshToken;

  const TokenEntity({this.accessToken = '', this.refreshToken = ''});
  @override
  List<Object?> get props => [accessToken, refreshToken];
}


class TokenConverter
    implements JsonConverter<TokenEntity, Map<String, dynamic>?> {
  const TokenConverter();
  @override
  TokenEntity fromJson(Map<String, dynamic>? json) =>
      TokenModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(TokenEntity object) =>
      TokenModel(accessToken: object.accessToken, refreshToken: object.refreshToken).toJson();
}
