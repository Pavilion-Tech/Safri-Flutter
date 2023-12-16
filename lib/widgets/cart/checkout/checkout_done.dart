import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/modules/menu/menu_screens/account_screens/order/order_history_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/cart/checkout/web_view_screen.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../../models/order_model.dart';
import '../../../modules/menu/menu_screens/account_screens/order/order_details_screen.dart';

class CheckoutDone extends StatelessWidget {
  CheckoutDone(this.urlToPay, this.isPay, {this.data});
 final String urlToPay;
  final bool isPay;
  OrderData? data;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () => Navigator.pop(context),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Images.checkoutDialog,
                  width: 200,
                ),
                Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                        text: tr('congratulations'),
                        style:const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                        children: [
                          TextSpan(
                              text:isPay==false? tr('Your_request_has_been_sent_successfully'): tr('order_success'),
                              style:const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15),
                              children: [
                                // TextSpan(
                                //     text: '${id}',
                                //     style: TextStyle(
                                //         color: defaultColor,fontWeight:FontWeight.w700, fontSize: 15
                                //     )),
                              ]),
                        ])),
                // const SizedBox(height: 20,),
                // if(isPay==true)
                //   DefaultButton(
                //       text: tr('Go_to_pay'),
                //       onTap: () {
                //
                //         navigateTo(context, WebViewCustomScreen(url: urlToPay));
                //       }),
                const SizedBox(height: 20,),

                DefaultButton(
                    text:tr("continue_shopping"),
                    onTap: () {
                      FastCubit.get(context).changeIndex(0);
                      navigateAndFinish(context, FastLayout());
                    }) ,

                TextButton(
                    onPressed: () {
                      MenuCubit.get(context).getAllOrders();
                      // FastCubit.get(context).changeIndex(0);
                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      navigateTo(context, OrderDetailsScreen(data!));
                      // navigateAndFinish(context, OrderHistoryScreen());
                    },
                    child: AutoSizeText(
                      tr('order_details'),
                      minFontSize: 8,
                      maxLines: 1,
                      style: TextStyle(
                          color: defaultColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
