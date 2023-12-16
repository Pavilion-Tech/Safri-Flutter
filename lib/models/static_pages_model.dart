class StaticPagesModel {
  String? message;
  bool? status;
  Data? data;

  StaticPagesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? termsAndConditiondsEn;
  String? termsAndConditiondsAr;
  String? aboutUsEn;
  String? aboutUsAr;


  Data.fromJson(Map<String, dynamic> json) {
    termsAndConditiondsEn = json['terms_and_conditionds_en'];
    termsAndConditiondsAr = json['terms_and_conditionds_ar'];
    aboutUsEn = json['about_us_en'];
    aboutUsAr = json['about_us_ar'];
  }

}
