// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
// import 'package:safri/modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
// import 'package:safri/modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_state.dart';
// import 'package:safri/widgets/chat/voice_dialog.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../../shared/images/images.dart';
// import '../../../../../shared/styles/colors.dart';
// import '../../../shared/components/components.dart';
//
// import 'choose_photo_type.dart';
//
// class ChatBottom extends StatelessWidget {
//   const ChatBottom({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChatMsgCubit, ChatMsgState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Row(
//           children: [
//             Expanded(
//                 child: Container(
//                     height: 63,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadiusDirectional.circular(15)
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: TextFormField(
//                       controller: ChatMsgCubit.get(context).messageController,
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           enabledBorder: InputBorder.none,
//                           // hintText: tr('type_message'),
//                           hintStyle: const TextStyle(
//                               fontSize: 13, color: Colors.grey),
//                           suffixIcon: InkWell(
//                             onTap: () {
//                               showModalBottomSheet(
//                                   context: context,
//                                   builder: (context) =>
//                                       ChoosePhotoType()
//                               );
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(Images.camera, width: 10,),
//                             ),
//                           )
//                       ),
//                     )
//                 )
//             ),
//             const SizedBox(width: 5,),
//             InkWell(
//               onTap: () async {
//                 var status = await Permission.microphone.request();
//                 if (status != PermissionStatus.granted) {
//                   showToast(msg: 'Microphone permission not granted');
//                   throw RecordingPermissionException(
//                       'Microphone permission not granted');
//                 } else {
//                   showDialog(
//                       context: context,
//                       builder: (context) => VoiceDialog()
//                   );
//                 }
//               },
//               child: Container(
//                 height: 45,
//                 width: 45,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadiusDirectional.circular(15)
//                 ),
//                 alignment: AlignmentDirectional.center,
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Image.asset(Images.microPhone, color: defaultColor,),
//                 ),
//               ),
//             ),
//             // state is! SendMessageLoadingState ?
//             // InkWell(
//             //   onTap: () {
//             //     if (ChatCubit.get(context).controller.text.isNotEmpty) {
//             //       // ChatCubit.get(context).sendMessageWithOutFile();
//             //     }
//             //   },
//             //   child: Container(
//             //     height: 45,
//             //     width: 45,
//             //     decoration: BoxDecoration(
//             //         color: Colors.white,
//             //         borderRadius: BorderRadiusDirectional.circular(15)
//             //     ),
//             //     alignment: AlignmentDirectional.center,
//             //     child: Padding(
//             //       padding: const EdgeInsets.all(12.0),
//             //       child: Icon(Icons.send, color: defaultColor,),
//             //     ),
//             //   ),
//             // ) :const CircularProgressIndicator(),
//           ],
//         );
//       },
//     );
//   }
// }
