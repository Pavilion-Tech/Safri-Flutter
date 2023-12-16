import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/category_widget.dart';
import 'package:safri/widgets/restaurant/product.dart';
import 'package:safri/widgets/shimmer/default_list_shimmer.dart';

import '../../home/cubits/home_category_cubit/home_category_cubit.dart';

class RestaurantMenu extends StatefulWidget {
  const RestaurantMenu({
    super.key,
    required this.cubit,
  });

  final FastCubit cubit;

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCategoryCubit.get(context).currentIndex=0;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit,FastStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:widget.cubit.singleProviderModel?.data?.childCategoriesModified?.isNotEmpty??true,
          fallback: (c)=>Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.splashImage,width: 200,),
                  AutoSizeText(tr('no_products'), minFontSize: 8,
                    maxLines: 1,),
                ],
              )),
          builder: (c)=> ConditionalBuilder(
            condition: widget.cubit.productsModel!=null,
            fallback: (c)=>Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DefaultListShimmer(),
            ),
            builder: (c)=> Column(
              children: [
                Padding(
                  padding:EdgeInsetsDirectional.only(top: 0,start: 20),
                  child: CategoryWidget(data: widget.cubit.singleProviderModel?.data?.childCategoriesModified,isRestaurant: true),
                ),
                ConditionalBuilder(
                    condition: widget.cubit.productsModel!.data!.data!.isNotEmpty,
                    fallback: (c)=>Expanded(child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.splashImage,width: 200,),
                            AutoSizeText(tr('no_products'), minFontSize: 8,
                              maxLines: 1,),
                          ],
                        ))),
                    builder: (c){
                      Future.delayed(Duration.zero, () {
                        widget.cubit.paginationProviderProducts();
                      });
                      return Expanded(
                        child: Column(
                          children: [
                            if (state is ProviderProductsLoadingState)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
                                  child:DefaultListShimmer(),
                                ),
                              )else
                            Expanded(
                                child: ListView.separated(

                                  itemBuilder: (c,i)=>Product(
                                      widget.cubit.productsModel!.data!.data![i],
                                      widget.cubit.singleProviderModel!.data!.openStatus == 'closed'?true:false
                                  ),
                                  separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                                  itemCount: widget.cubit.productsModel!.data!.data!.length,
                                  controller:widget.cubit.productsScrollController,
                                  padding: EdgeInsets.only(top: 20,right: 20,left: 20,),
                                )
                            ),

                          ],
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        );
      },

    );
  }
}