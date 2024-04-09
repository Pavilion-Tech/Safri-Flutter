import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/modules/restaurant/restaurant_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../models/coupon_model.dart';
import '../../../shared/styles/colors.dart';
import '../../item_shared/image_net.dart';

class GiftModel {
  String title;
  String id;
  String type;
  String? image;
  bool isPriceEnoughToUse;
  dynamic requiredPriceToUse;
  dynamic discountValue;
  dynamic discountType;

  GiftModel({
    required this.title,
    required this.type,
    this.image,
    required this.id,
    required this.isPriceEnoughToUse,
    this.requiredPriceToUse,
    this.discountValue,
    this.discountType,
  });
}

class ListGiftDialog extends StatelessWidget {
  ListGiftDialog({Key? key}) : super(key: key);


  GiftModel? currentGift;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FastCubit.get(context);
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: IconButton(
                        onPressed: () {
                          cubit.removeGift();
                          Navigator.pop(context);
                        },
                        icon: Image.asset(Images.cancel, width: 21,color: Colors.black,))
                ),
                Text(
                  'choose_gift'.tr(),
                  style: TextStyle(fontSize: 15.2, fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Container(
                    height: size!.height * .43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(22.7),
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if(cubit.cartModel?.data?.gifts?.products?.isNotEmpty??false)
                          category('products'.tr()),
                          if(cubit.cartModel?.data?.gifts?.products?.isNotEmpty??false)
                          ListView.separated(
                              itemBuilder: (c, i) => giftItem(
                                GiftModel(
                                  title: cubit.cartModel?.data?.gifts?.products?[i].title??'',
                                  id: cubit.cartModel?.data?.gifts?.products?[i].id??'',
                                  image: cubit.cartModel?.data?.gifts?.products?[i].mainImage??'',
                                  type: 'product',
                                  isPriceEnoughToUse: cubit.cartModel?.data?.gifts?.products?[i].isPriceEnoughToUse??false,
                                  requiredPriceToUse: cubit.cartModel?.data?.gifts?.products?[i].requiredPriceToUse

                                ),
                                context
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              separatorBuilder: (c, i) => const SizedBox(height: 10,),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.cartModel?.data?.gifts?.products?.length??0
                          ),
                          if(cubit.cartModel?.data?.gifts?.walletsPrices?.isNotEmpty??false)
                            category('wallet'.tr()),
                          if(cubit.cartModel?.data?.gifts?.walletsPrices?.isNotEmpty??false)
                          ListView.separated(
                              itemBuilder: (c, i) => giftItem(
                                  GiftModel(
                                      title: '${cubit.cartModel?.data?.gifts?.walletsPrices?[i].price??''}',
                                      id: cubit.cartModel?.data?.gifts?.walletsPrices?[i].id??'',
                                      type: 'wallets_price',
                                      isPriceEnoughToUse: cubit.cartModel?.data?.gifts?.walletsPrices?[i].isPriceEnoughToUse??false,
                                      requiredPriceToUse: cubit.cartModel?.data?.gifts?.walletsPrices?[i].requiredPriceToUse
                                  ),
                                  context
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              separatorBuilder: (c, i) => const SizedBox(height: 10,),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.cartModel?.data?.gifts?.walletsPrices?.length??0
                          ),
                          if(cubit.cartModel?.data?.gifts?.coupouns?.isNotEmpty??false)
                            category('coupons'.tr()),
                          if(cubit.cartModel?.data?.gifts?.coupouns?.isNotEmpty??false)
                          ListView.separated(
                              itemBuilder: (c, i) => giftItem(
                                  GiftModel(
                                    title: '${cubit.cartModel?.data?.gifts?.coupouns?[i].code??''}',
                                    id: cubit.cartModel?.data?.gifts?.coupouns?[i].id??'',
                                    type: 'coupoun',
                                    discountType: cubit.cartModel?.data?.gifts?.coupouns?[i].discountType??'',
                                    discountValue: cubit.cartModel?.data?.gifts?.coupouns?[i].discountValue??'',
                                    isPriceEnoughToUse: cubit.cartModel?.data?.gifts?.coupouns?[i].isPriceEnoughToUse??false,
                                    requiredPriceToUse: cubit.cartModel?.data?.gifts?.coupouns?[i].requiredPriceToUse
                                  ),
                                  context
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              separatorBuilder: (c, i) => const SizedBox(height: 10,),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cubit.cartModel?.data?.gifts?.coupouns?.length??0
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if(cubit.currentDisableGift.isEmpty)
                DefaultButton(
                    text: 'accept_gift'.tr(),
                    onTap: () {
                      if(cubit.currentGift!=null){
                        if(cubit.currentGift!.type =='coupoun'){
                          cubit.changeWallet(false);
                          cubit.couponModel = CouponModel.fromJson(
                              {
                                'data':{
                                  "discount_value":cubit.currentGift!.discountValue,
                                  "discount_type":cubit.currentGift!.discountType,
                                  "is_applied":true,
                                }
                              }
                          );
                        }else{
                          cubit.couponModel=null;
                        }
                        cubit.emitState();
                        Navigator.pop(context);
                      }else{
                        showToast(msg: 'choose_gift_first'.tr(),toastState: true);
                      }
                    }
                ),
                if(cubit.currentDisableGift.isNotEmpty)
                  DefaultButton(
                      text: 'continue_shopping'.tr(),
                      onTap: (){
                        cubit.changeIndex(0);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        navigateTo(context, RestaurantScreen(
                          id:cubit.cartModel?.data?.cart?[0].providerId??'' ,));
                      },
                  ),
                const SizedBox(height: 20,),
                DefaultButton(
                  text: 'cancel'.tr(),
                  color: Colors.transparent,
                  textColor: defaultColor,
                  onTap: (){
                    cubit.removeGift();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget giftItem(GiftModel gift,BuildContext context){
    return InkWell(
      onTap: (){
        if(gift.isPriceEnoughToUse){
          FastCubit.get(context).chooseGift(gift);
        }else{
          FastCubit.get(context).chooseDisableGift(gift.id??'');
          showToast(
              toastState: false,
              gravity: ToastGravity.TOP,
              msg: '${'you_need_to_have_a'.tr()} ${gift.requiredPriceToUse??'0'} KWD ${'order_to_have_a'.tr()} ${gift.type == 'product'?gift.title:gift.type == 'coupoun'?'${'coupon'.tr()} ${gift.title} ${gift.discountType ==1 ?'%':'KWD'}': '${'wallet'.tr()} ${gift.title} KWD'}');
        }
      },
      child: Row(
        children: [
          if(gift.image!=null)
          Container(
            width: size!.width*.15,
            height: size!.width*.15,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ImageNet(image:gift.image??"",),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: AutoSizeText(
              '${gift.title} ${gift.type == 'wallets_price'?'KWD':''}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 12,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: FastCubit.get(context).currentGift?.id== gift.id
                  ?defaultColor:FastCubit.get(context).currentDisableGift == gift.id
                  ?Colors.red
                  :null,
            ),
          ),
        ],
      ),
    );
  }

  Widget category(String title){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 30,width: double.infinity,
        color: Colors.grey.shade300,
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: AlignmentDirectional.centerStart,
        child: Text(title),
      ),
    );
  }
}


