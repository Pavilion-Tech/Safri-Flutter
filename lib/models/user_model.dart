class UserModel {
  String? message;
  bool? status;
  Data? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? id;
  int? itemNumber;
  String? name;
  String? phoneNumber;
  String? whatsappNumber;
  String? firebaseToken;
  String? currentLanguage;
  String? personalPhoto;
  String? email;
  int? status;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    whatsappNumber = json['whatsapp_number'];
    firebaseToken = json['firebase_token'];
    currentLanguage = json['current_language'];
    personalPhoto = json['personal_photo'];
    status = json['status'];
  }

}
