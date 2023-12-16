import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

class NoCarts extends StatelessWidget {
  const NoCarts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Images.cartIsEmpty),
          const SizedBox(height: 15,),
          // Text(
          //   tr('opps'),
          //   style: TextStyle(
          //     color: defaultColor,
          //     fontSize: 35,fontWeight: FontWeight.w600
          //   ),
          // ),
          Text(
            tr('The_Cart_Is_Empty'),
            style: TextStyle(
              fontSize: 35,color: defaultColor,fontWeight: FontWeight.w600
            ),
          ),
          Text(
            tr('We_Suggest_to_add_your_next_meal'),
            style: TextStyle(
              fontSize: 15,fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(height: 30,),
          DefaultButton(
              text: tr('start_shopping'),
              onTap: (){
                FastCubit.get(context).changeIndex(0);
              }
          )
        ],
      ),
    );
  }
}
