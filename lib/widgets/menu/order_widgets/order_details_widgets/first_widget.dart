import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/components/components.dart';

import '../../../../models/order_model.dart';
import '../../../../modules/menu/menu_screens/account_screens/order/track_screen.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../../item_shared/image_net.dart';

class FirstWidget extends StatelessWidget {
  FirstWidget(this.data);

  OrderData data;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 65,width: 65,
              decoration:const BoxDecoration(
                  shape: BoxShape.circle
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ImageNet(image:data.providerImage??'',fit: BoxFit.cover,),
            ),
            Text(
              data.providerName??'',
              style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if(data.serviceType ==2 )
            Text(
              data.serviceType ==1?tr('pick_up'):tr('dine_in'),
              style:const TextStyle(fontSize: 15),
            ),
            if(data.serviceType ==2 )
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: ()=>navigateTo(context, TrackScreen(
                  data.status==1?'new':data.status==2?'pending':data.status==3?'ready':'completed',
                  this.data
              )),
              child: Container(
                height: 32,
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadiusDirectional.circular(7)
                ),
                child: Text(
                  'New | ${tr('track')}',
                  style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
