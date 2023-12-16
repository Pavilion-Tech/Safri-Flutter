class ContactUsModel {
  String? message;
  bool? status;
  Data? data;

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<ContactUsData>? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ContactUsData>[];
      json['data'].forEach((v) {
        data!.add(ContactUsData.fromJson(v));
      });
    }
  }

}

class ContactUsData {
  String? id;
  int? itemNumber;
  String? name;
  String? email;
  String? subject;
  String? message;
  String? createdAt;
  int? status;


  ContactUsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    email = json['email'];
    subject = json['subject'];
    message = json['message'];
    createdAt = json['created_at'];
    status = json['status'];
  }

}
