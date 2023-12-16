import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/models/cart_model.dart';
import 'package:safri/shared/styles/colors.dart';
import '../../../models/order_model.dart';
import '../../item_shared/image_net.dart';

class CheckOutListItem extends StatelessWidget {
  const CheckOutListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: FastCubit.get(context).cartModel!.data!.cart!.length == 1?200:470,
      child: ListView.separated(
          itemBuilder: (c,i)=>CheckOutItem(cartData: FastCubit.get(context).cartModel!.data!.cart![i]),
          separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          padding: EdgeInsetsDirectional.all(20),
          itemCount: FastCubit.get(context).cartModel!.data!.cart!.length
      ),
    );
  }
}

class CheckOutItem extends StatelessWidget {
  CheckOutItem({required this.cartData});

 final Cart cartData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("product id");
        print(cartData.productId);
        print(cartData.productSelectedSizeId);
        // print(cartData.extras.first.);
      },
      child: Container(
        height: 135,width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(27),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 20,
              ),   BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 20,
              ),
            ]
        ),
        child: Row(
          children: [
            Container(
              height: 135,width: 135,
              decoration: BoxDecoration(
                borderRadius:BorderRadiusDirectional.circular(27),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ImageNet(image:cartData.productImage??'',fit: BoxFit.cover,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      cartData.productTitle??'' ,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 8,
                      maxLines: 1,

                      style: TextStyle(fontSize: 20),
                    ),
                    if(cartData.extras!.isNotEmpty)
                      AutoSizeText(
                        '${cartData.extras!.map((e) => e.selectedExtraName??'' ).toList().join(",")} , ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 8,

                        style: TextStyle(fontSize: 12),
                      ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children:cartData.extras!.map((e) => AutoSizeText(
                      //       '${e.selectedExtraName??''} , ',
                      //       maxLines: 3,
                      //       minFontSize: 8,
                      //
                      //       style: TextStyle(fontSize: 14),
                      //     ),).toList(),
                      //   ),
                      // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          '${cartData.quantity??''}',
                          minFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500,color: defaultColor),
                        ),
                        AutoSizeText(
                          ' * ',
                          minFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500),
                        ),
                        AutoSizeText(
                          '${cartData.productPrice??''} ${tr("KWD")}',
                          minFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                        ),
                      ],
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



class OrderItem extends StatelessWidget {
  OrderItem({required this.products});

  Products products;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(27),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 20,
            ),   BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 20,
            ),
          ]
      ),
      child: Row(
        children: [
          Container(
            height: 135,width: 135,
            decoration: BoxDecoration(
              borderRadius:BorderRadiusDirectional.circular(27),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ImageNet(image:products.image??'',fit: BoxFit.cover,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    products.title??'',
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        '${products.orderedQuantity??''}',
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500,color: defaultColor),
                      ),
                      AutoSizeText(
                        ' * ',
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(fontSize: 11.5,fontWeight: FontWeight.w500),
                      ),
                      AutoSizeText(
                        '${products.priceAfterDiscount??''} ${tr("KWD")}',
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

