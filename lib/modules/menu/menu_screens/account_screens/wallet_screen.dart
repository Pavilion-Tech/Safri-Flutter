import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('wallet')),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Image.asset(Images.wallet,width: size!.width*.6,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 30.0),
                //   child:Text.rich(
                //       TextSpan(
                //           text: '2.589',
                //           style: TextStyle(color: defaultColor,fontWeight: FontWeight.w600,fontSize: 35),
                //           children: [
                //             TextSpan(
                //               text: 'SAR',
                //               style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontSize: 11),
                //             )
                //           ]
                //       )
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child:Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "${tr('2.589')}",
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
                      SizedBox(height: 15,),
                      AutoSizeText(
                        tr('Your_Bending_Earning'),
                        minFontSize: 8,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style:const TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15,height: 1),
                      ),
                      const SizedBox(height: 30,),

                    ],
                  )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
