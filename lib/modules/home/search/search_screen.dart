import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/shimmer/default_list_shimmer.dart';
import '../../../widgets/home/filter_bottom_sheet.dart';
import '../../../widgets/item_shared/category_widget.dart';
import '../../../widgets/item_shared/defult_form.dart';
import '../../../widgets/item_shared/filter.dart';
import '../../../widgets/item_shared/provider_item.dart';
import '../../../widgets/shimmer/home_shimmer.dart';
import '../cubits/home_category_cubit/home_category_states.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  ScrollController gridController = ScrollController();
  bool closeTop = false;
  @override
  void initState() {
    gridController.addListener(() {
      setState(() {
        closeTop = gridController.offset > 100;
      });
    });

    super.initState();
    HomeCategoryCubit.get(context).currentIndex=123;
    HomeCategoryCubit.get(context).categorySearchId='';
    HomeCategoryCubit.get(context).searchController.clear();
    HomeCategoryCubit.get(context).categoriesModel=null;

      print("theeeeee");
      print("HomeCategoryCubit.get(context).categoriesModel?.data?.");
      print(HomeCategoryCubit.get(context).categoriesModel?.data?.length);
      HomeCategoryCubit.get(context).getCategory(isSearch: true) ;


  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCategoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: InkWell(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: DefaultForm(
                            hint: tr('find_restaurant'),
                            suffix: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(Images.search, width: 16,
                                color: Colors.grey.shade500,),
                            ),
                            controller: HomeCategoryCubit.get(context).searchController,
                            onChange: (str){
                              if(str.isNotEmpty){
                                cubit.getProviderCategorySearch(search: str);
                              }else{
                                cubit.providerCategorySearchModel = null;
                                HomeCategoryCubit.get(context).getProviderCategorySearch(search: HomeCategoryCubit.get(context).searchController.text);
                                cubit.emitState();
                              }
                            },
                          ),
                        ),
                        if (cubit.categoriesModel?.data?.isEmpty ?? true && state is HomeCategoryLoadingState)
                          HomeShimmer()
                        else if (cubit.categoriesModel?.data?.isEmpty ?? true && state is HomeCategorySuccessState)
                          Center(child: AutoSizeText(tr('no_categories'),
                            minFontSize: 8,
                            maxLines: 1,))
                        else if (state is HomeCategoryErrorState)
                            Center(child: AutoSizeText(tr('no_categories'), minFontSize: 8,
                              maxLines: 1,))
                          else
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: CategoryWidget(data: cubit.categoriesModel!.data,isSearch: true),
                            ),
                        if (cubit.providerCategorySearchModel==null && state is ProviderCategorySearchLoadingState)
                          DefaultListShimmer(),
                        if (cubit.providerCategorySearchModel?.data?.data?.length ==0  && state is ProviderCategorySearchSuccessState)
                          Center(child: AutoSizeText(tr('no_restaurant'), minFontSize: 8,
                            maxLines: 1,)),
                        if (state is ProviderCategorySearchErrorState)
                          Center(child: AutoSizeText(tr('no_restaurant'), minFontSize: 8,
                            maxLines: 1,)),
                        if (cubit.providerCategorySearchModel?.data?.data?.isNotEmpty??true )
                          Column(
                            children: [
                              // if (state is ProviderCategoryLoadingState) Center(child: CupertinoActivityIndicator()),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (c, i) => ProviderItem(providerData: cubit.providerCategorySearchModel!.data!.data![i]),
                                separatorBuilder: (c, i) => const SizedBox(
                                  height: 20,
                                ),
                                itemCount: cubit.providerCategorySearchModel?.data?.data?.length??0,
                                controller: gridController,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                              ),
                            ],
                          )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}






// class SearchScreen1 extends StatelessWidget {
//   SearchScreen1({Key? key}) : super(key: key);
//
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = HomeCategoryCubit.get(context);
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//           body: InkWell(
//             onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
//             overlayColor: MaterialStateProperty.all(Colors.transparent),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: Expanded(
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       DefaultForm(
//                         hint: tr('find_restaurant'),
//                         suffix: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Image.asset(Images.search, width: 16,
//                             color: Colors.grey.shade500,),
//                         ),
//                         controller: controller,
//                         onChange: (str){
//                           if(str.isNotEmpty){
//                             cubit.getProviderCategorySearch(search: str);
//                           }else{
//                             cubit.providerCategorySearchModel = null;
//                             cubit.emitState();
//                           }
//                         },
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 20.0),
//                         child: CategoryWidget(data: cubit.categoriesModel!.data,isSearch: true),
//                       ),
//                       ConditionalBuilder(
//                         condition: state is! ProviderCategorySearchLoadingState,
//                         fallback: (c)=>DefaultListShimmer(havePadding: false),
//                         builder: (c)=> ConditionalBuilder(
//                           condition: cubit.providerCategorySearchModel!=null,
//                           fallback: (c)=>const SizedBox(),
//                           builder: (c)=> ConditionalBuilder(
//                             condition: cubit.providerCategorySearchModel!.data!.data!.isNotEmpty,
//                             fallback: (c)=>AutoSizeText(tr('no_results'),
//                               minFontSize: 8,
//                               maxLines: 1,),
//                             builder: (c){
//                               Future.delayed(Duration.zero,(){
//                                 cubit.paginationProviderCategorySearch(controller.text);
//                               });
//                               return Column(
//                                 children: [
//                                   ListView.separated(
//                                     itemBuilder: (c, i) => ProviderItem(providerData: cubit.providerCategorySearchModel!.data!.data![i]),
//                                     separatorBuilder: (c, i) =>
//                                     const SizedBox(height: 20,),
//                                     shrinkWrap: true,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     controller: cubit.providerSearchScrollController,
//                                     itemCount: cubit.providerCategorySearchModel!.data!.data!.length,
//                                   ),
//                                   if(state is ProviderCategorySearchLoadingState)
//                                     CupertinoActivityIndicator()
//                                 ],
//                               );
//                             }
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


