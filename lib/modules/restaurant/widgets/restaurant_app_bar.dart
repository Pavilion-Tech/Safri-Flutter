import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safri/widgets/restaurant/all_reviews_dialog.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/images/images.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/item_shared/image_net.dart';
import '../../../widgets/restaurant/branche_bottom_sheet.dart';
import '../../home/cubits/home_category_cubit/home_category_cubit.dart';
import '../../home/cubits/home_category_cubit/home_category_states.dart';

class RestaurantAppBar extends StatelessWidget {
  final  FastCubit cubit;
  const RestaurantAppBar({
    super.key,
    required TabController tabController, required this.cubit,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    context.locale;
    return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var categoryCubit = HomeCategoryCubit.get(context);
    return Container(

      height:categoryCubit.currentIndex!=0?120: size!.height * .3 + 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          // Positioned(
          //   top: 0,
          //   bottom: 90, // to shift little up
          //   left: 0,
          //   right: 0,
          //   child: ,
          // ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: AnimatedContainer(
              height: categoryCubit.currentIndex!=0?0:300,
              duration: Duration(milliseconds: 500),
              curve: Curves.bounceInOut,
              width: double.infinity,
              decoration:const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ImageNet(image:cubit.singleProviderModel?.data?.personalPhoto??'',fit: BoxFit.cover,),
            ),
          ),
          if(categoryCubit.currentIndex==0)
            Padding(
            padding: EdgeInsets.only(
            top: categoryCubit.currentIndex!=0?120:0,
                bottom: 15,right: 20,left: 20),
            child: Container(
              width: double.infinity,
              height: 210,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.circular(20),
                  border: Border.all(color: Colors.grey)
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle
                        ),
                        child: ImageNet(image:cubit.singleProviderModel?.data?.personalPhoto??'',fit: BoxFit.cover,),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                   cubit.singleProviderModel?.data?.name??'',
                                    minFontSize: 8,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Color(0xff000000)),
                                  ),
                                ),
                                // if(!widget.isBranch)
                                  if(FastCubit.get(context).providerBranchesModel!=null)
                                    if(FastCubit.get(context).providerBranchesModel?.data?.data?.isNotEmpty??true)
                                      InkWell(
                                        onTap: (){
                                          showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:const BorderRadiusDirectional.only(
                                                  topEnd: Radius.circular(20),
                                                  topStart: Radius.circular(20),
                                                ),
                                                side: BorderSide(width: 3,color: Colors.grey.shade200),
                                              ),
                                              builder: (context)=>BrancheBottomSheet()
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10,),
                                            AutoSizeText(
                                              tr('change_branch'),
                                              minFontSize: 8,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: defaultColor,
                                                  decoration: TextDecoration.underline,
                                                  fontSize: 9.4,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                const SizedBox(width: 10,)
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AutoSizeText(
                                    cubit.singleProviderModel?.data?.categories?.first.title??'',
                                    minFontSize: 8,
                                    maxLines: 1,

                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff6E6E6E)),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Image.asset(Images.star,height:18,),
                                GestureDetector(
                                  onTap: () {
                                    if(cubit.singleProviderModel?.data?.reviews?.isNotEmpty??true){
                                      showDialog(context: context, builder: (context) => AllReviewsDialog(reviews: cubit.singleProviderModel?.data?.reviews??[]));
                                    }

                                  },
                                  child: AutoSizeText(
                                    ' ${cubit.singleProviderModel?.data?.totalRate??''} (${cubit.singleProviderModel?.data?.totalRateCount??''} ${tr("Rates")})',
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 11,fontWeight: FontWeight.w500,color: Color(0xff4B4B4B)),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    height: 1,width: double.infinity,
                    color: Color(0xff6E6E6E),
                  ),
                  if(categoryCubit.currentIndex==0)
                    SizedBox(height: 5,),
                  if(categoryCubit.currentIndex==0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              AutoSizeText(tr("Delivery_By"), minFontSize: 6,
                                maxLines: 1,style: TextStyle(color: Color(0xff4B4B4B),
                                  fontWeight: FontWeight.w400,fontSize: 9),),
                              if(cubit.singleProviderModel?.data?.deliveryBy =="safri")
                              Image.asset(Images.appIcon,height: 30,width: 40,),
                              if(cubit.singleProviderModel?.data?.deliveryBy =="external")
                                SvgPicture.asset(Images.cartIsEmpty,height: 30,width: 40,),
                              if(cubit.singleProviderModel?.data?.deliveryBy =="by_restaurant")
                                Container(
                                  height: 30,
                                  width: 40,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle
                                  ),
                                  child: ImageNet(image:cubit.singleProviderModel?.data?.personalPhoto??'',fit: BoxFit.cover,),
                                ),
                            ],
                          ),

                          Column(
                            children: [
                              AutoSizeText(tr("Delivery_Time"),
                                minFontSize: 6,
                                maxLines: 1,style: TextStyle(color: Color(0xff4B4B4B),
                                  fontWeight: FontWeight.w400,fontSize: 9),),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  AutoSizeText(cubit.singleProviderModel?.data?.deliveryTime??'', minFontSize: 6,
                                    maxLines: 1,style: TextStyle(color: Color(0xff2C2C2C),
                                      fontWeight: FontWeight.w700,fontSize: 11),),
                                  SizedBox(width: 2,),
                                  AutoSizeText(tr("min"),
                                    minFontSize: 6,
                                    maxLines: 1,style: TextStyle(color: Color(0xff2C2C2C),
                                        fontWeight: FontWeight.w700,fontSize: 11),),
                                ],
                              ),

                              SizedBox(height: 5,)
                            ],
                          ),
                          Column(
                            children: [
                              AutoSizeText(tr("Delivery_Fees"),
                                minFontSize: 6,
                                maxLines: 1,style: TextStyle(color: Color(0xff4B4B4B),
                                  fontWeight: FontWeight.w400,fontSize: 9),),
                              SizedBox(height: 2,),
                              AutoSizeText(
                                "${cubit.singleProviderModel?.data?.deliveryFees??''} ${tr("KWD")}",
                                minFontSize: 8,
                                maxLines: 1,style: TextStyle(color: Color(0xff2C2C2C),
                                  fontWeight: FontWeight.w700,fontSize: 11),),
                              SizedBox(height: 5,)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    child: TabBar(
                      padding: EdgeInsets.zero,
                      labelColor: Color(0xff2C2C2C),
                      indicatorColor: defaultColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorPadding: EdgeInsets.zero,
                      labelStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(
                          text: tr('menu'),
                        ),
                        Tab(
                          text: tr('info'),
                        )
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                    ),
                  ),
                  // const Spacer(),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Image.asset(Images.star,width: 15,),
                  //     const SizedBox(width: 5,),
                  //     Text(
                  //       '${cubit.singleProviderModel?.data?.totalRate??''} (${cubit.singleProviderModel?.data?.totalRateCount})',
                  //       style: TextStyle(fontSize: 10,color: Colors.grey),
                  //     ),
                  //     SizedBox(width: size!.width*.01,),
                  //     if(cubit.singleProviderModel?.data?.distance!=null)
                  //       Image.asset(Images.location,width: 15,),
                  //     if(cubit.singleProviderModel?.data?.distance!=null)
                  //       const SizedBox(width: 5,),
                  //     if(cubit.singleProviderModel?.data?.distance!=null)
                  //       Text(
                  //         cubit.singleProviderModel?.data?.distance??"",
                  //         style: TextStyle(fontSize: 10,color: Colors.grey),
                  //       ),
                  //     if(cubit.singleProviderModel?.data?.duration!=null)
                  //       SizedBox(width: size!.width*.01,),
                  //     if(cubit.singleProviderModel?.data?.duration!=null)
                  //       Image.asset(Images.timer,width: 15,),
                  //     const SizedBox(width: 5,),
                  //     Text.rich(
                  //         TextSpan(
                  //             text:'${cubit.singleProviderModel?.data?.duration??''} | ',
                  //             style: TextStyle(fontSize: 10,color: Colors.grey),
                  //             children: [
                  //               TextSpan(
                  //                   text: cubit.singleProviderModel?.data?.crowdedStatus ==1 ?tr('crowded'):tr('not_crowded'),
                  //                   style: TextStyle(fontSize: 10)
                  //               )
                  //             ]
                  //         )
                  //     ),
                  //     SizedBox(width: size!.width*.01,),
                  //     CircleAvatar(
                  //       backgroundColor:cubit.singleProviderModel?.data?.openStatus == 'open'? Colors.green:Colors.red,
                  //       radius: 5,
                  //     ),
                  //     const SizedBox(width: 5,),
                  //     Text(
                  //       tr(cubit.singleProviderModel?.data?.openStatus??'open'),
                  //       style: TextStyle(fontSize: 10,color: Colors.green),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
          Positioned.directional(
            top: 0,
            start: -10,
            textDirection:myLocale=="en"? TextDirection.ltr:TextDirection.rtl,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: ()=>Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_outlined,color:defaultColor,),
                    ),
                  ),
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
}