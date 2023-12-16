import 'package:safri/modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';

import '../model/chat_messages_model.dart';

class SendMessageResponse {
  String? message;
  bool? status;
  Data? data;

  SendMessageResponse({this.message, this.status, this.data});

  SendMessageResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  bool? isMine;
  int? messageType;
  String? sender;
  String? message;
  String? uploadedMessageFile;
  String? date;

  Data(
      {this.isMine,
        this.messageType,
        this.id,
        this.sender,
        this.message,
        this.uploadedMessageFile,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isMine = json['is_mine'];
    messageType = int.tryParse(json['message_type'].toString());
    sender = json['sender'];
    message = json['message'];
    uploadedMessageFile = json['uploaded_message_file'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_mine'] = this.isMine;
    data['message_type'] = this.messageType;
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['uploaded_message_file'] = this.uploadedMessageFile;
    data['date'] = this.date;
    return data;
  }
}
extension ChatMessagesModelExtension on   Data? {
  ChatMessagesModel toChatMessagesModel() {

    return ChatMessagesModel(
      id:   this?.id??"",
      date:   this?.date??"",
      messageType:     this?.messageType??-1,
      isMine:   this?.isMine??false,
      message:   this?.message??"",
      sender:    this?.sender??"",
      uploadedMessageFile: this?.uploadedMessageFile??"",
      state:   MsgState.success ,

      // chatTo: this?.chatTo??-1,
    );
  }
}