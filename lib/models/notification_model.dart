class NotificationModel {
  String? message;
  bool? status;
  Data? data;

  NotificationModel({this.message, this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<NotificationData>? data;

  Data({this.currentPage, this.pages, this.count, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(  NotificationData.fromJson(v));
      });
    }
  }


}

class NotificationData {
  String? id;
  String? title;
  String? body;
  String? createdAt;

  NotificationData({this.id, this.title, this.body, this.createdAt});

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    createdAt = json['created_at'];
  }


}