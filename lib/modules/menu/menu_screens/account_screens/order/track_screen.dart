import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:safri/modules/menu/menu_screens/account_screens/order/rate_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';

import '../../../../../models/order_model.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../../widgets/cart/checkout/checkout_list_item.dart';
import '../../../../../widgets/item_shared/default_button.dart';

class TrackScreen extends StatelessWidget {
  TrackScreen(this.title,this.data);

  String title;
  OrderData data;

  String getService (){
    switch(data.serviceType){
      case 1:
        return 'pick_up';
      case 2:
        return 'dine_in';
      default: return 'Delivery';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('track')),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(

                  children: [
                    AutoSizeText(
                      tr('${getService()}'),
                      minFontSize: 8,
                      maxLines: 1,
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      height: 32,
                      width:80,
                      decoration: BoxDecoration(
                        color: defaultColor,
                        borderRadius: BorderRadiusDirectional.circular(7),
                      ),
                      alignment: AlignmentDirectional.center,
                      child: AutoSizeText(
                        tr(title),
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 25.0,right: 20,left: 20),
                                child: separated(),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             itemBuilder(
                                 image: Images.pending,
                                 title: 'pending',
                                 isSelected: title == 'pending'||title == 'new'||title == 'ready'||title == 'completed'
                             ),
                              itemBuilder(
                                 image: Images.neww,
                                 title: 'new',
                                 isSelected: title == 'new'||title == 'ready'||title == 'completed'
                             ),
                              itemBuilder(
                                 image: Images.calendar,
                                 title: 'ready',
                                 isSelected:title == 'ready'||title == 'completed'
                             ),
                              itemBuilder(
                                 image: Images.completed,
                                 title: 'completed',
                                 isSelected: title == 'completed'
                             ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 480,
                      child: ListView.separated(
                        itemBuilder: (c,i)=>OrderItem(products: data.products![i]),
                        separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.products!.length,
                      ),
                    ),
                    if(title == 'Completed')
                    Center(
                      child: DefaultButton(
                        text: tr('rate'),
                        onTap: (){
                          navigateTo(context, RateScreen(data.providerId??''));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget itemBuilder({
  required String image,
  required String title,
  required bool isSelected,
}){
    return Column(


      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            color: isSelected?HexColor('#FFB115'):Colors.grey.shade400
          ),
          alignment: AlignmentDirectional.center,
          child: Image.asset(image,width: 20,color: isSelected?Colors.white:Colors.grey.shade600,),
        ),
        AutoSizeText(
          tr(title),
          minFontSize: 8,
          maxLines: 1,
          style: TextStyle(color: isSelected?defaultColor:Colors.black),
        ),
      ],
    );
  }

  Widget separated(){
    return SizedBox(
      height: 1,
      child: ListView.separated(
          itemBuilder: (c,i)=>Container(color: defaultColor,height: 1,width: 5,),
          separatorBuilder: (c,i)=>const SizedBox(width: 5,),
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 40,
      ),
    );
  }
}
