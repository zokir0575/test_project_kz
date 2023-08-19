import 'dart:async';

import 'package:test_task_kz/core/exceptions/exceptions.dart';
import 'package:test_task_kz/core/exceptions/failures.dart';
import 'package:test_task_kz/core/utils/either.dart';
import 'package:test_task_kz/core/utils/my_functions.dart';
import 'package:test_task_kz/features/login/data/datasource/login_datasource.dart';
import 'package:test_task_kz/features/login/data/model/login_model.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';
import 'package:test_task_kz/features/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, void>> login({required LoginModel userModel}) async {
    try {
      final result = await dataSource.login(userModel: userModel);
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


}
