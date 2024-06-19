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

  void init(context)async{
    // lat = CacheHelper.getData(key: 'lat');
    // lng = CacheHelper.getData(key: 'lng');
    currentIndex = 0;
    if(categoriesModel?.data?.isEmpty??true) getCategory();
    if(position==null) getCurrentLocation(isHome: false);
    // if(lat!=null&&lng!=null){
    //   HomeCategoryCubit.get(context).position=LatLng(lat!,lng!);
    //
    // }else{
    //
    // }
  }
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
        // CacheHelper.saveData(key: 'lat', value: value.latitude);
        // CacheHelper.saveData(key: 'lng', value: value.longitude);
        Future.delayed(Duration(seconds: 2),(){
          getAddress(position!);
          allProviderModel = null;
          providerCategoryModel = null;
          allProviderScrollController.removeListener(() { });
          getAllProvider();
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
      if(permission == LocationPermission.denied)
      if(!isHome) openAppSettings();
      if (permission == LocationPermission.denied) {
        showToast(msg: 'Location permissions are denied', toastState: false);
        if(permission == LocationPermission.denied)
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
        //categorySearchId = categoriesModel!.data![0].id??'';
        print("categoryId");
        print(categoryId);

        emit(HomeCategorySuccessState());
        if(isSearch==false) {
          if(currentIndex == 0){
            getAllProvider();
          }
        }else getProviderCategorySearch(search: "");

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
    //url = '$providerCategoryUrl$categoryId?user_latitude=25.2083126&user_logitude=55.8919013&page=$page';

    if(position!=null){
      url = '$providerCategoryUrl$categoryId?user_latitude=${position!.latitude}&user_logitude=${position!.longitude}&page=$page';
    }else{
      url = '$providerCategoryUrl$categoryId?page=$page';
    }
    print(url);
    emit(ProviderCategoryLoadingState());
    DioHelper.getData(
        url: url,
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          providerCategoryModel = ProviderCategoryModel.fromJson(value.data);
        }
        else{
          providerCategoryModel!.data!.currentPage = value.data['data']['currentPage'];
          providerCategoryModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            providerCategoryModel!.data!.data!.add(ProviderData.fromJson(e));
          });
        }
        emit(ProviderCategorySuccessState());
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
    emit(ProviderCategorySearchLoadingState());
    DioHelper.getData(
        url: 'provider/all-providers',
        query: {
          'limit':20,
          'name':search,
          'page':page,
          'category_id':categorySearchId,
        },
        token: 'Bearer $token'
    ).then((value) {
      print(value.headers);
      print(value.realUri);
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

  AllProvidersModel? allProviderModel;

  ScrollController allProviderScrollController = ScrollController();


  void getAllProvider(){
    String url;
    //url = '$allProviderUrl&current_latitude=29.3117&current_longitude=47.4818';

    if(position!=null){
      url = '$allProviderUrl&current_latitude=${position!.latitude}&current_longitude=${position!.longitude}';
    }else{
      url = '$allProviderUrl';
    }
    print(url);
    emit(ProviderCategoryLoadingState());
    DioHelper.getData(
        url: url,
        token: 'Bearer $token'
    ).then((value) {
      print(value.data);
      if(value.data['status']==true&&value.data['data']!=null){
        allProviderModel = AllProvidersModel.fromJson(value.data);
        emit(ProviderCategorySuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(ProviderCategoryWrongState());
      }else{
        showToast(msg: value.data['message']??'wrong'.tr(),toastState: false);
        emit(ProviderCategoryWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('server_error'),toastState: false);
      emit(ProviderCategoryErrorState());
    });
  }

  // void paginationAllProvider(){
  //   print("allliiiiii");
  //   allProviderScrollController.addListener(() {
  //     if (allProviderScrollController.offset == allProviderScrollController.position.maxScrollExtent){
  //       if (allProviderModel!.data!.currentPage != allProviderModel!.data!.pages) {
  //         if(state is! ProviderCategoryLoadingState){
  //           int currentPage = allProviderModel!.data!.currentPage! +1;
  //           getAllProvider(page: currentPage);
  //         }
  //       }
  //     }
  //   });
  // }

  void emitState()=>emit(EmitState());
}