import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

class DioSettings {
  BaseOptions get baseOptions {
    return BaseOptions(
      baseUrl: 'http://45.10.110.181:8080',
      connectTimeout: 35000,
      receiveTimeout: 33000,
      headers: headers,
      validateStatus: (status) => status != null && status <= 500,
    );
  }

  Map<String, dynamic> get headers {
    return {'Accept-Language': "uz"};
  }

  BaseOptions get dioBaseOptions => baseOptions;

  Dio get dio {
    final dio = Dio(baseOptions);
    dio.interceptors.add(DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ));
    return dio;
  }
}
