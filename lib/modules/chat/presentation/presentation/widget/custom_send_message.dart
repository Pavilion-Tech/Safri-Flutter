
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/modules/chat/presentation/presentation/widget/show_image_screen/show_image_screen.dart';
import 'package:safri/shared/styles/colors.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../shared/network/local/cache_helper.dart';
import '../../../../../widgets/item_shared/Text_form.dart';
import '../../../data/request/send_message_request.dart';
import '../../cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../../cubit/chat_msg_cubit/chat_msg_state.dart';
import 'image_picker_helper/image_picker_helper.dart';

class CustomSendMessages extends StatefulWidget {



  const CustomSendMessages({
    super.key,

  });

  @override
  State<CustomSendMessages> createState() => _CustomSendMessagesState();
}

class _CustomSendMessagesState extends State<CustomSendMessages> with SingleTickerProviderStateMixin{
  late CustomTimerController customTimerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // PusherService.pusherHelper.initPusher();
   //  if(Platform.isAndroid)
    customTimerController = CustomTimerController(
      begin:  const Duration(seconds: 0),
      end:  const Duration(hours: 1),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatMsgCubit, ChatMsgState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ChatMsgCubit.get(context);
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(

              boxShadow: [

                BoxShadow(
                  color: Colors.grey.withOpacity(0.01), // Set the shadow color and opacity
                  blurRadius: 5.0, // Define the blur radius for the shadow
                  offset: Offset(2.0, 2.0), // Specify the shadow's offset
                ),
              ],
            ),
            child:  (state is StartAudioState)
                ? sendRecord(cubit)
                :Row(children: [
              Expanded(
                child: Container(
                    height: 63,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(15)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      focusNode: ChatMsgCubit.get(context).focusNode,
                      keyboardType: TextInputType.multiline,
                      controller: ChatMsgCubit.get(context).messageController,
                      onChanged: (value) {
                        ChatMsgCubit.get(context).refreshToSwitch();
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                            hintText: tr('type_message'),
                          hintStyle: const TextStyle(
                              fontSize: 13, color: Colors.grey),
                          suffixIcon:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                  onTap: () {
                                    ImagePickerHelper.imagePickerHelper
                                        .pickImageVideoUser()
                                        .then((value) {
                                      if (ImagePickerHelper
                                          .imagePickerHelper.file !=
                                          null) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowImageScreen(
                                                      id: 0,

                                                      path:
                                                      ImagePickerHelper
                                                          .imagePickerHelper
                                                          .file!
                                                          .path,
                                                    )));
                                      }
                                    });
                                  },
                                  child: const Icon(Icons.attach_file_sharp)),
                              IconButton(
                                onPressed: () async {
                                  ImagePickerHelper.imagePickerHelper
                                      .pickImageCamera()
                                      .then((value) {
                                    if (value != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowImageScreen(

                                                    id: 1,
                                                    path: value.path,
                                                  )));
                                    }
                                  });

                                },
                                icon:  const Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                      ),
                    )
                ),
              ),

              const SizedBox(width: 10),
              if (ChatMsgCubit.get(context).messageController.text.isNotEmpty)
                sendMessage(context)
              else
                startRecord(context),
            ]));
      },
    );
  }

  SizedBox sendRecord(ChatMsgCubit cubit) {
    return SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    print("send voice");

                    print(cubit.getPathAudio());
                    cubit.stopAudio();
                    SendMessageRequest sendMsg = SendMessageRequest(
                        messageType: "3",
                        message: "",
                          supportChatId: CacheHelper.getData(key: "chatId"),
                        uploadedMessageFile: cubit.getPathAudio()
                    );
                    ChatMsgCubit.get(context).sendMessage(sendMessageRequest: sendMsg);

                    customTimerController.reset();

                  },
                  child: Lottie.asset('assets/json/recorder.json'),
                ),
                const SizedBox(
                  width: 10,
                ),
                CustomTimer(
                    controller: customTimerController,
                    builder: (state, time) {
                      // Build the widget you want!🎉
                      return Text(
                          "${time.hours}:${time.minutes}:${time.seconds}",
                          style:  const TextStyle(fontSize: 24.0));
                    }),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: IconButton(
                    onPressed: () {
                      cubit.stopAudio();
                      customTimerController.reset();
                    },
                    icon:  const Icon(Icons.close),
                  ),
                ),

              ],
            ),
          );
  }

  Widget startRecord(BuildContext context) {

    return  InkWell(
      onTap: () async {
        ChatMsgCubit.get(context).startAudio();
        customTimerController.start();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(15)
        ),
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(Images.microPhone, color: defaultColor,),
        ),
      ),
    )  ;
  }

  Widget sendMessage(BuildContext context) {
    return  InkWell(
      onTap: () async {
        print("widget.usersData.chatRoomType");

        SendMessageRequest sendMsg = SendMessageRequest(
          supportChatId: CacheHelper.getData(key: "chatId"),
          messageType: "1",
          message: ChatMsgCubit.get(context).messageController.text,

        );
        ChatMsgCubit.get(context).sendMessage(sendMessageRequest: sendMsg);

        ChatMsgCubit.get(context).messageController.clear();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusDirectional.circular(15)
        ),
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:Icon(Icons.send, size: 20, color:  defaultColor),
        ),
      ),
    ) ;
  }


}
