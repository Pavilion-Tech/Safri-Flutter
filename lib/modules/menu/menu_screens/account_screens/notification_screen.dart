import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:safri/models/notification_model.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';

import '../../../../shared/components/constant.dart';
import '../../../../widgets/shimmer/default_list_shimmer.dart';
import '../../cubit/menu_cubit.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuCubit.get(context).getAllNotification();
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Scaffold(
      body:CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future.delayed(Duration.zero,(){
                MenuCubit.get(context).getAllNotification();
              });
            },
          ),
          SliverToBoxAdapter(
            child:  SizedBox(
              height: size!.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultAppBar(tr('notifications')),
                  Expanded(
                    child: ConditionalBuilder(
                      condition: cubit.notificationModel!=null,
                      fallback: (context)=>DefaultListShimmer(),
                      builder: (context)=> ConditionalBuilder(
                          condition: cubit.notificationModel?.data?.data?.isNotEmpty??false,
                          fallback: (c)=>Padding(
                            padding: const EdgeInsets.only(bottom: 150.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Images.splashImage,width: 200,),
                                  const SizedBox(height: 10,),
                                  AutoSizeText(tr('no_notification'), minFontSize: 8,
                                      maxLines: 1,style: TextStyle(color: defaultColor,fontSize: 20)),
                                ],
                              ),
                            ),
                          ),
                          builder: (c){
                            Future.delayed(Duration.zero,(){
                              cubit.paginationNotification();
                            });
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                      TextSpan(
                                          text: tr('you_have'),
                                          style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                                          children: [
                                            TextSpan(
                                              text: ' ${cubit.notificationModel!.data!.data!.length} ${tr('notifications')} ',
                                              style: TextStyle(color: defaultColor,fontWeight: FontWeight.w500,fontSize: 15),
                                            )
                                          ]
                                      )
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (c, i) => NotificationItem(cubit.notificationModel!.data!.data![i]),
                                        separatorBuilder: (c, i) =>
                                        const SizedBox(height: 20,),
                                        controller:cubit.orderScrollController,
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: cubit.notificationModel?.data?.data?.length??0
                                    ),
                                  ),
                                  if(state is NotificationLoadingState)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 40.0),
                                      child: CupertinoActivityIndicator(),
                                    ),
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}


class NotificationItem extends StatelessWidget {
  NotificationItem(this.data);
  NotificationData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.grey.shade200
      ),
      padding: EdgeInsetsDirectional.only(start: 15,end: 30,top: 5,bottom: 5),
      alignment: AlignmentDirectional.center,
      child: Row(
        children: [
          Container(
            height: 28,width: 28,
            decoration: BoxDecoration(
              color: HexColor('#f4cccc').withOpacity(.7),
              borderRadius: BorderRadiusDirectional.circular(5),
            ),
            alignment: AlignmentDirectional.center,
            child: Image.asset(Images.notification,width: 15,),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  data.title??'',
                  maxLines: 2,
                  minFontSize: 8,

                  style: TextStyle(
                      fontWeight: FontWeight.w700,fontSize: 15,color: Colors.black,height: 1.5
                  ),
                ),
                const SizedBox(height: 10,),
                AutoSizeText(
                  data.body??'',
                  minFontSize: 8,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 15,color: Colors.grey.shade600,height: 1.5
                  ),
                ),
              ],
            )
          ),

        ],
      ),
    );
  }
}

