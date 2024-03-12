import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../../../widgets/menu/wallet/no_wallet.dart';
import '../../../../widgets/menu/wallet/wallet_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
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
                  child:ConditionalBuilder(
                    condition: MenuCubit.get(context).userModel!=null,
                    fallback: (c)=>Center(child: CircularProgressIndicator(),),
                    builder: (c)=> ConditionalBuilder(
                      condition: MenuCubit.get(context).userModel?.data?.wallet != 0,
                      fallback: (c)=>NoWallet(),
                      builder: (c)=> WalletWidget(),
                    ),
                  )
                ),

              ],
            ),
          ),
        ],
      ),
    );
  },
);
  }
}

