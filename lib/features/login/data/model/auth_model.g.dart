// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      tokens: json['tokens'] == null
          ? const TokenEntity()
          : const TokenConverter()
              .fromJson(json['tokens'] as Map<String, dynamic>?),
      user: json['user'] == null
          ? const UserEntity()
          : const UserConverter()
              .fromJson(json['user'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'user': const UserConverter().toJson(instance.user),
      'tokens': const TokenConverter().toJson(instance.tokens),
    };
