import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/usecases/usecase.dart';
import 'package:test_task_kz/core/utils/either.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/profile/domain/repository/profile_repository.dart';

class ProfileUseCase extends UseCase<UserModel, NoParams> {
  final ProfileRepository repository;

  ProfileUseCase({required this.repository});

  @override
  Future<Either<Failure, UserModel>> call(params) => repository.getUser();
}
