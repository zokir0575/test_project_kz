import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';

class UserEntity extends Equatable {
  final int id;
  final String nickname;
  final String email;

  const UserEntity({this.id = 0, this.email = '', this.nickname = ''});

  @override
  List<Object?> get props => [id, email, nickname];
}

class UserConverter
    implements JsonConverter<UserEntity, Map<String, dynamic>?> {
  const UserConverter();
  @override
  UserEntity fromJson(Map<String, dynamic>? json) =>
      UserModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(UserEntity object) =>
      UserModel(email: object.email, id: object.id, nickname: object.nickname).toJson();
}
