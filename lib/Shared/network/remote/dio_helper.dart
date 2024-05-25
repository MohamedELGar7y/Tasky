import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://todo.iraqsapp.com/',
          receiveDataWhenStatusError: true,
          headers: {
            'Host': '<calculated when request is sent>',
          }),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio?.options.headers = {
      "Authorization": "Bearer $token",
    };
    return await dio?.get(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response?> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      "Authorization": "Bearer $token",
    };
    return await dio?.delete(
      url,
      queryParameters: query,
    );
  }

  static Future<Response?> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      "Authorization": "Bearer $token",
    };
    return await dio?.post(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );
  }

  static Future<Response?> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio?.options.headers = {
      "Authorization": "Bearer $token",
    };
    return await dio?.put(
      url,
      queryParameters: query,
      data: data,
      options: Options(
        followRedirects: false,
        validateStatus: (status) => true,
      ),
    );
  }
}
