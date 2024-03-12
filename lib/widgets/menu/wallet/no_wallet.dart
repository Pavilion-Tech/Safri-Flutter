import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../../modules/menu/cubit/menu_cubit.dart';
import '../../../shared/styles/colors.dart';

class NoWallet extends StatelessWidget {
  const NoWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 15,),
        AutoSizeText(
          tr('dont_have_payments'),
          minFontSize: 8,
          maxLines: 1,
          textAlign: TextAlign.center,
          style:const TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 24,height: 1),
        ),
        SizedBox(height: 10,),
        AutoSizeText(
          tr('dont_have_payments_note'),
          minFontSize: 15,
          maxLines: 1,
          textAlign: TextAlign.center,
          style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15,height: 1),
        ),
        SizedBox(height: 30,),
        DefaultButton(text: 'continue_shopping'.tr(), onTap: (){
          Navigator.pop(context);
          FastCubit.get(context).changeIndex(0);
        })
      ],
    );
  }
}
