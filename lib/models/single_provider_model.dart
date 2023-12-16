import 'package:safri/models/provider_category_model.dart';

class SingleProviderModel {
  String? message;
  bool? status;
  ProviderData? data;

  SingleProviderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? ProviderData.fromJson(json['data']) : null;
  }

}

