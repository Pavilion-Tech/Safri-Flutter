import '../../presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../model/chat_messages_model.dart';

class ChatRoomResponse {
  String? message;
  bool? status;
  ChatRoomData? data;

  ChatRoomResponse({this.message, this.status, this.data});

  ChatRoomResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  ChatRoomData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChatRoomData {
  String? id;
  int? itemNumber;
  int? status;
  List<SupportChat>? supportChat;
  String? createdAt;

  ChatRoomData(
      {this.id,
        this.itemNumber,
        this.status,
        this.supportChat,
        this.createdAt});

  ChatRoomData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemNumber = json['item_number'];
    status = json['status'];
    if (json['support_chat'] != null) {
      supportChat = <SupportChat>[];
      json['support_chat'].forEach((v) {
        supportChat!.add( SupportChat.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['item_number'] = this.itemNumber;
    data['status'] = this.status;
    if (this.supportChat != null) {
      data['support_chat'] = this.supportChat!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}

class SupportChat {
  bool? isMine;
  int? messageType;
  String? sender;
  String? message;
  String? uploadedMessageFile;
  String? date;

  SupportChat(
      {this.isMine,
        this.messageType,
        this.sender,
        this.message,
        this.uploadedMessageFile,
        this.date});

  SupportChat.fromJson(Map<String, dynamic> json) {
    isMine = json['is_mine'];
    messageType = json['message_type'];
    sender = json['sender'];
    message = json['message'];
    uploadedMessageFile = json['uploaded_message_file'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['is_mine'] = this.isMine;
    data['message_type'] = this.messageType;
    data['sender'] = this.sender;
    data['message'] = this.message;
    data['uploaded_message_file'] = this.uploadedMessageFile;
    data['date'] = this.date;
    return data;
  }
}

extension ChatMessagesModelExtension on   SupportChat? {
  ChatMessagesModel toChatMessagesModel() {

    return ChatMessagesModel(
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