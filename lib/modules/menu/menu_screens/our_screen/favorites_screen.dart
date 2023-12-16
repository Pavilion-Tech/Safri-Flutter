import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:safri/modules/menu/cubit/fav_provider_cubit/fav_provider_state.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';

import '../../../../layout/cubit/states.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constant.dart';
import '../../../../shared/components/uti.dart';
import '../../../../shared/images/images.dart';
import '../../../../widgets/item_shared/image_net.dart';
import '../../../../widgets/item_shared/provider_item.dart';
import '../../../../widgets/shimmer/notification_shimmer.dart';
import '../../../restaurant/restaurant_screen.dart';
import '../../cubit/fav_provider_cubit/fav_provider_cubit.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  ScrollController gridController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavoriteProvidersCubit.get(context).getFavoriteProviders();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('Favorites')),
          SizedBox(height: 20,),


          Expanded(
            child: BlocConsumer<FavoriteProvidersCubit, FavoriteProvidersState>(
              listener: (context, state) {

              },
              builder: (context, state) {
                var cubit = FavoriteProvidersCubit.get(context);
                if (cubit.providerFavData.isEmpty && state is FavoriteProvidersLoadState) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: NotificationShimmer(),
                  );

                }
                if (cubit.providerFavData.isEmpty && state is FavoriteProvidersSuccessState) {
                  return UTI.dataEmptyWidget(noData:  tr("noDataFounded"), imageName: Images.productNotFound);
                }
                if (state is FavoriteProvidersErrorState) {
                  return UTI.dataEmptyWidget(noData: tr("noDataFounded"), imageName: Images.productNotFound);
                }
                return  SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (c,i) {
                          var data=cubit.providerFavData[i];

                          return InkWell(
                            onTap: (){
                              try{
                                FastCubit.get(context).productsModel = null;
                                FastCubit.get(context).providerId = data.id??'';
                                FastCubit.get(context).providerProductId = data.childCategoriesModified!.isNotEmpty?data.childCategoriesModified![0].id??"":'';
                                FastCubit.get(context).providerBranchesModel=null;
                                FastCubit.get(context).providerBranchesId = data.id??'';
                                // FastCubit.get(context).getAllProductsBranches();
                                if(FastCubit.get(context).providerProductId.isNotEmpty){
                                  FastCubit.get(context).getAllProducts();
                                }
                                print("data.id.toString()");
                                print(data.id.toString());
                                navigateTo(context, RestaurantScreen(id: data.id.toString(), ));
                              }catch(e){
                                print(e.toString());
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              // height:100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(20),
                                  border: Border.all(color: Colors.grey)
                              ),
                              padding: const EdgeInsets.only(right: 5,left: 5,bottom: 5,top: 5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 75,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional.circular(15),
                                    ),
                                    child: ImageNet(image:data.personalPhoto??'',fit: BoxFit.cover,),
                                  ),
                                  const SizedBox(width: 5,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AutoSizeText(
                                                data.name??'',
                                                minFontSize: 8,

                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),

                                            SizedBox(width: size!.width*.01,),
                                            CircleAvatar(
                                              backgroundColor:data.openStatus == 'open'? Color(0xff57E500):Color(0xffE51C00),
                                              radius: 5,
                                            ),
                                            const SizedBox(width: 5,),
                                            AutoSizeText(
                                              tr(data.openStatus??'open'),
                                              style: TextStyle(fontSize: 10,color: data.openStatus == 'open'? Color(0xff57E500):Color(0xffE51C00)),
                                            ),
                                            SizedBox(width: size!.width*.02,),
                                          ],
                                        ),
                                        SizedBox(height: 20,),
                                        // Text(
                                        //   'Pickup & Dine In Service',
                                        //   style: TextStyle(fontSize: 11),
                                        // ),
                                        // const Spacer(),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset(Images.star,width: 13,height: 14,),
                                            const SizedBox(width: 5,),
                                            AutoSizeText(
                                              '${data.totalRate??0} (${data.totalRateCount})',
                                              maxLines: 1,
                                              minFontSize: 5,
                                              style: TextStyle(fontSize: 10,color: Colors.grey),
                                            ),
                                            SizedBox(width: size!.width*.01,),
                                            if(data.distance!=null)
                                              Image.asset(Images.location,width: 14,height: 14,),
                                            if(data.distance!=null)
                                              const SizedBox(width: 5,),
                                            if(data.distance !=null)
                                              AutoSizeText(
                                                data.distance??"",
                                                maxLines: 1,
                                                minFontSize: 5,
                                                style: TextStyle(fontSize: 10,color: Colors.grey),
                                              ),
                                            if(data.duration!=null)
                                              SizedBox(width: size!.width*.01,),
                                            if(data.duration!=null)
                                              Image.asset(Images.timer,width: 14,height: 14,),
                                            const SizedBox(width: 5,),
                                            Row(
                                              children: [
                                                AutoSizeText(
                                                  '${data.duration??''} | ',
                                                  maxLines: 1,
                                                  minFontSize: 5,
                                                  style: TextStyle(fontSize: 10,color: Colors.grey),
                                                ), AutoSizeText(
                                                  data.crowdedStatus ==1 ?tr('crowded'):tr('not_crowded'),
                                                  maxLines: 1,
                                                  minFontSize: 5,
                                                  style: TextStyle(fontSize: 10,color:Color(0xff4B4B4B)),
                                                ),
                                              ],
                                            ),
                                            // SizedBox(width: size!.width*.02,),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                        itemCount: cubit.providerFavData.length,
                        controller: gridController,

                        padding:const EdgeInsets.symmetric(horizontal: 20),
                      ),

                    ],
                  ),
                );
              },

            ),
          ),
        ],
      ),
    );
  }
}
