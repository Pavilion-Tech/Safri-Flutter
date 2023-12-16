import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';

import 'package:share_plus/share_plus.dart';

import '../../../models/provider_category_model.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/firebase_helper/firebase_dynamic_link.dart';
import '../../../widgets/restaurant/map_widget.dart';
import '../../../widgets/restaurant/notify_dialog.dart';

class Info extends StatefulWidget {
  Info(this.providerData, {this.isShowReviews = false});

  final ProviderData providerData;
  final bool isShowReviews;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool isNotified = false;
  bool showProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("widget.providerData.isFavoriteddddd");
    print(widget.providerData.isFavorited);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
      listener: (context, state) {
        if (state is AddOrRemoveProductFavoriteSuccessState) {
          setState(() {
            widget.providerData.isFavorited = !widget.providerData.isFavorited!;
          });
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0, right: 20, left: 20, bottom: 5),
                child: AutoSizeText(
                  tr('location'),
                  minFontSize: 8,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: 260,
                child: MapWidget(
                  image: widget.providerData.personalPhoto ?? '',
                  latLng: LatLng(
                    double.parse(widget.providerData.currentLatitude ?? '25.2048'),
                    double.parse(widget.providerData.currentLongitude ?? '55.2708'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (state is AddOrRemoveProductFavoriteLoadingState)
                              Center(
                                child: CupertinoActivityIndicator(),
                              )
                            else
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        print("widget.providerData.isFavorited");
                                        print(widget.providerData.isFavorited);
                                        print(widget.providerData.id);
                                        FastCubit.get(context).addRemoveProviderFromFavorite(favoritedProviderId: widget.providerData.id.toString());
                                      },
                                      child: SvgPicture.asset(
                                        Images.fav,
                                        color: widget.providerData.isFavorited == true ? defaultColor : Colors.grey,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  AutoSizeText(
                                    tr("AddedToFavourites"),
                                    minFontSize: 8,
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            if (showProgress == true)
                              Center(
                                child: CupertinoActivityIndicator(),
                              )
                            else
                            Column(
                              children: [



                                GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        showProgress = true;
                                      });
                                      var firebaseDynamicLinkService =
                                          await FirebaseDynamicLinkService.createDynamicLinkProvider(ProviderData: widget.providerData);

                                      await Share.share(
                                        '${widget.providerData.name ?? ""} \n $firebaseDynamicLinkService',
                                      );
                                      setState(() {
                                        showProgress = false;
                                      });

                                    },
                                    child: SvgPicture.asset(
                                      Images.share,
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  tr("Share_Restaurant"),
                                  minFontSize: 8,
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AutoSizeText(
                          tr('working_time'),
                          minFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff4B4B4B)),
                        ),
                        Row(
                          children: [
                            if (widget.providerData.workingDays?.isNotEmpty ?? true)
                              Expanded(
                                child: AutoSizeText(
                                  widget.providerData.workingDays?.join(', ') ?? "",
                                  minFontSize: 8,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff2C2C2C)),
                                ),
                              )
                            else
                              Expanded(
                                child: AutoSizeText(
                                  tr("everyDay"),
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff2C2C2C)),
                                ),
                              ),
                            SizedBox(
                              width: 5,
                            ),
                            // const Spacer(),
                            Row(
                              children: [
                                AutoSizeText(
                                  '${convertTo12HourFormat(widget.providerData.openingTime.toString())}',
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                                ),
                                AutoSizeText(
                                  ' - ${convertTo12HourFormat(widget.providerData.closingTime.toString())} ',
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (token != null)
                      // if(widget.providerData.crowdedStatus ==1&&widget.providerData.openStatus != 'open')
                      if (widget.providerData.openStatus != 'open')
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              tr('notify_me'),
                              minFontSize: 8,
                              maxLines: 1,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  tr('when_open'),
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                                ),
                                const Spacer(),
                                ConditionalBuilder(
                                  condition: state is! NotifyMeLoadingState,
                                  fallback: (c) => CupertinoActivityIndicator(),
                                  builder: (c) => InkWell(
                                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                                      onTap: () {
                                        if (!widget.providerData.notifyMe!) {
                                          FastCubit.get(context).notifyMe(id: widget.providerData.id ?? '', context: context, notificationStatus: 1);
                                        } else {
                                          FastCubit.get(context).notifyMe(id: widget.providerData.id ?? '', notificationStatus: 2);
                                        }
                                        setState(() {
                                          widget.providerData.notifyMe = !widget.providerData.notifyMe!;
                                        });
                                      },
                                      child: AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 500),
                                          transitionBuilder: (Widget child, Animation<double> animation) {
                                            return ScaleTransition(scale: animation, child: child);
                                          },
                                          child: Image.asset(
                                            widget.providerData.notifyMe! ? Images.notifyYes : Images.notifyNo,
                                            width: 33.5,
                                            key: ValueKey(widget.providerData.notifyMe!),
                                          ))),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Image.asset(Images.pickUp,width: 79,),
              //           Text(
              //             tr('pick_up')
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Column(
              //         children: [
              //           Image.asset(Images.dineIn2,width: 79,),
              //           Text(
              //             tr('dine_in')
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }

  String convertTo12HourFormat(String time) {
    int hour = int.parse(time);
    String period = (hour >= 12) ? tr('PM') : tr('AM');
    hour = hour % 12;
    if (hour == 0) {
      hour = 12;
    }
    return '$hour $period';
  }
}
