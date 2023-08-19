import 'package:test_task_kz/core/usecases/usecase.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/features/profile/domain/repository/profile_repository.dart';

class AuthStatusUseCase extends StreamUseCase<AuthStatus, NoParams> {
  final ProfileRepository repository;

  AuthStatusUseCase({required this.repository});

  @override
  Stream<AuthStatus> call(NoParams params) => repository.statusStream();
}
