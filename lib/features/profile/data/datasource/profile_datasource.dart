import 'package:dio/dio.dart';
import 'package:test_task_kz/core/exceptions/exceptions.dart';
import 'package:test_task_kz/core/utils/shared_preferences.dart';
import 'package:test_task_kz/features/login/data/model/user_model.dart';

abstract class ProfileDatasource {
  Future<UserModel> getUser();
}

class ProfileDatasourceImpl implements ProfileDatasource {
  final Dio _dio;

  ProfileDatasourceImpl(this._dio);

  @override
  Future<UserModel> getUser() async {
    try {
      final response = await _dio.get(
        '/api/v1/auth/login/profile/',
        options: Options(headers: {
          'Authorization': 'Bearer ${StorageRepository.getString('token')}',
        }),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        print('nimadir');
        return UserModel.fromJson(response.data);
      } else {
        await StorageRepository.deleteString('token');
        if (response.data is Map) {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: ((response.data as Map).values.isNotEmpty
                  ? (response.data as Map).values.first
                  : 'Foydalanuvchi ma`lumotlarini olishda xato')
                  .toString());
        } else {
          throw ServerException(statusCode: response.statusCode!, errorMessage: response.data.toString());
        }
      }
    } on ServerException {
      rethrow;
    } on DioError {
      throw const DioException();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
