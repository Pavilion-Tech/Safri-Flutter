import 'dart:async';
import 'package:dio/dio.dart';
import 'package:safri/shared/components/constant.dart';

class DioHelper {
  static late Dio dio;
  static late Response response;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://on-fast-api.ai2digital.com/',
        connectTimeout: const Duration(seconds:  60),
        receiveTimeout: const Duration(seconds:  60),
        sendTimeout: const Duration(seconds:  60),
        receiveDataWhenStatusError: true,
        validateStatus: (status) => true,
        followRedirects: true,
      ),
    );
  }

  static Future<Response> getData(
      {
        required String url,
        Map<String , dynamic>? data,
        Map<String, dynamic>? query,
        String? token,
        String? lang,
      }) async {

    dio.options.headers =
    {
      'lang':myLocale ,
      'Authorization': "$token" ,//'Bearer $token'
      'Content-Type': 'application/json',
      'Accept-Language': myLocale,
    };
      return response = await dio.get(url, queryParameters: query,data: data,);

  }

  static Future<Response> deleteData(
      {
        required String url,
        Map<String , dynamic>? data,
        Map<String, dynamic>? query,
        String? token,
        String? lang,
      }) async {

    dio.options.headers =
    {
      'lang':myLocale ,
      'Authorization':token ,
      'Content-Type': 'application/json',
      'Accept-Language': myLocale,
    };
      return response = await dio.delete(url, queryParameters: query,data: data);

  }

  static Future<Response> postData({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String? lang ,


  }) async {
    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':token ,
      'lang':myLocale ,
      'Accept-Language': myLocale,

    };

    return response = await dio.post(url, data: data,);
  }

  static Future<Response> postData2({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String? lang ,
    FormData? formData,


  }) async {

    dio.options.headers =
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization':token ,
      'lang':myLocale ,
      'Accept-Language': myLocale,

    };

    return response = await dio.post(url, data: formData,);
  }


  static Future<Response> putData({
    required String url,
    Map<String , dynamic>? data,
    String? token,
    String lang = 'en',
    FormData? formData,


  }) async {
    dio.options.headers =
    {
      'lang':myLocale ,
      'Authorization':token ,
      'Content-Type': 'application/json',
      'Accept-Language': myLocale,
    };
    return response = await dio.put(url, data: data??formData);
  }
}
