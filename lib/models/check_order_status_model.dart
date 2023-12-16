class CheckOrderStatusModel {
  String? message;
  bool? status;
  Data? data;

  CheckOrderStatusModel({this.message, this.status, this.data});

  CheckOrderStatusModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? completeOrderStatus;

  Data({this.completeOrderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    completeOrderStatus = json['complete_order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['complete_order_status'] = this.completeOrderStatus;
    return data;
  }
}