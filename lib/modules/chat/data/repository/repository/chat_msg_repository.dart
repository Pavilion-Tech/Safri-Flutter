
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../../../../shared/api/data_source/end_point.dart';
import '../../../../../shared/api/shared/shared_methods.dart';
import '../../../../../shared/error/error_handler/failure.dart';
import '../../request/send_message_request.dart';
import '../../response/chat_room_response.dart';
import '../../response/create_support_chat_response.dart';
import '../../response/send_message_response.dart';



abstract class ChatMsgRepository {
    Future<Either<Failure, ChatRoomResponse>> getChatMessages({required String id,  });
    Future<Either<Failure, CreateSupportChatResponse>> createSupportChat();
     Future<Either<Failure,  SendMessageResponse>> sendMessage({required SendMessageRequest sendMessageRequest });



}

class ChatMsgImplement implements ChatMsgRepository {



  @override
  Future<Either<Failure, CreateSupportChatResponse>> createSupportChat()async {
    return await handleResponse(
      endPoint: "${EndPoints.createSupportChat}",
      asObject: (e) => CreateSupportChatResponse.fromJson(e),
      method: DioMethod.post,
    );
  }
  @override
  Future<Either<Failure, ChatRoomResponse>> getChatMessages({required String id,   })async {
    return await handleResponse(
      endPoint: "${EndPoints.chatMessages}/$id",
      asObject: (e) => ChatRoomResponse.fromJson(e),
      method: DioMethod.get,

    );
  }

    @override
    Future<Either<Failure, SendMessageResponse>> sendMessage({required SendMessageRequest sendMessageRequest })async {
      Map<String, dynamic> req = await sendMessageRequest.toRequest();

       req.removeWhere((key, value) => value == null);

      return await handleResponse(
        endPoint:  EndPoints.sendMessage ,
        asObject: (e) => SendMessageResponse.fromJson(e),
        data: FormData.fromMap(req),
        method: DioMethod.post,
      );
    }




}
