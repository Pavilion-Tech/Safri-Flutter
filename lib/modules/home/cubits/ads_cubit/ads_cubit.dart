import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:safri/models/ads_model.dart';
import 'package:safri/shared/network/remote/end_point.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/remote/dio.dart';
import '../../../../widgets/home/ad_dialog.dart';
import 'ads_states.dart';

class AdsCubit extends Cubit<AdsStates>{
  AdsCubit(): super(AdsInitState());
  static AdsCubit get (context)=>BlocProvider.of(context);





  AdsModel? adsModel;

  bool showAd = true;


  void getAds(BuildContext context){
    emit(GetAdsLoadingState());
    DioHelper.getData(
        url: adsUrl,
    ).then((value) {
      if(value.data['data']!=null){
        adsModel = AdsModel.fromJson(value.data);
        emit(GetAdsSuccessState());
        if(showAd)
        if(adsModel?.data?.popUpAdvertisements?.isNotEmpty??false){
          showAd=false;
          Future.delayed(Duration(seconds: 3),(){
            showDialog(context: context, builder: (context)=>AdDialog(
                adsModel!.data!.popUpAdvertisements![Random.secure().nextInt(adsModel!.data!.popUpAdvertisements!.length)]
            ));
          });
        }
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetAdsWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(GetAdsErrorState());
    });
  }


}