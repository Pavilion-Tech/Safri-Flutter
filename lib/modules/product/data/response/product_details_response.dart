import '../../../../models/provider_products_model.dart';

class ProductDetailsResponse {
  String? message;
  bool? status;
  ProductData? data;

  ProductDetailsResponse({this.message, this.status, this.data});

  ProductDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  ProductData.fromJson(json['data']) : null;
  }

}







