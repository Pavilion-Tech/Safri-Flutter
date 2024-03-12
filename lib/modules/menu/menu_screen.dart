import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/modules/log_body.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';
import 'package:safri/modules/menu/menu_screens/our_screen/aboutus_screen.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/splash_screen.dart';
import 'package:safri/widgets/item_shared/default_button.dart';
import 'package:share_plus/share_plus.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/firebase_helper/firebase_dynamic_link.dart';
import '../../widgets/menu/delete_account_dialog.dart';
import '../../widgets/menu/lang_dialog.dart';
import '../../widgets/menu/menu_appbar.dart';
import '../addresses/addresses_screen.dart';
import 'menu_screens/account_screens/notification_screen.dart';
import 'menu_screens/account_screens/order/order_history_screen.dart';
import 'menu_screens/account_screens/profile_screen.dart';
import 'menu_screens/account_screens/wallet_screen.dart';
import 'menu_screens/our_screen/contact_screen.dart';
import 'menu_screens/our_screen/favorites_screen.dart';
import 'menu_screens/our_screen/terms_aboutus_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return ConditionalBuilder(
      condition: token!=null,
      fallback: (c)=>Center(child: LogBody()),
      builder: (c)=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    if(token!=null)
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Center(
                         child: Text(
                           tr('account_settings'),
                           style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                         ),
                       ),
                       itemBuilder(
                           title: tr('profile_info'),
                           onPressed: (){
                             navigateTo(context, ProfileScreen());
                           }
                       ),
                       itemBuilder(
                           title:tr('previous_orders'),
                           onPressed: (){
                             navigateTo(context, OrderHistoryScreen());
                           }
                       ),
                       itemBuilder(
                           title:tr('Wallet'),
                           onPressed: (){
                             navigateTo(context, WalletScreen());
                           }
                       ),
                       // itemBuilder(
                       //     title: tr('wallet'),
                       //     onPressed: (){
                       //       navigateTo(context, WalletScreen());
                       //     }
                       // ),
                       itemBuilder(
                           title: tr('notifications'),
                           onPressed: (){
                             navigateTo(context, NotificationScreen());
                           }
                       ),
                       itemBuilder(
                           title: tr('Favorites'),
                           onPressed: (){
                             navigateTo(context, FavoritesScreen());
                           }
                       ),
                       itemBuilder(
                           title: tr('Addresses'),
                           onPressed: (){
                             navigateTo(context, AddressesScreen());
                           }
                       ),
                     ],
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Center(
                         child: Text(
                           tr('our_app'),
                           style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.black),
                         ),
                       ),
                       itemBuilder(
                           title: tr('languages'),
                           onPressed: (){
                             showDialog(
                                 context: context,
                                 builder: (context)=>LangDialog()
                             );
                           }
                       ), itemBuilder(
                           title: tr('contact_us'),
                           onPressed: (){
                             navigateTo(context, ContactScreen());
                           }
                       ), itemBuilder(
                           title: tr('about_us'),
                           onPressed: (){
                             navigateTo(context, AboutUsScreen());
                           }
                       ),itemBuilder(
                           title: tr('terms'),
                           onPressed: (){
                             navigateTo(context, TermsScreen());
                           }
                       ),itemBuilder(
                           title: tr('share_app'),
                           onPressed: () async{
                             String link = '';
                             if(defaultTargetPlatform == TargetPlatform.iOS){
                               link = 'https://apps.apple.com/us/app/safri-foods-coffee-order/id6474440706';
                             }else{
                               link = 'https://play.google.com/store/apps/details?id=com.safri.pavilion&pli=1';
                             }
                             Share.share(link);

                           }
                       ),itemBuilder(
                           title: '${tr('version')} $version',
                       ),
                       TextButton(
                         onPressed: null,
                         child: Row(
                           children: [
                             Text(
                               tr('powered_by'),
                               style:const TextStyle(color: Colors.black,fontSize: 16.4),
                             ),
                             const SizedBox(width: 10,),
                             Image.asset(Images.pavilion,width: 20,)
                           ],
                         ),
                       ),
                       Center(
                           child: DefaultButton(
                           text: tr('logout'),
                           onTap: (){
                             MenuCubit.get(context).log(context);
                           })
                       ),
                       Center(
                         child: TextButton(
                           onPressed: (){
                             showDialog(
                                 context: context,
                                 builder: (context)=>DeleteAccountDialog()
                             );
                           },
                           child: Text(
                             tr('delete_account'),
                             style: TextStyle(color: defaultColor),
                           ),
                         ),
                       ),
                     ],
                   ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget itemBuilder({required String title,VoidCallback? onPressed}){
    return TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style:const TextStyle(color: Colors.black,fontSize: 16.4),
        ),
    );
  }
}
