import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../modules/menu/cubit/menu_cubit.dart';
import '../../../shared/styles/colors.dart';

class WalletWidget extends StatelessWidget {
  WalletWidget({super.key});

  String price = '';

  bool checkPriceLength(BuildContext context){
    if(MenuCubit.get(context).userModel!.data!.wallet!.toString().length > 6)
      return true;
    return false;
  }

  void changePriceValue(BuildContext context){
    price = MenuCubit.get(context).userModel?.data?.wallet?.toString().replaceRange(6, MenuCubit.get(context).userModel?.data?.wallet.toString().length, '')??'';
  }

  @override
  Widget build(BuildContext context) {
    price = MenuCubit.get(context).userModel?.data?.wallet?.toString()??'';
    if(checkPriceLength(context)){
      changePriceValue(context);
    }
    return Column(
      children: [
        SizedBox(height: 15,),
        AutoSizeText(
          tr('your_wallet_balance'),
          minFontSize: 8,
          maxLines: 1,
          textAlign: TextAlign.center,
          style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15,height: 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoSizeText(
              "${tr(price)}",
              minFontSize: 8,
              maxLines: 1,
              style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
            ),
            Column(
              children: [
                SizedBox(height: 15,),
                AutoSizeText(
                  " ${tr("KWD")}",
                  minFontSize: 8,
                  maxLines: 1,
                  style: TextStyle(color: Color(0xff4B4B4B),fontWeight: FontWeight.w600,fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
