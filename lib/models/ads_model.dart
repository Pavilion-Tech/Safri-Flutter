class AdsModel {
  String? message;
  bool? status;
  Data? data;

  AdsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<ImageAdvertisements>? imageAdvertisements;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['image_advertisements'] != null) {
      imageAdvertisements = <ImageAdvertisements>[];
      json['image_advertisements'].forEach((v) {
        imageAdvertisements!.add(ImageAdvertisements.fromJson(v));
      });
    }
  }

}

class ImageAdvertisements {
  String? id;
  String? link;
  String? backgroundImage;
  int? advertisementViewType;
  int? type;


  ImageAdvertisements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    advertisementViewType = json['advertisement_view_type'];
    backgroundImage = json['background_image'];
    type = json['type'];
  }

}
