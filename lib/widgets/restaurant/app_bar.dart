// import 'package:easy_localization/easy_localization.dart' hide TextDirection;
// import 'package:flutter/material.dart';
// import 'package:safri/layout/cubit/home_category_cubit.dart';
// import 'package:safri/shared/images/images.dart';
// import 'package:safri/shared/styles/colors.dart';
// import 'package:safri/widgets/item_shared/provider_item.dart';
//
// import '../../models/provider_category_model.dart';
// import '../../shared/components/constant.dart';
// import '../item_shared/image_net.dart';
// import 'branche_bottom_sheet.dart';
//
// class RestaurantAppBar extends StatelessWidget {
//   RestaurantAppBar(this.providerData,this.isBranch);
//
// final  ProviderData providerData;
// final  bool isBranch;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: AlignmentDirectional.bottomCenter,
//       children: [
//         Container(
//           height: 206,
//           width: double.infinity,
//           decoration:const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//             )
//           ),
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           child: ImageNet(image:providerData.personalPhoto??'',fit: BoxFit.cover,),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
//           child: Container(
//             width: double.infinity,
//             height: 84,
//             decoration: BoxDecoration(
//               color: Colors.white,
//                 borderRadius: BorderRadiusDirectional.circular(20),
//                 border: Border.all(color: Colors.grey)
//             ),
//             padding: const EdgeInsets.only(right: 5,left: 5,bottom: 5,top: 5),
//             child: Row(
//               children: [
//                 Container(
//                   height: 75,
//                   width: 75,
//                   clipBehavior: Clip.antiAliasWithSaveLayer,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadiusDirectional.circular(15),
//                   ),
//                   child: ImageNet(image:providerData.personalPhoto??'',fit: BoxFit.cover,),
//                 ),
//                 const SizedBox(width: 5,),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               providerData.name??'',
//                               maxLines: 1,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                           if(!isBranch)
//                             if(FastCubit.get(context).providerBranchesModel!=null)
//                               if(FastCubit.get(context).providerBranchesModel!.data!.data!.isNotEmpty)
//                           InkWell(
//                             onTap: (){
//                               showModalBottomSheet(
//                                   context: context,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius:const BorderRadiusDirectional.only(
//                                       topEnd: Radius.circular(20),
//                                       topStart: Radius.circular(20),
//                                     ),
//                                     side: BorderSide(width: 3,color: Colors.grey.shade200),
//                                   ),
//                                   builder: (context)=>BrancheBottomSheet()
//                               );
//                             },
//                             child: Text(
//                               tr('change_branch'),
//                               style: TextStyle(
//                                 color: defaultColor,
//                                 decoration: TextDecoration.underline,
//                                 fontSize: 9.4,
//                                 fontWeight: FontWeight.w500
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 20,)
//                         ],
//                       ),
//                       // Text(
//                       //   'Pickup & Dine In Service',
//                       //   style: TextStyle(fontSize: 11),
//                       // ),
//                       const Spacer(),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Image.asset(Images.star,width: 15,),
//                           const SizedBox(width: 5,),
//                           Text(
//                             '${providerData.totalRate??''} (${providerData.totalRateCount})',
//                             style: TextStyle(fontSize: 10,color: Colors.grey),
//                           ),
//                           SizedBox(width: size!.width*.01,),
//                           if(providerData.distance!=null)
//                             Image.asset(Images.location,width: 15,),
//                           if(providerData.distance!=null)
//                             const SizedBox(width: 5,),
//                           if(providerData.distance!=null)
//                             Text(
//                               providerData.distance!,
//                               style: TextStyle(fontSize: 10,color: Colors.grey),
//                             ),
//                           if(providerData.duration!=null)
//                             SizedBox(width: size!.width*.01,),
//                           if(providerData.duration!=null)
//                             Image.asset(Images.timer,width: 15,),
//                           const SizedBox(width: 5,),
//                           Text.rich(
//                               TextSpan(
//                                   text:'${providerData.duration??''} | ',
//                                   style: TextStyle(fontSize: 10,color: Colors.grey),
//                                   children: [
//                                     TextSpan(
//                                         text: providerData.crowdedStatus ==1 ?tr('crowded'):tr('not_crowded'),
//                                         style: TextStyle(fontSize: 10)
//                                     )
//                                   ]
//                               )
//                           ),
//                           SizedBox(width: size!.width*.01,),
//                           CircleAvatar(
//                             backgroundColor:providerData.openStatus == 'open'? Colors.green:Colors.red,
//                             radius: 5,
//                           ),
//                           const SizedBox(width: 5,),
//                           Text(
//                             tr(providerData?.openStatus??'open'),
//                             style: TextStyle(fontSize: 10,color: Colors.green),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned.directional(
//           top: 0,
//           start: -10,
//           textDirection: TextDirection.ltr,
//           child: SafeArea(
//             child: Padding(
//               padding: const EdgeInsetsDirectional.only(start: 20),
//               child: IconButton(
//                 onPressed: ()=>Navigator.pop(context),
//                 icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
