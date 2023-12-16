class CreateSupportChatResponse {
  String? message;
  bool? status;
  CreateSupportChatData? data;

  CreateSupportChatResponse({this.message, this.status, this.data});

  CreateSupportChatResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new CreateSupportChatData.fromJson(json['data']) : null;
  }

}

class CreateSupportChatData {
  String? userId;
  int? itemNumber;
  int? status;
  String? sId;

  String? createdAt;
  String? updatedAt;
  int? iV;

  CreateSupportChatData(
      {this.userId,
        this.itemNumber,
        this.status,
        this.sId,

        this.createdAt,
        this.updatedAt,
        this.iV});

  CreateSupportChatData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    itemNumber = json['item_number'];
    status = json['status'];
    sId = json['_id'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

}