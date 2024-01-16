import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/models/category_model.dart';
import 'package:safri/shared/components/uti.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'image_net.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({this.data, this.isRestaurant = false, this.isSearch = false,this.itemScrollController });

  final List<CategoryData>? data;
  ItemScrollController? itemScrollController;
  final bool isRestaurant;
  final bool isSearch;


  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  bool isShowMore=false;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: widget.data != null,
        fallback: (c) => SizedBox(),
        builder: (c) => SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(!widget.isRestaurant&&!widget.isSearch)
                    InkWell(
                      onTap: () {
                        HomeCategoryCubit.get(context).currentIndex = 0;
                        HomeCategoryCubit.get(context).categoryId='';
                        HomeCategoryCubit.get(context).providerCategoryModel=null;
                        HomeCategoryCubit.get(context).allProviderModel=null;
                        HomeCategoryCubit.get(context).paginationAllProvider();
                        HomeCategoryCubit.get(context).getAllProvider();
                      },
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      child: Column(
                        children: [
                          Container(
                            height: 66,
                            width: 66,
                            // padding: const EdgeInsetsDirectional.only(start: 10, end: 20),
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade400,
                                border: Border.all(color: HomeCategoryCubit.get(context).currentIndex == 0 ? defaultColor : Color(0xffF2F2F2))),
                            child: Padding(
                              padding: const EdgeInsets.all(1.5),
                              child: Center(
                                child: Text(
                                  'a'.tr(),
                                  style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          AutoSizeText(
                            'all_restaurant'.tr(),
                            minFontSize: 9,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: HomeCategoryCubit.get(context).currentIndex == 0?defaultColor:null),
                          ),
                        ],
                      ),
                    ),
                    if(!widget.isRestaurant&&!widget.isSearch)
                      const SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                          itemBuilder: (context,index)=>categoryItem(
                              widget.data![index],
                              !widget.isRestaurant&&!widget.isSearch
                                  ?index+1
                                  :index,context
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (c,i)=>const SizedBox(width: 25,),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.data!.length
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget categoryItem(CategoryData category, int index,BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.isSearch) {
          if(HomeCategoryCubit.get(context).categorySearchId.isNotEmpty){
            HomeCategoryCubit.get(context).currentIndex = 123;
          }else{
            HomeCategoryCubit.get(context).currentIndex = index;
          }
          HomeCategoryCubit.get(context).categorySearchId
          = HomeCategoryCubit.get(context).categorySearchId.isNotEmpty?'':category.id ?? '';
          HomeCategoryCubit.get(context).providerCategorySearchModel=null;
          HomeCategoryCubit.get(context).getProviderCategorySearch(search: HomeCategoryCubit.get(context).searchController.text);
          FastCubit.get(context).emitState();
        }
        else if (widget.isRestaurant) {
          widget.itemScrollController!.scrollTo(index: index, duration: Duration(seconds: 1));
          FastCubit.get(context).providerProductId = category.id ?? '';
          FastCubit.get(context).getAllProducts();
        }
        else {
          HomeCategoryCubit.get(context).currentIndex = index;
          HomeCategoryCubit.get(context).categoryId = category.id ?? '';
          HomeCategoryCubit.get(context).providerCategoryModel=null;
          HomeCategoryCubit.get(context).allProviderModel=null;
          HomeCategoryCubit.get(context).allProviderScrollController.removeListener((){});
          HomeCategoryCubit.get(context).getProviderCategory();

        }
      },
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Column(
        children: [
          Container(
            height: 66,
            width: 66,
            // padding: const EdgeInsetsDirectional.only(start: 10, end: 20),
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                // borderRadius: BorderRadiusDirectional.circular(48),
                color: HomeCategoryCubit.get(context).currentIndex == index ? defaultColor : Color(0xffF2F2F2)),
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: Center(
                child: UTI.cachedImage(
                       category.image ?? '',   width: 66,
                  height: 66,radius: 1000,fit: BoxFit.cover

                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          AutoSizeText(
            category.title ?? '',

            minFontSize: 9,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: HomeCategoryCubit.get(context).currentIndex == index?defaultColor:null),
          ),
        ],
      ),
    );
  }
}
