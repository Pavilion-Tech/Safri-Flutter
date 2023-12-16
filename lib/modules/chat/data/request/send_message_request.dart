import 'dart:io';

import 'package:dio/dio.dart';

import '../../presentation/presentation/widget/image_picker_helper/compress_file.dart';


class SendMessageRequest {



  String? supportChatId;
  String? messageType;
  String? message;
  String? uploadedMessageFile;



  @override
  String toString() {
    return 'SendMessageRequest{supportChatId: $supportChatId, messageType: $messageType,   uploadedMessageFile: $uploadedMessageFile} }';
  }

  SendMessageRequest({  this.supportChatId, this.message,  this.messageType,
    this.uploadedMessageFile, });

  Future< Map<String, dynamic>> toRequest() async => {

   'support_chat_id':   supportChatId,
    if(message !=null) 'message': message,
    'message_type': messageType,


    if(uploadedMessageFile !=null) 'uploaded_message_file': await MultipartFile.fromFile(
      uploadedMessageFile!,
      filename:  uploadedMessageFile!.split('/').last,
    ),



  };












}