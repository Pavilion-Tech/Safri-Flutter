class AddressesResponse {
  String? message;
  bool? status;
  List<AddressesData>? data;

  AddressesResponse({this.message, this.status, this.data});

  AddressesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <AddressesData>[];
      json['data'].forEach((v) {
        data!.add(AddressesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressesData {
  String? id;
  String? userId;
  String? latitude;
  String? longitude;
  String? address;
  String? title;
  bool? isDefault;

  AddressesData(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.address,
        this.title,
        this.isDefault});

  AddressesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    title = json['title'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['title'] = title;
    data['is_default'] = isDefault;
    return data;
  }
}