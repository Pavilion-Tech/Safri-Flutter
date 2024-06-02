import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/models/cart_model.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';

class PaymentMethodModel{
  List<String>? image;
  String? title;
  String method;
  PaymentMethodModel({
    this.title,
    this.image,
    required this.method,
});
}

class PaymentMethod extends StatefulWidget {
  PaymentMethod({required this.allowedPaymentMethods});

  String allowedPaymentMethods;

   String method = 'online';

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {

  List<PaymentMethodModel> model = [
    PaymentMethodModel(image: [Images.visa,if(Platform.isIOS)Images.applePay,Images.kNet],method: 'online'),
    PaymentMethodModel(title: tr('pay_on_delivery'),method: 'cash'),
    // PaymentMethodModel(title: "${tr('Use_Wallet_Balance')} (250)",method: 'online'),


   // PaymentMethodModel(image: Images.mada,method: 'apple_pay'),
   //  PaymentMethodModel(method: '${tr('use_wallet_balance')}(250)'),
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsetsDirectional.only(start: 20,bottom: 15),
          child: AutoSizeText(
            tr('select_payment_method'),
            minFontSize: 8,
            maxLines: 1,
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              if(widget.allowedPaymentMethods == 'online'||
                  widget.allowedPaymentMethods == 'all')
              itemBuilder(model[0],0),
              if(widget.allowedPaymentMethods == 'online'||
                  widget.allowedPaymentMethods == 'all')
              const SizedBox(height: 20,),
              if(widget.allowedPaymentMethods == 'cash'||
                  widget.allowedPaymentMethods == 'all')
              itemBuilder(model[1],1),
            ],
          ),
        )

      ],
    );
  }

  Widget itemBuilder(PaymentMethodModel model,int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentIndex = index;
            widget.method = model.method;
        });
        // if(index != 0)
        // showToast(msg: tr('method_not_available'));
      },
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadiusDirectional.circular(10)
        ),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            if(model.image!=null)
            ListView.separated(
                itemBuilder: (c,i)=>Image.asset(model.image![i],width: 54,),
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (c,i)=>const SizedBox(width: 20,),
                itemCount: model.image!.length
            ),
            if(model.title!=null)
            AutoSizeText(model.title??"", minFontSize: 8,
              maxLines: 1,style: TextStyle(fontSize: 16),),
            const Spacer(),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.grey.shade400,
              child:currentIndex == index? CircleAvatar(
                radius: 6,
                backgroundColor: defaultColor,
              ):null,
            ),
          ],
        ),
      ),
    );
  }
}



