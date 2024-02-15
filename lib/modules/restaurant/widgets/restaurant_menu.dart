import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_states.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/category_widget.dart';
import 'package:safri/widgets/restaurant/product.dart';
import 'package:safri/widgets/shimmer/default_list_shimmer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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

  List<Key> key=[];

  ItemScrollController scrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  bool isFirst = true;
  @override
  void initState() {
    super.initState();
    if(widget.cubit.singleProviderModel?.data?.childCategoriesModified?.isNotEmpty??false)
    itemPositionsListener.itemPositions.addListener(() {
      final indices = itemPositionsListener.itemPositions.value.map((e) => e.index);
      String _index1 = indices.toString().replaceAll(')', '');
      String _index2 = _index1.toString().replaceAll('(', '');
      String _index3 = _index2.toString().replaceAll(',', '');
      String _index4 = _index3.toString().replaceAll(' ', '');
      if(!isFirst){
        if(_index4.length ==1){
          HomeCategoryCubit.get(context).currentIndex = int.parse(_index4);
          HomeCategoryCubit.get(context).emitState();
          //setState(() {});
        }else{
          // print(_index4.toString().characters.first);
          // print(_index4.toString().characters);
          // print(_index4.toString().characters.last);
          if(HomeCategoryCubit.get(context).currentIndex != _index4.toString().characters.first){
            HomeCategoryCubit.get(context).currentIndex = int.parse(_index4.toString().characters.first);
            HomeCategoryCubit.get(context).emitState();
            //setState(() {});
          }
        }
      }

    });
    isFirst = false;
    HomeCategoryCubit.get(context).currentIndex=0;
    setState(() {});
  }

  @override
  void dispose() {
    itemPositionsListener.itemPositions.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return BlocConsumer<FastCubit,FastStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:widget.cubit.singleProviderModel?.data?.childCategoriesModified?.isNotEmpty??false,
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
            condition: widget.cubit.productsModel.isNotEmpty,
            fallback: (c)=>Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: DefaultListShimmer(),
            ),
            builder: (c)=> Column(
              children: [
                Padding(
                  padding:EdgeInsetsDirectional.only(top: 0,start: 20),
                  child: CategoryWidget(
                      data: widget.cubit.singleProviderModel?.data?.childCategoriesModified,
                      isRestaurant: true,
                      itemScrollController: scrollController,
                  ),
                ),
                ConditionalBuilder(
                    condition: widget.cubit.productsModel.isNotEmpty,
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
                      return Expanded(
                        child: ScrollablePositionedList.separated(
                            padding: EdgeInsets.only(bottom: size!.height*.4),
                            itemBuilder: (c,index)=>Builder(
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 30,width: double.infinity,
                                      color: Colors.grey.shade300,
                                      padding: EdgeInsets.symmetric(horizontal: 30),
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(widget.cubit.singleProviderModel?.data?.childCategoriesModified?[index].title??''),
                                    ),
                                    ListView.separated(
                                      itemBuilder: (c,i)=>Product(
                                          widget.cubit.productsModel[index].data?.data?[i],
                                          widget.cubit.singleProviderModel?.data?.openStatus == 'closed'?true:false
                                      ),
                                      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                                      itemCount: widget.cubit.productsModel[index].data?.data?.length??0,
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(top: 20,right: 20,left: 20),
                                    ),
                                  ],
                                );
                              }
                            ),
                            itemPositionsListener: itemPositionsListener,
                            itemScrollController: scrollController,
                            separatorBuilder: (c,index)=>const SizedBox(height: 20,),
                            itemCount: widget.cubit.singleProviderModel?.data?.childCategoriesModified?.length??0
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
  },
);
  }
}