import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/models/contact_us_model.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';

import '../../../shared/components/constant.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../shimmer/default_list_shimmer.dart';

class TrackComplaints extends StatelessWidget {
  const TrackComplaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = MenuCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ConditionalBuilder(
        condition: cubit.contactUsModel?.data?.data!= null,
        fallback: (c)=>DefaultListShimmer(havePadding: false),
        builder: (c)=> ConditionalBuilder(
          condition: cubit.contactUsModel!.data!.data!.isNotEmpty,
          builder: (c){
            Future.delayed(Duration.zero,(){
              cubit.paginationContactUs();
            });
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (c,i)=>itemBuilder(cubit.contactUsModel!.data!.data![i]),
                      separatorBuilder:(c,i)=> const SizedBox(height: 20,),
                      padding: EdgeInsets.zero,
                      controller: cubit.contactusScrollController,
                      itemCount: cubit.contactUsModel!.data!.data!.length
                  ),
                ),
                if(state is GetContactUsLoadingState)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: CupertinoActivityIndicator(),
                  ),
              ],
            );
          },
          fallback: (c)=> Column(
            children: [
              Image.asset(Images.noCompaints,width: size!.width*.6,),
              AutoSizeText(
                tr('opps'),
                minFontSize: 8,
                maxLines: 1,
                style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
              ),
              AutoSizeText(
                tr('no_complaints'),
                minFontSize: 8,
                maxLines: 1,
                style:const TextStyle(color: Colors.black54,fontWeight: FontWeight.w400,fontSize: 13),
              ),
              AutoSizeText(
                tr('if_you'),
                minFontSize: 8,
                maxLines: 1,
                textAlign: TextAlign.center,
                style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15,height: 1),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }


  Widget itemBuilder(ContactUsData data){
    return Container(
      height: 63,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(15),
        color: Colors.grey.shade200
      ),
      alignment: AlignmentDirectional.center,
      padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AutoSizeText(
                '${tr('complaints')} #${data.itemNumber??''}',
                minFontSize: 8,
                maxLines: 1,
                style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.black),
              ),
              const Spacer(),
              AutoSizeText(
                data.status==1?tr('not_solved'):tr('solved'),
                minFontSize: 8,
                maxLines: 1,
                style:const TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Colors.black),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.createdAt??'',
            style:const TextStyle(fontSize: 8),
          ),
        ],
      ),
    );
  }
}
