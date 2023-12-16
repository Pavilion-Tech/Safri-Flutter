import '../../../../models/provider_category_model.dart';

class AllFavoriteProvidersModel {
  String? message;
  bool? status;
  AllFavoriteProvidersData? data;

  AllFavoriteProvidersModel({this.message, this.status, this.data});

  AllFavoriteProvidersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?   AllFavoriteProvidersData.fromJson(json['data']) : null;
  }


}

class AllFavoriteProvidersData {
  int? currentPage;
  int? pages;
  int? count;
  List<ProviderData>? data;

  AllFavoriteProvidersData({this.currentPage, this.pages, this.count, this.data});

  AllFavoriteProvidersData.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <ProviderData>[];
      json['data'].forEach((v) { data!.add(new ProviderData.fromJson(v)); });
    }
  }


}






class Reviews {
  String? id;
  int? rate;
  String? content;

  Reviews({this.id, this.rate, this.content});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['content'] = this.content;
    return data;
  }
}

