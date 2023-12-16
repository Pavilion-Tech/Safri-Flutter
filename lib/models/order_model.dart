class OrderModel {
  String? message;
  bool? status;
  Data? data;

  OrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<OrderData>? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }

}

class OrderData {
  String? id;
  int? status;
  int? itemNumber;
  String? providerName;
  String? providerPhone;
  String? providerImage;
  int? noOfPeople;
  List<UserAddress>? userAddress;
  int? numberOfTable;
  List<Products>? products;
  int? serviceType;
  String? shippingCharges;
  String? paymentMethod;
  int? dinnerType;
  dynamic appFees;
  dynamic vatValue;
  dynamic subTotalPrice;
  dynamic totalPrice;
  String? createdAt;
  String? colorOfCar;
  String? additionalNotes;
  String? numberOfCar;
  String? providerId;


  OrderData.fromJson(Map<String, dynamic> json) {
    appFees = json['app_fees'];
    dinnerType = json['dinner_type'];
    providerId = json['provider_id'];
    paymentMethod = json['payment_method'];
    vatValue = json['vat_value'];
    numberOfCar = json['number_of_car'];
    id = json['id'];
    if (json['user_address'] != null) {
      userAddress = <UserAddress>[];
      json['user_address'].forEach((v) {
        userAddress!.add( UserAddress.fromJson(v));
      });
    }
    shippingCharges = json['shipping_charges'].toString();
    additionalNotes = json['additional_notes'];
    colorOfCar = json['color_of_car'];
    status = json['status'];
    itemNumber = json['item_number'];
    providerName = json['provider_name'];
    providerPhone = json['provider_phone'];
    providerImage = json['provider_image'];
    noOfPeople = json['no_of_people'];
    numberOfTable = json['no_of_table'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    serviceType = json['service_type'];
    subTotalPrice = json['sub_total_price'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
  }

}

class Products {
  String? id;
  String? title;
  String? image;
  String? totalRate;
  String? priceAfterDiscount;
  String? orderedQuantity;


  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    totalRate = json['total_rate'].toString();
    priceAfterDiscount = json['price_after_discount'].toString();
    orderedQuantity = json['ordered_quantity'].toString();
  }

}
class UserAddress {
  String? id;
  String? title;

  UserAddress({this.id, this.title});

  UserAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
