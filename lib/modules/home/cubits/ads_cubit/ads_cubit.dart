import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/models/ads_model.dart';
import 'package:safri/shared/network/remote/end_point.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/network/remote/dio.dart';
import 'ads_states.dart';

class AdsCubit extends Cubit<AdsStates>{
  AdsCubit(): super(AdsInitState());
  static AdsCubit get (context)=>BlocProvider.of(context);





  AdsModel? adsModel;


  void getAds(){
    emit(GetAdsLoadingState());
    DioHelper.getData(
        url: adsUrl,
    ).then((value) {
      if(value.data['data']!=null){
        adsModel = AdsModel.fromJson(value.data);
        emit(GetAdsSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(GetAdsWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(GetAdsErrorState());
    });
  }


}