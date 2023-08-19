import 'package:dio/dio.dart';
import 'package:test_task_kz/core/exceptions/exceptions.dart';
import 'package:test_task_kz/core/utils/shared_preferences.dart';
import 'package:test_task_kz/features/login/data/model/login_model.dart';

abstract class LoginDataSource {
  Future<void> login({required LoginModel userModel});
}

class LoginDataSourceImpl implements LoginDataSource {
  final Dio _dio;

  LoginDataSourceImpl(this._dio);

  @override
  Future<void> login({required LoginModel userModel}) async {
    try {
      final response = await _dio.post(
        '/api/v1/auth/login/',
        data: userModel.toJson(),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print("${response.data}"  "------");
        await StorageRepository.putString("token", response.data['tokens']['accessToken']);
      } else if (response.statusCode != null &&
          response.statusCode! >= 400 &&
          response.statusCode! < 500) {
        if (response.data is Map) {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: ((response.data as Map).values.isNotEmpty
                      ? (response.data as Map).values.first
                      : 'Login parol xato')
                  .toString());
        } else {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: response.data.toString());
        }
      } else {
        throw ServerException(
            statusCode: response.statusCode!,
            errorMessage: response.data.toString());
      }
    } on ServerException {
      rethrow;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
