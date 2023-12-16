import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/defult_form.dart';

class HaveDiscount extends StatelessWidget {
  HaveDiscount(this.controller);
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsetsDirectional.only(top: 30.0,bottom: 10,start: 20),
          child: AutoSizeText(
            tr('have_discount'),
            minFontSize: 8,
            maxLines: 1,
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child:DefaultForm(
              hint: tr('enter_discount'),
            controller: controller,
            suffix: ConditionalBuilder(
              condition: state is! CouponLoadingState,
              fallback: (c)=>const CupertinoActivityIndicator(),
              builder: (c)=> TextButton(
                child: AutoSizeText(tr('apply'), minFontSize: 8,
                  maxLines: 1,style: TextStyle(color: defaultColor),),
                onPressed: (){
                  if(controller.text.isNotEmpty){
                    FastCubit.get(context).coupon(controller.text);
                  }else{
                    showToast(msg: tr('coupon_empty'));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  },
);
  }
}

