import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/styles/colors.dart';

class Invoice extends StatelessWidget {
  Invoice({this.subtotal,this.total,this.appFee,this.tax,this.discount,this.discountType,this.delivery,required this.selectServiceType,  this.isOrderDetails=false,this.wallet});

  dynamic subtotal;
  dynamic total;
  String? appFee;
  bool? isOrderDetails;
  dynamic tax;
  dynamic discount;
  String? delivery;
  int? discountType;
  int? selectServiceType;
  dynamic wallet;

  @override
  Widget build(BuildContext context) {
    print(total);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          if(wallet!=null)
          itemBuilder(
            text: 'wallet',
            price: '-$wallet'
          ),
          itemBuilder(
            text: 'subtotal',
            price: subtotal??'10'
          ),
          if(selectServiceType==3)
          itemBuilder(
            text: 'Delivery_Fee',
            price: delivery??'0'
          ),
          // itemBuilder(
          //   text: 'tax',
          //   price: tax??'10'
          // ),
          // itemBuilder(
          //   text: 'app_fee',
          //   price: appFee??'10'
          // ),
          if(discount!=null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    tr('discount'),
                    style:const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    '$discount ${discountType == 2 ?tr("KWD"):'%'}',
                    style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
                  ),
                ],
              ),
            ),
          Container(
            height: 1,
            width: double.infinity,color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Text(
                  tr('total_order'),
                  style:const TextStyle(fontWeight: FontWeight.w700,fontSize: 19),
                ),
                const Spacer(),
                if(selectServiceType==3&&isOrderDetails==false)
                Text(
                  '${total??""} ${tr("KWD")}',
                  style:TextStyle(fontWeight: FontWeight.w600,fontSize: 19,color: defaultColor),
                ),
                if(selectServiceType!=3&&isOrderDetails==false)
                  Text(
                    '${subtotal} ${tr("KWD")}',
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 19,color: defaultColor),
                  ),
                if( isOrderDetails==true)
                  Text(
                    '${total??""} ${tr("KWD")}',
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 19,color: defaultColor),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String totalMinusDelivery() {
    print("total.toString()");
    print(total.toString());
    print(delivery.toString());
    double? totalPrice;
    if(delivery !=""){
      totalPrice =(double.tryParse(total.toString())!- double.parse(delivery.toString()))  ;
    }
    else{
      totalPrice=double.tryParse(total.toString());
    }

    return totalPrice.toString();
  }

  Widget itemBuilder({
  required String text,
  required dynamic price,
}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            tr(text),
            style:const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Text(
            '$price ${tr("KWD")}',
            style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 15),
          ),
        ],
      ),
    );
  }
}
