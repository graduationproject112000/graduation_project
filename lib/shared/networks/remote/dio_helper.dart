import 'dart:io';

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8000/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    String? token,
    Map<String, dynamic>? data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    return dio.post(url, data: data);
  }

  static Future<Response> uploadImageData(
      {required Map<String, dynamic> details,
      required String? token,
      required String url}) {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    FormData formData = FormData.fromMap(details);
    return dio.post(url, data: formData);
  }

  static Future<Response> uploadImage({
    required url,
    required List<File> files,
    required String? token,
    List? test,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    Map<String, dynamic> details = new Map();
    for (var i = 0; i < test!.length; i++) {
      details[test[i]] = await MultipartFile.fromFile(files[i].path,
          filename: files[i].path.split('/').last);
    }
    FormData formData = FormData.fromMap(details);
    return dio.post(url, data: formData);
  }
}
