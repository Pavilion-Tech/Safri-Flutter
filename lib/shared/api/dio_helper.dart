import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../network/local/cache_helper.dart';
import 'data_source/end_point.dart';

class DioHelper1 {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return (status??0) < 500;
        },
        connectTimeout: const Duration(seconds:  60),
        receiveTimeout: const Duration(seconds:  60),
        sendTimeout: const Duration(seconds:  60),

      ),
    );

// todo proxy

      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient();
          // Config the client.
          // client.findProxy = (uri) {
          //   return 'PROXY ${AppConstants.proxyUrl}:${AppConstants.proxyPort}';
          // };
          return client;
        },
      );

  }

  static Future<dynamic> getData({required String uri, Map<String, dynamic>? query}) async {
    _setInfo(uri,query.toString());
    return (await dio.get(uri, queryParameters: query)).data;
  }

  static Future<dynamic> postData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    _setInfo(uri,query.toString());
    return (await dio.post(uri, data: data, queryParameters: query)).data;
  }
  static Future<dynamic> putData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    _setInfo(uri,query.toString());
    return (await dio.put(uri, data: data, queryParameters: query)).data;
  }

  static Future<dynamic> deleteData({required String uri, dynamic data, Map<String, dynamic>? query}) async {
    _setInfo(uri,query.toString());
    return (await dio.delete(uri, data: data, queryParameters: query)).data;
  }

  // ========================================================

  static void _setInfo(String uri,[String qyery = ""]) {
    // LoggerHelper.loggerNoStack.i('Api Call : ' + uri + "  |  " + qyery);
    dio.options.headers = _getHeaders();
  }

  static Map<String, dynamic> _getHeaders() {
    String? token = CacheHelper.getData(key: "token");
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    headers['Authorization'] = 'Bearer $token';
    // String lang = navigatorKey.currentContext?.locale.languageCode.toLowerCase() ?? 'en';
    headers['Accept-Language'] = CacheHelper.getData(key: "lang");
    return headers;
  }
}
