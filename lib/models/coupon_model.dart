class CouponModel {
  String? message;
  bool? status;
  Data? data;


  CouponModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  bool? isApplied;
  int? discountValue;
  int? discountType;

  Data.fromJson(Map<String, dynamic> json) {
    isApplied = json['is_applied'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
  }
}
