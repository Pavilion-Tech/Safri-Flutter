import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/models/provider_category_model.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';

import '../../modules/restaurant/restaurant_screen.dart';
import 'image_net.dart';

class ProviderItem extends StatelessWidget {

  ProviderItem ({this.isBranch = false,this.providerData});
 final ProviderData? providerData;
 final bool isBranch;
  @override
  Widget build(BuildContext context) {
    return providerData!=null?InkWell(
      onTap: (){
       try{
         FastCubit.get(context).productsModel = null;
         FastCubit.get(context).providerId = providerData?.id??'';
         FastCubit.get(context).providerProductId = providerData!.childCategoriesModified!.isNotEmpty?providerData!.childCategoriesModified![0].id??"":'';
         FastCubit.get(context).providerBranchesModel=null;
         FastCubit.get(context).providerBranchesId = providerData?.id??'';
         // FastCubit.get(context).getAllProductsBranches();
         if(FastCubit.get(context).providerProductId.isNotEmpty){
           FastCubit.get(context).getAllProducts();
         }
         print("providerData!.id.toString()");
         print(providerData!.id.toString());
         navigateTo(context, RestaurantScreen(id: providerData!.id.toString(),isBranch: isBranch,));
       }catch(e){
         print(e.toString());
       }
      },
      child: Container(
        width: double.infinity,
        // height:100,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          border: Border.all(color: Colors.grey)
        ),
        padding: const EdgeInsets.only(right: 5,left: 5,bottom: 5,top: 5),
        child: Row(
          children: [
            Container(
              height: 75,
              width: 75,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: ImageNet(image:providerData!.personalPhoto??'',fit: BoxFit.cover,),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          providerData!.name??'',
                          minFontSize: 8,

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      SizedBox(width: size!.width*.01,),
                      CircleAvatar(
                        backgroundColor:providerData?.openStatus == 'open'? Color(0xff57E500):Color(0xffE51C00),
                        radius: 5,
                      ),
                      const SizedBox(width: 5,),
                      AutoSizeText(
                        tr(providerData?.openStatus??'open'),
                        style: TextStyle(fontSize: 10,color: providerData?.openStatus == 'open'? Color(0xff57E500):Color(0xffE51C00)),
                      ),
                      SizedBox(width: size!.width*.02,),
                    ],
                  ),
                  SizedBox(height: 20,),
                  // Text(
                  //   'Pickup & Dine In Service',
                  //   style: TextStyle(fontSize: 11),
                  // ),
                  // const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(Images.star,width: 13,height: 14,),
                      const SizedBox(width: 5,),
                      AutoSizeText(
                        '${providerData!.totalRate??0} (${providerData!.totalRateCount})',
                        maxLines: 1,
                        minFontSize: 5,
                        style: TextStyle(fontSize: 10,color: Colors.grey),
                      ),
                      SizedBox(width: size!.width*.01,),
                      if(providerData!.distance!=null)
                        Image.asset(Images.location,width: 14,height: 14,),
                      if(providerData!.distance!=null)
                      const SizedBox(width: 5,),
                      if(providerData?.distance !=null)
                        AutoSizeText(
                          providerData?.distance??"",
                          maxLines: 1,
                          minFontSize: 5,
                          style: TextStyle(fontSize: 10,color: Colors.grey),
                        ),
                      if(providerData!.duration!=null)
                        SizedBox(width: size!.width*.01,),
                      if(providerData!.duration!=null)
                        Image.asset(Images.timer,width: 14,height: 14,),
                      const SizedBox(width: 5,),
                      Row(
                      children: [
                              AutoSizeText(
                               '${providerData!.duration??''} | ',
                              maxLines: 1,
                              minFontSize: 5,
                              style: TextStyle(fontSize: 10,color: Colors.grey),
                              ), AutoSizeText(
                               providerData?.crowdedStatus ==1 ?tr('crowded'):tr('not_crowded'),
                              maxLines: 1,
                              minFontSize: 5,
                              style: TextStyle(fontSize: 10,color:Color(0xff4B4B4B)),
                              ),
                             ],
                      ),
                      // SizedBox(width: size!.width*.02,),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ):SizedBox();
  }
}
