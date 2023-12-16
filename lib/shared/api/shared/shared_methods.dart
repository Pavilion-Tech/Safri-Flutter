// this method for only this project
import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
 import '../../error/error_handler/error_handler.dart';
import '../../error/error_handler/failure.dart';
import '../dio_helper.dart';

// ==================== other ====================
Color get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];



// ==================== dio ====================

Failure? _handleServerError(Map<String, dynamic> responseJson) {
  if (responseJson.containsKey("status")) {
    if (!responseJson["status"]) return Failure(-1, responseJson['message'], TypeMsg.error);
  }
  return null;
}

enum DioMethod { post, get, delete,put }

Future<Either<Failure, T>> handleResponse<T>({
  required String endPoint,
  dynamic data,
  DioMethod method = DioMethod.get,
  required T Function(Map<String, dynamic> map) asObject,
  Map<String, dynamic>? query,
  int? page,
  bool handleServerError=true,
}) async {
  try {
    query ??= {};
    if (page != null) query["page"] = page;
    Map<String, dynamic> json = {};
    if (method == DioMethod.get) json = await DioHelper1.getData(uri: endPoint, query: query);
    if (method == DioMethod.post) json = await DioHelper1.postData(uri: endPoint, data: data, query: query);
    if (method == DioMethod.put) json = await DioHelper1.putData(uri: endPoint, data: data, query: query);
    if (method == DioMethod.delete) json = await DioHelper1.deleteData(uri: endPoint, data: data, query: query);
     if(handleServerError) if (_handleServerError(json) != null) return left(_handleServerError(json)!);

    return right(asObject(json));
  } catch (e, s) {
    if (kDebugMode) print("ERROR IN handleResponse : $e \n\n$s");

    return left(ErrorHandlerCustom.handle(e).failure);
  }


}
