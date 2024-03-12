import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_states.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';
import 'package:safri/modules/worng_screenss/maintenance_screen.dart';

import '../modules/restaurant/restaurant_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/constant.dart';
import '../shared/images/images.dart';
import '../shared/styles/colors.dart';
import '../widgets/home/ad_dialog.dart';
import 'nav_screen.dart';

class FastLayout extends StatefulWidget {
  const FastLayout({Key? key}) : super(key: key);

  @override
  State<FastLayout> createState() => _FastLayoutState();
}

class _FastLayoutState extends State<FastLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLinkData();

  }

  void fetchLinkData() async {
    // FirebaseDynamicLinks.getInitialLInk does a call to firebase to get us the real link because we have shortened it.
    PendingDynamicLinkData? link = await FirebaseDynamicLinks.instance.getInitialLink();

    // This link may exist if the app was opened fresh so we'll want to handle it the same way onLink will.
    if (link != null) handleLinkData(link);

    // This will handle incoming links if the application is already opened
    // FirebaseDynamicLinks.instance.onLink;
    // FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData? dynamicLink) async {
    //   handleLinkData(dynamicLink!);
    // });
  }


  void handleLinkData(PendingDynamicLinkData data) {
    final Uri uri = data.link;
    final queryParams = uri.queryParameters;
    if (queryParams.isNotEmpty) {
      String? provider = queryParams["name"];
      print('provider id');
      print(provider);


      if (provider!.contains('RestaurantScreen')) {
        String? providerId = queryParams["id"];

        navigateTo(context, RestaurantScreen(id: providerId, ));
        // verify the username is parsed correctly

      }
     else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const FastLayout(),
        ));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    FastCubit.get(context).updateApp(context);
    return BlocConsumer<FastCubit, FastStates>(
      listener: (c, s) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        var cubit = FastCubit.get(context);
        return BlocConsumer<MenuCubit, MenuStates>(
          listener: (context, state) {
            if(isConnect!=null)checkNet(context);
            if(MenuCubit.get(context).settingsModel?.data?.isProjectInFactoryMode == 2){

              navigateAndFinish(context, MaintenanceScreen());
            }
          },
          builder: (context, state) {
            return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: SafeArea(
                child: NavBar(
                  items: [
                    {
                      'icon':
                      Image.asset(Images.homeNo, width: 30, height: 30),
                      'activeIcon':
                      Image.asset(Images.homeYes, width: 30, height: 30,color: defaultColor,),
                    },
                    {
                      'icon':
                      Image.asset(Images.cartNo, width: 30, height: 30),
                      'activeIcon': Image.asset(
                        Images.cartYes, width: 30, height: 30,color: defaultColor,),
                    },
                    {
                      'icon':
                      Image.asset(Images.menu, width: 30, height: 30,),
                      'activeIcon':
                      Image.asset(Images.menu, width: 30,
                        height: 30,
                        color: defaultColor,),
                    },
                  ],
                ),
              ),
            );
  },
);
          },
        );
      },
    );
  }
}
