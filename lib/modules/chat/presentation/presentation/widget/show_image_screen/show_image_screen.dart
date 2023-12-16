import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../../../../../shared/components/uti.dart';
import '../../../../../../shared/network/local/cache_helper.dart';
import '../../../../../../widgets/item_shared/Text_form.dart';
import '../../../../data/request/send_message_request.dart';
 import '../../../cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../../../cubit/chat_msg_cubit/chat_msg_state.dart';



class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({super.key, required this.path, required this.id });

  final String path;
  final int id;

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {

     String? filePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatMsgCubit, ChatMsgState>(
      listener: (context, state) {
        if (state is AddToMessageListState) {
          Navigator.pop(context);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                   if((UTI.imageExtensions.contains(widget.path.split('.').last)))
                  SizedBox(
                        child: Image.file(
                          File(widget.path),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                        ),
                      )
                      else const Center(child: CircularProgressIndicator()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                children: [
                                  if(UTI.docExtensions.contains(widget.path.split('.').last))
                                    Expanded(child: Container()),
                                  if(!UTI.docExtensions.contains(widget.path.split('.').last))
                                Expanded(child: Container()),
                                  // Expanded(
                                  //   child: InputTextFormField(
                                  //      textEditingController: ChatMsgCubit.get(context)
                                  //         .captionImageMessage,
                                  //     prefixIcon: const Icon(Icons.add_a_photo_outlined),
                                  //     maxLines: 5,
                                  //     minLines: 1, hintText: 'Add Caption', validator: (String ) {  },
                                  //
                                  //
                                  //   ),
                                  // ),
                                  const SizedBox(width: 10,),

                                  CircleAvatar(
                                    backgroundColor: defaultColor,
                                    radius: 25,
                                    child: IconButton(
                                      onPressed: () {
                                        print("imagePath");
                                        print(widget.path);
                                        final extension = widget.path.substring(widget.path.lastIndexOf('.') + 1);

                                        SendMessageRequest sendMsg = SendMessageRequest(
                                          messageType:    "2",
                                          message: ChatMsgCubit.get(context).captionImageMessage.text,
                                           supportChatId: CacheHelper.getData(key: "chatId"),
                                           uploadedMessageFile:UTI.imageExtensions.contains(extension)?widget.path:null,



                                        );
                                        ChatMsgCubit.get(context).sendMessage(sendMessageRequest: sendMsg);
                                        // PusherService.pusherHelper.onTriggerEventPressed(context);
                                        ChatMsgCubit.get(context).captionImageMessage.clear();

                                      },
                                      icon: const Center(
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(height: 20,)


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
      },
    );
  }

  String? extensionPath(String extension) {
    var path;
       if(UTI.imageExtensions.contains(extension)){
      print("asnmdnsnkjfskjkfsjfs213233232343");
      path=widget.path;
    }else {
      print("asnmdnsnkjfskjkfsjfs111111");
      path=null;

    }
    return path;
  }

  String checkType(String extension) {
    var type;
      if(UTI.imageExtensions.contains(extension)){
    type="image";
    }
    return type;
  }
}
