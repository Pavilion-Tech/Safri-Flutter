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

import '../../modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'image_net.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({this.data, this.isRestaurant = false, this.isSearch = false,  });

  final List<CategoryData>? data;

  final bool isRestaurant;
  final bool isSearch;


  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  bool isShowMore=false;
  @override
  void initState() {
    if (widget.isSearch) {
      if (widget.data != null) {
        HomeCategoryCubit.get(context).categorySearchId = widget.data![0].id ?? '';
        FastCubit.get(context).emitState();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
        condition: widget.data != null,
        fallback: (c) => SizedBox(),
        builder: (c) => SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  AlignedGridView.count(
                     padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount:isShowMore? widget.data?.length: widget.data?.take(4).length,
                      itemBuilder: (context, index) {
                        return categoryItem(widget.data![index], index);
                      }

                      // Wrap(
                      //   spacing: 15,
                      //   runSpacing: 15,
                      //   children: List.generate(widget.data!.length, (i) => categoryItem(widget.data![i], i)),
                      // ),
                      ),
                  if(widget.data!.length >4)
                  InkWell(
                    onTap: () {
                          isShowMore=!isShowMore;
                          setState(() {

                          });
                    },
                    child: AutoSizeText(isShowMore? tr('Show_Less'): tr('Show_More'),
                      minFontSize: 8,
                      maxLines: 1,
                      style: TextStyle(

                        decoration: TextDecoration.underline,
                      color: defaultColor,fontSize: 14,fontWeight: FontWeight.w500
                    ),),
                  )
                ],
              ),
            ));
  }

  Widget categoryItem(CategoryData category, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          HomeCategoryCubit.get(context).currentIndex = index;
          if (widget.isSearch) {
            HomeCategoryCubit.get(context).categorySearchId = category.id ?? '';
            HomeCategoryCubit.get(context).providerCategorySearchModel=null;
            HomeCategoryCubit.get(context).getProviderCategorySearch(search: HomeCategoryCubit.get(context).searchController.text.isNotEmpty?
            HomeCategoryCubit.get(context).searchController.text:"");
            FastCubit.get(context).emitState();
          }
          else if (widget.isRestaurant) {
            FastCubit.get(context).providerProductId = category.id ?? '';
            FastCubit.get(context).getAllProducts();
          }
          else {
            HomeCategoryCubit.get(context).categoryId = category.id ?? '';
            HomeCategoryCubit.get(context).categorySearchId = category.id ?? '';
            print("HomeCategoryCubit.get(context).categoryId ");
            print(HomeCategoryCubit.get(context).categoryId );
            HomeCategoryCubit.get(context).providerCategoryModel=null;


            HomeCategoryCubit.get(context).getProviderCategory();

          }

        });
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
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: UTI.cachedImage(
                       category.image ?? '',   width: 50,
                  height: 50,radius: 1000

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
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
