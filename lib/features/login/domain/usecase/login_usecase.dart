import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/usecases/usecase.dart';
import 'package:test_task_kz/core/utils/either.dart';
import 'package:test_task_kz/features/login/data/model/login_model.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/login/domain/repository/login_repository.dart';

class LoginUseCase extends UseCase<void, LoginModel> {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(LoginModel model) =>
      repository.login(userModel: model);
}
