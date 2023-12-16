import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../shared/styles/colors.dart';
import '../../modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
import '../../modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_state.dart';
enum Type{text,image,record}
class ChatMessage{
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
class ChatBody extends StatefulWidget {
  const ChatBody({Key? key}) : super(key: key);

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud ex", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
    ChatMessage(messageContent: "how are you", messageType: "receiver"),
    ChatMessage(messageContent: "iam fine", messageType: "sender"),
    ChatMessage(messageContent: "welcome to egypt", messageType: "receiver"),
    ChatMessage(messageContent: "everything will be good ", messageType: "sender"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatMsgCubit,  ChatMsgState>(
      listener: (context, state) {},
      builder: (context, state) {
        // var messages = ChatCubit.get(context).chatModel!.data!.supportChat!;
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (c,i)=>ChatItem(
              type: messages[i].messageType == 1 ?Type.text:messages[i].messageType == 2?Type.image:Type.record,
              content: messages[i].messageContent  ,
              createdAt: "2:30 Am",
              isUser:messages[i].messageType == "receiver"?true:false,
            ),
            separatorBuilder: (c,i)=>const SizedBox(height: 15,),
            itemCount: messages.length
        );
      },
    );
  }
}

class ChatItem extends StatelessWidget {
  ChatItem({
    required this.isUser,
    required this.type,
    required this.content,
    required this.createdAt,
  });


  bool isUser;
  Type type;
  String content;
  String createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          end: isUser?0:30,start: isUser?30:0
      ),
      child: Column(
        crossAxisAlignment: isUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(
            createdAt,
            style: TextStyle(
                color: Colors.grey.shade500,fontSize: 11
            ),
          ),
          Builder(builder: (BuildContext context) {
            return Container(
                decoration: BoxDecoration(
                  color: isUser?defaultColor:HexColor('#EEEEEE'),
                  borderRadius: BorderRadiusDirectional.only(
                    topStart:Radius.circular(isUser?20:0),
                    topEnd: Radius.circular(isUser?0:20),
                    bottomEnd: const Radius.circular(20),
                    bottomStart:const  Radius.circular(20),
                  ),
                ),
                padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                child:Text(
                  content,
                  textAlign: isUser?TextAlign.end:TextAlign.start,
                  style: TextStyle(
                      color: isUser?Colors.white:null,fontSize: 11
                  ),
                )
            );
            // switch(type){
            //   case Type.text:
            //     return
            //       Container(
            //           decoration: BoxDecoration(
            //             color: isUser?defaultColor:HexColor('#EEEEEE'),
            //             borderRadius: BorderRadiusDirectional.only(
            //               topStart:Radius.circular(isUser?20:0),
            //               topEnd: Radius.circular(isUser?0:20),
            //               bottomEnd: const Radius.circular(20),
            //               bottomStart:const  Radius.circular(20),
            //             ),
            //           ),
            //           padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            //           child:Text(
            //             content,
            //             textAlign: isUser?TextAlign.end:TextAlign.start,
            //             style: TextStyle(
            //                 color: isUser?Colors.white:null,fontSize: 11
            //             ),
            //           )
            //       );
            //   case Type.image:
            //     return InkWell(
            //       onTap: ()=>navigateTo(context, ImageScreen(content)),
            //       child: Container(
            //           height: 129,width: size!.width*.6,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadiusDirectional.only(
            //               topStart:Radius.circular(isUser?20:0),
            //               topEnd: Radius.circular(isUser?0:20),
            //               bottomEnd:const Radius.circular(20),
            //               bottomStart:const Radius.circular(20),
            //             ),
            //           ),
            //           clipBehavior: Clip.antiAliasWithSaveLayer,
            //           child:ImageNet(image: content,)
            //       ),
            //     );
            //   case Type.record:
            //     return Container(
            //         decoration: BoxDecoration(
            //           color: HexColor('#EEEEEE'),
            //           borderRadius: BorderRadiusDirectional.only(
            //             topStart:Radius.circular(isUser?20:0),
            //             topEnd: Radius.circular(isUser?0:20),
            //             bottomEnd:const Radius.circular(20),
            //             bottomStart:const Radius.circular(20),
            //           ),
            //         ),
            //         padding:const EdgeInsets.symmetric(horizontal: 10),
            //         child:RecordItem(url: content,)
            //     );
            //   default:
            //     return const SizedBox();
            // }
          },

          ),
        ],
      ),
    );
  }
}


