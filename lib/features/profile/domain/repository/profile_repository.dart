import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/utils/either.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';

abstract class ProfileRepository{
  Future<Either<Failure, UserModel>> getUser();
  Stream<AuthStatus> statusStream();
}