import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/shared/styles/colors.dart';
import '../../item_shared/image_net.dart';
import 'list_gift_dialog.dart';

class GiftWidget extends StatelessWidget {
  const GiftWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = FastCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            tr('order_gift'),
            minFontSize: 8,
            maxLines: 1,
            style:const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 15,),
          ConditionalBuilder(
              condition: cubit.currentGift!=null,
              fallback: (c)=>NoGifts(),
              builder: (c)=> GiftItemSelected(cubit.currentGift!))
        ],
      ),
    );
  }
}

class NoGifts extends StatelessWidget {
  const NoGifts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 64,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadiusDirectional.circular(15)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: AlignmentDirectional.center,
      child: Row(
        children: [
          Text(
            'no_gifts'.tr(),
            style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              showDialog(context: context, builder: (context)=>ListGiftDialog());
            },
            child: Text(
              'restore_gift'.tr(),
              style: TextStyle(color: defaultColor,fontSize: 10,fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}


class GiftItemSelected extends StatelessWidget {
  GiftItemSelected(this.gift);

  GiftModel gift;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,height: 100,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadiusDirectional.circular(15)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: AlignmentDirectional.center,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${gift.title} ${gift.type == 'wallets_price'?'KWD ${'wallet'.tr()}':gift.type == 'coupoun'?'coupon'.tr():''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          showDialog(context: context, builder: (context)=>ListGiftDialog());
                        },
                        child: Text(
                          're_choose_gift'.tr(),
                          style: TextStyle(color: defaultColor,fontSize: 10,fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          FastCubit.get(context).couponModel=null;
                          FastCubit.get(context).removeGift();
                        },
                        child: Text(
                          'cancel_gift'.tr(),
                          style: TextStyle(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20,),
          if(gift.image!=null)
          Container(
            height: 81,
            width: 81,
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color:  defaultColor,width: 2)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ImageNet(image:gift.image!,),
          )
        ],
      ),
    );
  }
}


