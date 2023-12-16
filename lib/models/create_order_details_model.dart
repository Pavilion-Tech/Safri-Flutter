import 'order_model.dart';

class CreatedOrderDetailsModel {
  String? message;
  bool? status;
  Data? data;

  CreatedOrderDetailsModel({this.message, this.status, this.data});

  CreatedOrderDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  OrderData? order;

  Data({this.order});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ?  OrderData.fromJson(json['order']) : null;
  }

 
}

