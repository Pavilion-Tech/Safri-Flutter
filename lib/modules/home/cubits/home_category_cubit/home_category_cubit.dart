import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safri/models/ads_model.dart';
import 'package:safri/shared/network/local/cache_helper.dart';
import 'package:safri/shared/network/remote/end_point.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../models/category_model.dart';
import '../../../../models/provider_category_model.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constant.dart';
import '../../../../shared/network/remote/dio.dart';
import 'home_category_states.dart';

class HomeCategoryCubit extends Cubit<HomeCategoryStates>{
  HomeCategoryCubit(): super(HomeCategoryInitState());
  static HomeCategoryCubit get (context)=>BlocProvider.of(context);

  int currentIndex = 0;
  LatLng? position;
  CategoriesModel? categoriesModel;
  String categoryId = '';
  TextEditingController locationController = TextEditingController();

  // void init()async{
  //   if(lat!=null){
  //     position = LatLng(lat!, lng!);
  //     getAddress(position!);
  //   }else{
  //     getCurrentLocation();
  //   }
  //
  //
  // }
  final ItemScrollController itemScrollController = ItemScrollController();
  /// auto scroll down
  // Future _scrollToIndex() async {
  //
  //   itemScrollController.scrollTo(
  //       index: 30,
  //       duration: const Duration(seconds: 2),
  //       curve: Curves.easeInOutCubic);
  //
  //   // emit(AutoScrollDownState());
  // }


  Future<void> getCurrentLocation({bool isHome = true}) async {
    //emit(GetCurrentLocationLoadingState());
    await checkPermissions(isHome: isHome);
    await Geolocator.getLastKnownPosition().then((value) {
      if (value != null) {
        print("valuevalue");
        print(value);
        position = LatLng(value.latitude, value.longitude);
        CacheHelper.saveData(key: 'lat', value: value.latitude);
        CacheHelper.saveData(key: 'lng', value: value.longitude);
        print(position);
        Future.delayed(Duration(milliseconds: 2500),(){
          getAddress(position!);
          getProviderCategory();

        });

        //emit(GetCurrentLocationState());
      }
    });
  }
  Future<Position> checkPermissions({bool isHome = true}) async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(!isHome) openAppSettings();
      if (permission == LocationPermission.denied) {
        showToast(msg: 'Location permissions are denied', toastState: false);
        if(!isHome) openAppSettings();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showToast(msg: 'Location permissions are permanently denied, we cannot request permissions , go to setting', toastState: false);
      //await Geolocator.openLocationSettings();
     // emit(GetCurrentLocationState());
      if(!isHome) openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }



  Future<void> getAddress(LatLng latLng) async {
    List<Placemark> place = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: myLocale);
    Placemark placeMark = place[0];
    locationController.text = placeMark.street??'';
    locationController.text += ', ${placeMark.country??''}';
  }
  void getCategory({bool isSearch =false}){
    print("aaaaaaaaassss");
    emit(HomeCategoryLoadingState());
    DioHelper.getData(
      url: categoryUrl,
    ).then((value) {
      if(value.data['data']!=null){
        categoriesModel = CategoriesModel.fromJson(value.data);
        categoryId = categoriesModel!.data![0].id??'';
        categorySearchId = categoriesModel!.data![0].id??'';
        print("categoryId");
        print(categoryId);

        emit(HomeCategorySuccessState());
        if(isSearch==false) getProviderCategory();
        if(isSearch==true)getProviderCategorySearch(search: "");

      }else{
        emit(HomeCategoryWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(HomeCategoryErrorState());
    });
  }


  String categorySearchId = '';



  ProviderCategoryModel? providerCategoryModel;
  void getProviderCategory({int page = 1}){
    String url;
    if(position!=null){
      url = '$providerCategoryUrl$categoryId?user_latitude=${position!.latitude}&user_logitude=${position!.longitude}&page=$page';
    }else{
      url = '$providerCategoryUrl$categoryId?page=$page';
    }
    print("allliiiii000000");
    emit(ProviderCategoryLoadingState());
    DioHelper.getData(
        url: url,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          providerCategoryModel = ProviderCategoryModel.fromJson(value.data);

          print("providerCategoryModelproviderCategoryModel");
          print(providerCategoryModel?.data?.data?.length);
        }
        else{
          providerCategoryModel!.data!.currentPage = value.data['data']['currentPage'];
          providerCategoryModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            providerCategoryModel!.data!.data!.add(ProviderData.fromJson(e));
          });
        }
        emit(ProviderCategorySuccessState());
        // Timer(const Duration(milliseconds: 3), () {
        //   _scrollToIndex();
        //
        // });

      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(ProviderCategoryWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('server_error'),toastState: false);
      emit(ProviderCategoryErrorState());
    });
  }

  void paginationProviderCategory(ScrollController controller){
    print("allliiiiii");
    controller.addListener(() {
      if (controller.offset == controller.position.maxScrollExtent){
        if (providerCategoryModel!.data!.currentPage != providerCategoryModel!.data!.pages) {
          if(state is! ProviderCategoryLoadingState){
            int currentPage = providerCategoryModel!.data!.currentPage! +1;
            getProviderCategory(page: currentPage);
          }
        }
      }
    });
  }


  ProviderCategoryModel? providerCategorySearchModel;
  TextEditingController searchController = TextEditingController();
  void getProviderCategorySearch({int page = 1,required String search}){
    providerCategorySearchModel=null;
    String url;
    if(position!=null){
      url = '$providerCategoryUrl$categorySearchId?user_latitude=${position!.latitude}&user_logitude=${position!.longitude}&page=$page&name=$search';
    }else{
      url = '$providerCategoryUrl$categorySearchId?page=$page&name=$search';
    }
    print(url);
    emit(ProviderCategorySearchLoadingState());
    DioHelper.getData(
        url: url,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          providerCategorySearchModel = ProviderCategoryModel.fromJson(value.data);
        }
        else{
          providerCategorySearchModel!.data!.currentPage = value.data['data']['currentPage'];
          providerCategorySearchModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            providerCategorySearchModel!.data!.data!.add(ProviderData.fromJson(e));
          });
        }
        emit(ProviderCategorySearchSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        // showToast(msg: tr('wrong'));
        emit(ProviderCategorySearchWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('server_error'),toastState: false);
      emit(ProviderCategorySearchErrorState());
    });
  }

  ScrollController providerSearchScrollController = ScrollController();
  void paginationProviderCategorySearch(String search){
    providerSearchScrollController.addListener(() {
      if (providerSearchScrollController.offset == providerSearchScrollController.position.maxScrollExtent){
        if (providerCategorySearchModel!.data!.currentPage != providerCategorySearchModel!.data!.pages) {
          if(state is! ProviderCategorySearchLoadingState){
            int currentPage = providerCategorySearchModel!.data!.currentPage! +1;
            getProviderCategorySearch(page: currentPage,search: search);
          }
        }
      }
    });
  }

  void emitState()=>emit(EmitState());
}