import 'dart:async';

import 'package:test_task_kz/core/exceptions/exceptions.dart';
import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/utils/either.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/profile/data/datasource/profile_datasource.dart';
import 'package:test_task_kz/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDatasource datasource;
  final StreamController<AuthStatus> _statusController =
  StreamController.broadcast(sync: true);

  ProfileRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, UserModel>> getUser()async {
    try{
      final result = await datasource.getUser();
      print('right');
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Stream<AuthStatus> statusStream() async* {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await getUser();
      yield AuthStatus.authenticated;
    } on Exception {
      yield AuthStatus.unAuthenticated;
    }
    yield* _statusController.stream;
  }
}
