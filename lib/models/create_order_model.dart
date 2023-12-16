import 'order_model.dart';

class CreateOrderModel {
  String? message;
  bool? status;
  Data? data;

  CreateOrderModel({this.message, this.status, this.data});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  OrderData? order;
  PaymentData? paymentData;

  Data({this.order, this.paymentData});

  Data.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ?  OrderData.fromJson(json['order']) : null;
    paymentData = json['payment_data'] != null
        ?  PaymentData.fromJson(json['payment_data'])
        : null;
  }

}

 

class PaymentData {
  bool? status;
  String? data;

  PaymentData({this.status, this.data});

  PaymentData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}