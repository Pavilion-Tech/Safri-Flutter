// import 'dart:io';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:safri/modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
//
// import '../../../../../shared/images/images.dart';
//
// import '../../shared/components/components.dart';
// import '../item_shared/default_button.dart';
// import 'image_bottom.dart';
//
//
// class ChoosePhotoType extends StatefulWidget {
//
//
//   @override
//   State<ChoosePhotoType> createState() => _ChoosePhotoTypeState();
// }
//
// class _ChoosePhotoTypeState extends State<ChoosePhotoType> {
//   void chooseImage(ImageSource source, BuildContext context) async {
//     var cubit = ChatMsgCubit .get(context);
//     cubit.chatImage = await cubit.pick(source);
//     cubit.chatImage = await checkImageSize(cubit.chatImage);
//     cubit.emitState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChatCubit, ChatStates>(
//       listener: (context, state) {
//        if(state is SendMessageSuccessState)Navigator.pop(context);
//       },
//       builder: (context, state) {
//         var cubit = ChatCubit.get(context);
//         return Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(tr('select_image'), style:const TextStyle(fontSize: 20),),
//               const SizedBox(height: 20,),
//               Row(
//                 children: [
//                   ImageButtom(
//                       onTap: () {
//                         chooseImage(ImageSource.gallery, context);
//                       },
//                       title: tr('browse'),
//                       image: Images.browse
//                   ),
//                   const Spacer(),
//                   ImageButtom(
//                       onTap: () {
//                         chooseImage(ImageSource.camera, context);
//                       },
//                       title: tr('camera'),
//                       image: Images.camera
//                   ),
//                 ],
//               ),
//               if(cubit.chatImage!=null)
//               Expanded(child: Stack(
//                 alignment: AlignmentDirectional.center,
//                 children: [
//                   Image.file(File(cubit.chatImage!.path),fit: BoxFit.cover,),
//                   InkWell(
//                     onTap: (){
//                       cubit.chatImage= null;
//                       cubit.emitState();
//                     },
//                       child: Icon(Icons.delete_forever,color: Colors.red,size: 30,)
//                   )
//                 ],
//               )),
//               if(cubit.chatImage!=null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: state is! SendMessageWithFileLoadingState ?
//                   DefaultButton(
//                       text: tr('send'),
//                       onTap: (){
//                         // cubit.sendMessageWithFile(
//                         //     type: 2,
//                         //     file: File(cubit.chatImage!.path)
//                         // );
//                       }
//                   ):const CupertinoActivityIndicator(),
//                 ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
