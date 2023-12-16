
import 'package:flutter/material.dart';


@immutable
abstract class ChatMsgState {}

class ChatMsgInitial extends ChatMsgState {}



 ///chat msg
class ChatMsgLoadState extends ChatMsgState {}
class ChatMsgSuccessState extends ChatMsgState {}
class ChatMsgErrorState extends ChatMsgState {}

///create support  chat
class CreateSupportChatLoadState extends ChatMsgState {}
class CreateSupportChatSuccessState extends ChatMsgState {}
class CreateSupportChatErrorState extends ChatMsgState {}

///chat send msg
class SendMessageLoadState extends ChatMsgState {}
class SendMessageSuccessState extends ChatMsgState {

}
class SendMessageErrorState extends ChatMsgState {}

///Add To Message List
class AddToMessageListState extends ChatMsgState {}

///auto scroll down
class AutoScrollDownState extends ChatMsgState {}

///add msg
class AddMessagesState extends ChatMsgState {}

///RefreshToSwitchState
class RefreshToSwitchState extends ChatMsgState {}

///StartAudioState
class StartAudioState extends ChatMsgState {}

///StopAudio
class StopAudio extends ChatMsgState {}

///Change Local Messages To Remote Message State
class ChangeLocalMessagesToRemoteMessageState extends ChatMsgState {}


///Change Audio State
class ChangeAudioState extends ChatMsgState {}

///GetFileInfo
class GetFileInfoLoading extends ChatMsgState {}
class GetFileInfoSuccess extends ChatMsgState {}



///chat chat open
class CheckChatOpenLoadState extends ChatMsgState {}
class CheckChatOpenSuccessState extends ChatMsgState {}
class CheckChatOpenErrorState extends ChatMsgState {}



///Refresh State
class RefreshState extends ChatMsgState {}


