
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/modules/restaurant/widgets/restaurant_app_bar.dart';
import 'package:safri/modules/restaurant/widgets/restaurant_menu.dart';
import 'package:safri/widgets/restaurant/app_bar.dart';
import 'package:safri/widgets/shimmer/default_list_shimmer.dart';


import 'widgets/info.dart';

class RestaurantScreen extends StatefulWidget {
  RestaurantScreen({ this.isBranch = false,   this.id});

 // final ProviderData? providerData;
  final bool isBranch;
  final String? id;


  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    FastCubit.get(context).singleProviderModel=null;
    FastCubit.get(context).singleProvider(widget.id??'',context);
    _tabController =  TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<FastCubit, FastStates>(
          listener: (context, state) {
           if(state is SingleProviderWrongState){
             Navigator.pop(context);
           }
          },
          builder: (context, state) {
            var cubit = FastCubit.get(context);
            if (cubit.singleProviderModel ==null) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DefaultListShimmer(),
              );
            }
            // if (cubit.singleProviderModel ==null && state is SingleProviderSuccessState) {
            //   return UTI.dataEmptyWidget(noData: tr("noDataFounded"), imageName: Images.productNotFound);
            // }
            // if (state is SingleProviderErrorState) {
            //   return
            //     UTI.dataEmptyWidget(noData: tr("noDataFounded"), imageName: Images.productNotFound);
            // }
            return Column(
              children: [

                  RestaurantAppBar(tabController: _tabController, cubit: cubit),

                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: [
                        RestaurantMenu(cubit: cubit),
                        Info(cubit.singleProviderModel!.data!)
                      ]
                  ),
                )
              ],
            );
          },

        )
    );
  }

  
}






