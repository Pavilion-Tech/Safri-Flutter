class CategoriesModel {
  String? message;
  bool? status;
  List<CategoryData>? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }

}

class CategoryData {
  String? id;
  String? title;
  String? image;

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

}
