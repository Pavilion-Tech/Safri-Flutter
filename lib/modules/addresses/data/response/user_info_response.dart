class UserInfoResponse {
  String? message;
  bool? status;
  UserData? data;

  UserInfoResponse({this.message, this.status, this.data});

  UserInfoResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  int? itemNumber;
  String? name;
  String? phoneNumber;
  String? userUniqueNumber;
  int? noOfPoints;
  String? gender;
  String? dateOfBirth;
  String? whatsappNumber;
  String? firebaseToken;
  String? currentLanguage;
  String? personalPhoto;
  String? email;
  int? status;
  List<UserPointsLogs>? userPointsLogs;
  String? apiToken;

  UserData(
      {this.id,
        this.itemNumber,
        this.name,
        this.phoneNumber,
        this.userUniqueNumber,
        this.noOfPoints,
        this.gender,
        this.dateOfBirth,
        this.whatsappNumber,
        this.firebaseToken,
        this.currentLanguage,
        this.personalPhoto,
        this.email,
        this.status,
        this.userPointsLogs,
        this.apiToken});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    userUniqueNumber = json['user_unique_number'];
    noOfPoints = json['no_of_points'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    whatsappNumber = json['whatsapp_number'];
    firebaseToken = json['firebase_token'];
    currentLanguage = json['current_language'];
    personalPhoto = json['personal_photo'];
    email = json['email'];
    status = json['status'];
    if (json['user_points_logs'] != null) {
      userPointsLogs = <UserPointsLogs>[];
      json['user_points_logs'].forEach((v) {
        userPointsLogs!.add(UserPointsLogs.fromJson(v));
      });
    }
    apiToken = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_number'] = itemNumber;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['user_unique_number'] = userUniqueNumber;
    data['no_of_points'] = noOfPoints;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['whatsapp_number'] = whatsappNumber;
    data['firebase_token'] = firebaseToken;
    data['current_language'] = currentLanguage;
    data['personal_photo'] = personalPhoto;
    data['email'] = email;
    data['status'] = status;
    if (userPointsLogs != null) {
      data['user_points_logs'] =
          userPointsLogs!.map((v) => v.toJson()).toList();
    }
    data['api_token'] = apiToken;
    return data;
  }
}

class UserPointsLogs {
  String? id;
  String? type;
  int? pointsAmount;
  int? priceAmount;
  String? date;

  UserPointsLogs(
      {this.id, this.type, this.pointsAmount, this.priceAmount, this.date});

  UserPointsLogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    pointsAmount = json['points_amount'];
    priceAmount = json['price_amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['points_amount'] = pointsAmount;
    data['price_amount'] = priceAmount;
    data['date'] = date;
    return data;
  }
}