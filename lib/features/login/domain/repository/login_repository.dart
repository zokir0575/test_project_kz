import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/utils/either.dart';
import 'package:test_task_kz/features/login/data/model/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, void>> login({required LoginModel userModel});
}
