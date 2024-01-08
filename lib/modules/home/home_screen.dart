import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_states.dart';
import 'package:safri/modules/home/search/search_screen.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/home/slider.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/item_shared/category_widget.dart';
import '../../widgets/item_shared/provider_item.dart';
import '../../widgets/shimmer/default_list_shimmer.dart';
import '../../widgets/shimmer/home_shimmer.dart';
import 'map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool closeTop = false;
  ScrollController gridController = ScrollController();

  @override
  void initState() {
    gridController.addListener(() {
      setState(() {
        closeTop = gridController.offset > 100;
      });
    });

    super.initState();
      // HomeCategoryCubit.get(context).init();
     if(HomeCategoryCubit.get(context).categoriesModel?.data?.isEmpty??true)
       {
         print("theeeeee");
         print("HomeCategoryCubit.get(context).categoriesModel?.data?.");
         print(HomeCategoryCubit.get(context).categoriesModel?.data?.length);
         HomeCategoryCubit.get(context).getCategory();
       }
    if(lat!=null){
      HomeCategoryCubit.get(context).position=LatLng(lat!,lng!);
      print('position ${HomeCategoryCubit.get(context).position}');
      HomeCategoryCubit.get(context).getAddress(HomeCategoryCubit.get(context).position!);
    }

    show();
  }

  show() async {
    await Future.delayed(Duration(seconds: 1));

   // showDialog(context: context, builder: (context) => ReviewRestaurantDialog(providerId: '6550eed05d8096607ea0d987',));
  }

  @override
  void dispose() {
    gridController.removeListener(() {});
    gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCategoryCubit.get(context);
        return SafeArea(
          child: Column(
            children: [
              homeAppBar(context),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  // controller: HomeCategoryCubit.get(context).controllerScroll,
                  children: [
                    HomeSlider(closeTop),
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
                      child: CategoryWidget(
                          data: cubit.categoriesModel!.data,

                      ),
                    ),
                    if (cubit.providerCategoryModel==null && state is ProviderCategoryLoadingState)
                      DefaultListShimmer(),
                      if (cubit.providerCategoryModel?.data?.data?.length ==0  && state is ProviderCategorySuccessState)
                      Center(child: AutoSizeText(tr('no_restaurant'), minFontSize: 8,
                        maxLines: 1,)),
                      if (state is ProviderCategoryErrorState)
                      Center(child: AutoSizeText(tr('no_restaurant'), minFontSize: 8,
                        maxLines: 1,)),
                    if (cubit.providerCategoryModel?.data?.data?.isNotEmpty??true )
                      Column(
                        children: [
                          // if (state is ProviderCategoryLoadingState) Center(child: CupertinoActivityIndicator()),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (c, i) => ProviderItem(providerData: cubit.providerCategoryModel!.data!.data![i]),
                            separatorBuilder: (c, i) => const SizedBox(
                              height: 20,
                            ),
                            itemCount: cubit.providerCategoryModel?.data?.data?.length??0,

                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ],
                      )

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding homeAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    tr('search_for'),
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  AutoSizeText(
                    tr('fav_food'),
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(fontSize: 16,color: defaultColor),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  navigateTo(context, SearchScreen());
                },
                child: Container(
                  height: 53,
                  width: 53,
                  decoration: BoxDecoration(color: defaultColor, borderRadius: BorderRadiusDirectional.circular(10)),
                  alignment: AlignmentDirectional.center,
                  child: Image.asset(
                    Images.search,
                    width: 26,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: (){
                HomeCategoryCubit.get(context).getCurrentLocation();
                navigateTo(context, MapScreen());
              },
              child: Row(
                children: [
                  Image.asset(Images.location,width: 20,),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Text(
                      HomeCategoryCubit.get(context).locationController.text.isNotEmpty
                          ?HomeCategoryCubit.get(context).locationController.text
                          :tr('choose_your_location'),
                      maxLines: 2,
                      style: TextStyle(height: 1),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

