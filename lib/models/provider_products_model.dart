class ProviderProductsModel {
  String? message;
  bool? status;
  Data? data;

  ProviderProductsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<ProductData>? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(ProductData.fromJson(v));
      });
    }
  }

}

class ProductData {
  String? id;
  String? title;
  String? description;
  String? titleEn;
  String? descriptionEn;
  ProviderId? providerId;
  String? categoryId;
  String? opeingStatus;
  String? categoryOrderDaysType;
  int? totalRate;
  bool? isFavorited;
  List<Reviews>? reviews;
  List<Types>? types;
  List<Extra>? extras;
  List<Sizes>? sizes;
  List<String>? images;
  String? mainImage;
  String? priceAfterDiscount;

  ProductData();
  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    opeingStatus = json['opeing_status'];
    priceAfterDiscount = json['price_after_discount'].toString();
    description = json['description'];
    titleEn = json['title_en'];
    descriptionEn = json['description_en'];
    providerId = json['provider_id'] != null
        ? new ProviderId.fromJson(json['provider_id'])
        : null;
    categoryId = json['category_id'];
    categoryOrderDaysType = json['category_order_days_type'];
    totalRate = json['total_rate'];
    isFavorited = json['is_favorited'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types!.add(Types.fromJson(v));
      });
    }
    if (json['extras'] != null) {
      extras = <Extra>[];
      json['extras'].forEach((v) {
        extras!.add(Extra.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    mainImage = json['main_image'];
  }

}

class ProviderId {
  String? id;
  String? name;
  String? address;
  String? image;
  String? opeingStatus;

  ProviderId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    image = json['image'];
    opeingStatus = json['opeing_status'];
  }

}

class Reviews {
  String? id;
  String? userName;
  int? rate;
  String? content;

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    rate = json['rate'];
    content = json['content'];
  }

}

class Sizes {
  String? id;
  String? name;
  String? priceBeforeDiscount;
  String? priceAfterDiscount;


  Sizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priceBeforeDiscount = json['price_before_discount'].toString();
    priceAfterDiscount = json['price_after_discount'].toString();
  }

}

class Types {
  String? id;
  String? name;
  int? price;

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

}

class Extra {
  String? id;
  String? name;
  int? price;


  Extra.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

}
extension ExtraList on List<Extra> {
  List<Extra> withoutNulls() {
    return where((extra) => extra.name != ""  ).toList();
  }
}
extension TypesList on List<Types> {
  List<Types> typesWithoutNulls() {
    return where((type) => type.name != ""  ).toList();
  }
}
