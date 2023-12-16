import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/models/order_model.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';

import '../../../modules/menu/menu_screens/account_screens/order/order_details_screen.dart';
import '../../item_shared/image_net.dart';

class HistoryOrderItem extends StatelessWidget {

  HistoryOrderItem(this.data);

 final OrderData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, OrderDetailsScreen(data)),
      child: SizedBox(
        height: 130,
        width: double.infinity,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 97,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(15),
                color: Colors.grey.shade200
              ),
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${tr('order')}${data.itemNumber??'0'}',
                    style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                  ),
                  Text(
                    serviceType(),
                    style:const TextStyle(fontSize: 9,fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data.createdAt??'',
                        style:const TextStyle(fontSize: 8),
                      ),
                      const Spacer(),
                      Text(
                        tr(data.status==1?'new':data.status==2?'pending':data.status==3?'ready':data.status==4?'completed':'cancel'),
                        style:const TextStyle(fontSize: 12,fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: myLocale=='en'?5:null,
              left: myLocale=='en'?null:5,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle
                ),
                height: 84,width: 84,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ImageNet(image:data.products?[0].image??'',fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String serviceType() {
    String type;
    if(data.serviceType ==1){
      type= tr('pick_up');
    }else if(data.serviceType ==2){
      type= tr('dine_in');
    }else  {
      type= tr('Delivery');
    }
    return type;
  }
}
