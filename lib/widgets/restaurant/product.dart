import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/models/provider_products_model.dart';
import 'package:safri/shared/components/components.dart';

import '../../modules/product/product_screen.dart';
import '../../shared/images/images.dart';
import '../item_shared/image_net.dart';

class Product extends StatelessWidget {
  Product(this.productData,this.isClosed);

  ProductData productData;

  bool isClosed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, ProductScreen(productData: productData,isClosed:  isClosed));
      },
      child: Container(
        width: double.infinity,
        height: 84,
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
              child: ImageNet(image:productData.mainImage??'',fit: BoxFit.cover,),
            ),
            const SizedBox(width: 5,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        productData.title??'',
                        minFontSize: 8,
                        maxLines: 2,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    // const Spacer(),
                    Text(
                      '${productData.priceAfterDiscount!="null"?productData.priceAfterDiscount:"0"} ${tr("KWD")}',
                      style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
