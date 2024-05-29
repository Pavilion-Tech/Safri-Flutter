import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/shared/styles/colors.dart';

class WalletBalance extends StatelessWidget {

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            'use_wallet_balance'.tr() + '(${price} KWD)',
            style: TextStyle(fontSize: 14.4,fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          Switch(
              value: FastCubit.get(context).useWallet,
              activeColor: defaultColor,
              activeTrackColor: Colors.grey.shade200,
              onChanged: (val){
                if(MenuCubit.get(context).userModel?.data?.wallet !=0){
                  FastCubit.get(context).changeWallet(val);
                }
              })
        ],
      ),
    );
  }
}
