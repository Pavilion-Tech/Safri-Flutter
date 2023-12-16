
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main.dart';
import '../../../../../shared/components/uti.dart';
import '../../../../../shared/network/local/cache_helper.dart';
import '../../../data/model/chat_messages_model.dart';
import '../../../data/repository/repository/chat_msg_repository.dart';
import '../../../data/request/send_message_request.dart';
import '../../../data/response/chat_room_response.dart';
import '../../../data/response/create_support_chat_response.dart';
import '../../../data/response/send_message_response.dart';

import '../../presentation/widget/audio_helper/audio_helper.dart';
import 'chat_msg_state.dart';

class ChatMsgCubit extends Cubit<ChatMsgState> {
  ChatMsgCubit() : super(ChatMsgInitial());

  static ChatMsgCubit get(BuildContext context) => BlocProvider.of(context);

  final ScrollController controllerScroll = ScrollController();
  final ChatMsgRepository _repo = ChatMsgImplement();
  TextEditingController messageController = TextEditingController();
  TextEditingController captionImageMessage = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<ChatMessagesModel> messages = [];


  /// create support chat
  CreateSupportChatData createSupportChatData=CreateSupportChatData();
  Future<void> createSupportChat() async {
    // emit(CreateSupportChatLoadState());
    emit(ChatMsgLoadState());

    final res = await _repo.createSupportChat(  );
    res.fold(
      (l) {
        // UTI.showSnackBar(navigatorKey.currentContext, l.message, 'error');

        emit(CreateSupportChatErrorState());
      },
      (r) {
        if(r.status==true)
          UTI.showSnackBar(navigatorKey.currentContext, r.message, 'success');
        createSupportChatData = r.data!;
        CacheHelper.saveData(key: "chatId", value: createSupportChatData.sId.toString());
        emit(CreateSupportChatSuccessState());
         
        getChatMsg(id: createSupportChatData.sId??"");

      },
    );
  }


  /// get users
  Future<void> getChatMsg({
    required String id,


  }) async {
    if( CacheHelper.getData(key: "chatId")!=null) emit(ChatMsgLoadState());

    final res = await _repo.getChatMessages(id: id, );
    res.fold(
      (l) {
        // UTI.showSnackBar(navigatorKey.currentContext, l.message, 'error');

        emit(ChatMsgErrorState());
      },
      (r) {

          messages = r.data?.supportChat?.map((e) => e.toChatMessagesModel()).toList() ?? [];

         print("messages");
         print(messages.length);

        emit(ChatMsgSuccessState());



      },
    );
  }






  /// add messages
  void addMessages(ChatMessagesModel responseMessage) {

    messages.insert(0, responseMessage);
    emit(AddMessagesState());
  }

  /// send message
  Future<void> sendMessage({required SendMessageRequest sendMessageRequest}) async {
    emit(SendMessageLoadState());

    int tempId = Random().nextInt(9999999);
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('HH:mm a').format(now);
    ChatMessagesModel responseMessageModelOld =   ChatMessagesModel(
      state: MsgState.loading,
      date:formattedTime ,
       uploadedMessageFile:sendMessageRequest.uploadedMessageFile??"" ,
       messageType: int.tryParse(sendMessageRequest.messageType??""),
       isMine: true,
       message: sendMessageRequest.message??"",
       sender:"user",
      id: tempId.toString()

    );

    addToMessageList(responseMessage: responseMessageModelOld);
    autoScrollDown();
    // emit(SendMessageSuccessState());
    final res = await _repo.sendMessage(sendMessageRequest: sendMessageRequest);

    res.fold(
          (l) {
         messages.singleWhere((e) => e.id == tempId.toString()).state = MsgState.error;
        emit(SendMessageErrorState());
      },
          (r) {
        int msgIndex = messages.indexWhere((e) {

          return e.id == tempId.toString();
        });
        if (r.data != null) {
            messages[msgIndex] = r.data.toChatMessagesModel();


        } else {
           messages.singleWhere((e) => e.id == tempId.toString()).state = MsgState.error;
          emit(SendMessageErrorState());
          return;
        }
        emit(SendMessageSuccessState());
        // getChatMsg(id: CacheHelper.getData(key: "chatId"));

      },
    );
  }




  /// add to message list
  void addToMessageList({required   ChatMessagesModel responseMessage}) {
    print("from insert ");
    messages.insert(0, responseMessage);

    emit(AddToMessageListState());
  }

  /// auto scroll down
  void autoScrollDown() {
    print("autoScrollDown");
    controllerScroll.animateTo(
      controllerScroll.position.minScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
    emit(AutoScrollDownState());
  }

  ///refreshToSwitch
  refreshToSwitch() {
    emit(RefreshToSwitchState());
  }

  ///startAudio
  void startAudio() async {
    await AudioHelper.audioHelper.recordVoice();
    emit(StartAudioState());
  }

  ///stopAudio
  void stopAudio() async {
    await AudioHelper.audioHelper.record.stopRecorder();


    emit(StopAudio());
  }

  ///getPathAudio
  String getPathAudio() {
    return AudioHelper.audioHelper.path;
  }









}

enum MsgState{success,error,loading}
