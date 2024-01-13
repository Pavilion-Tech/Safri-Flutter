import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/models/cart_model.dart';
import 'package:safri/shared/images/images.dart';

import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../item_shared/image_net.dart';

class CartItem extends StatelessWidget {
  CartItem(this.data);

 final Cart data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: size!.width*.78,
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
            height: 140,width: 135,
            decoration: BoxDecoration(
              borderRadius:BorderRadiusDirectional.circular(27),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ImageNet(image: data.productImage??'',fit: BoxFit.cover,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                  data.productTitle??'',

                    minFontSize: 8,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  if(data.extras!.isNotEmpty)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:data.extras!.map((e) => AutoSizeText(
                        '${e.selectedExtraName??''} , ',
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(fontSize: 12),
                      ),).toList(),
                    ),
                  ),
                  AutoSizeText(
                    '${data.productPrice??'0'} ${tr("KWD")}',
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),
                  ),
                  Container(
                    height: 34,width: 130,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadiusDirectional.circular(58),
                    //   color: defaultColor.withOpacity(.3)
                    // ),
                    padding:const EdgeInsets.symmetric(horizontal: 0),
                    child: ConditionalBuilder(
                      condition: FastCubit.get(context).cartId != data.id,
                      fallback: (c)=>const CupertinoActivityIndicator(),
                      builder: (c)=> Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              print(data.quantity);
                              int quantity = int.tryParse(data.quantity!)! +1;
                              FastCubit.get(context).updateCart(
                                  productId: data.id??'',
                                  quantity: quantity
                              );
                            },
                            child: Container(
                              height: 34,width: 34,
                              decoration: BoxDecoration(
                               shape: BoxShape.circle,
                                color: defaultColor
                              ),
                              alignment: AlignmentDirectional.center,
                              child: const AutoSizeText(
                                '+',
                                minFontSize: 8,
                                maxLines: 1,
                                style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.white,height: 2),
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),
                          AutoSizeText(
                            '${ data.quantity??''}',
                            minFontSize: 8,
                            maxLines: 1,
                            style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500),
                          ),
                          SizedBox(width: 8,),
                          InkWell(
                              onTap: (){
                                if(int.parse(data.quantity??"1") != 1){
                                  int quantity = int.tryParse(data.quantity!)! -1;
                                  FastCubit.get(context).updateCart(
                                      productId: data.id??'',
                                      quantity: quantity
                                  );
                                }
                              },
                              child:Container(
                                height: 34,width: 34,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:Colors.red
                                ),
                                alignment: AlignmentDirectional.center,
                                child: const AutoSizeText(
                                  '-',
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17.5,fontWeight:FontWeight.w500,color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: (){
              FastCubit.get(context).deleteCart(cartId: data.id??'');
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: Image.asset(Images.bin,width: 25,height: 25,color: Colors.red,),
            ),
          )
        ],
      ),
    );
  }
}
