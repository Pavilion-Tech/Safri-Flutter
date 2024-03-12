import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../modules/menu/menu_screens/account_screens/order/order_history_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/images/images.dart';

class DefaultAppBar extends StatelessWidget {
  DefaultAppBar(this.title,{this.isCart = false,this.isOrderHistory = false, this.color,   this.isDetailsScreen= false});
 final String title;
 final bool isCart,isOrderHistory,isDetailsScreen;
 final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 133,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // SizedBox(
          //     height: 133,
          //     width: double.infinity,
          //     child: Image.asset(
          //       Images.bubbles,
          //       height: 133,
          //       width: double.infinity,
          //       fit: BoxFit.cover,
          //     ),
          // ),
          if(isCart)
          AutoSizeText(
            title,
            minFontSize: 8,
            maxLines: 1,
            style: TextStyle(color: defaultColor,fontSize: 20),
          ),
          if(!isCart)
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                IconButton(onPressed: (){
                  if(isOrderHistory){
                    FastCubit.get(context).changeIndex(2);
                    navigateAndFinish(context, FastLayout());
                  }else if(isDetailsScreen){

                    navigateAndFinish(context, OrderHistoryScreen());
                  }else{
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.pop(context);
                  }

                }, icon: Icon(Icons.arrow_back_ios_outlined,color: defaultColor,)),
                AutoSizeText(
                  title,
                  minFontSize: 8,
                  maxLines: 1,
                  style: TextStyle(color: defaultColor,fontSize: 20),
                ),
                InkWell(
                  onTap:color==null? (){
                    FastCubit.get(context).changeIndex(1);
                    navigateAndFinish(context,FastLayout());
                  }:null,
                    child: Image.asset(Images.cartYes,width: 25,color: color??defaultColor,),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
