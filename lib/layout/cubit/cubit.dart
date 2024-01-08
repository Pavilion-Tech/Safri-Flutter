import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/main.dart';
import 'package:safri/models/ads_model.dart';
import 'package:safri/models/cart_model.dart';
import 'package:safri/models/coupon_model.dart';
import 'package:safri/models/provider_category_model.dart';
import 'package:safri/modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'package:safri/shared/network/remote/end_point.dart';
import '../../models/check_order_status_model.dart';
import '../../models/category_model.dart';
import '../../models/create_order_model.dart';
import '../../models/order_model.dart';
import '../../models/provider_products_model.dart';
import '../../models/single_provider_model.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/menu/menu_screen.dart';
import '../../modules/restaurant/restaurant_screen.dart';
import '../../modules/worng_screenss/update_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/network/remote/dio.dart';
import '../../widgets/cart/checkout/checkout_done.dart';
import '../../widgets/cart/checkout/web_view_screen.dart';
import '../../widgets/cart/delete_cart.dart';
import '../../widgets/product/item_added_dialog.dart';
import '../../widgets/restaurant/notify_dialog.dart';
import '../layout_screen.dart';

class FastCubit extends Cubit<FastStates>{
  FastCubit(): super(FastInitState());
  static FastCubit get (context)=>BlocProvider.of(context);

  List<Widget> screens =
  [
    HomeScreen(),
    CartScreen(),
    MenuScreen(),
  ];
  int currentIndex = 0;









  List<ProviderProductsModel> productsModel = [];

  String providerProductId = '';

  String providerId = '';

  ProviderBranchesModel? providerBranchesModel;

  CartModel? cartModel;

  CouponModel? couponModel;
  CheckOrderStatusModel? checkOrderStatusModel;
  CreateOrderModel? createOrderModel;




  ScrollController providerBranchesScrollController = ScrollController();
  ScrollController cartScrollController = ScrollController();



  SingleProviderModel? singleProviderModel;

  List<ProviderProductsModel>? providerProductsModels;




  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

  void emitState()=>emit(EmitState());

  void checkUpdate(context) async{
    // final newVersion =await NewVersionPlus().getVersionStatus();
    // if(newVersion !=null){
    //   if(newVersion.canUpdate)navigateAndFinish(context, UpdateScreen(
    //       url:newVersion.appStoreLink,
    //       releaseNote:newVersion.releaseNotes??tr('update_desc')
    //   ));
    // }
  }
  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }



  void init()async{


    if(token!=null)getAllCarts();
  }





  Future<Response?> getAllProducts(){
    emit(ProviderProductsLoadingState());
   return DioHelper.postData(
      url: '$providerProductsUrl$providerId',
      data: {
        'category_id': providerProductId
      }
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        productsModel.add(ProviderProductsModel.fromJson(value.data));
        emit(ProviderProductsSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        // showToast(msg: tr('wrong'));
        emit(ProviderProductsWrongState());
      }
    }).catchError((e){
      print(e.toString());
       showToast(msg: tr('server_error'),toastState: false);
      emit(ProviderProductsErrorState());
    });
  }

  void rateRestaurant({
    required String providerId,
    required int rateNum,
    required String rateContent,
  }){
    emit(RateLoadingState());
    DioHelper.postData(
        url: rateProviderUrl,
        token: 'Bearer $token',
        data: {
          'provider_id':providerId,
          'review_rate':rateNum,
          'review_content':rateContent,
        }
    ).then((value) {
      print(value.data);
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        emit(RateSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(RateWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(RateErrorState());
    });
  }

  String providerBranchesId = '';
  void getAllProductsBranches({int page = 1}){
    String url='';
    if(HomeCategoryCubit.get(navigatorKey.currentContext).position!=null){
      url = '$providerBranchesUrl$providerBranchesId?page=$page&user_latitude=${HomeCategoryCubit.get(navigatorKey.currentContext).position!.latitude}&user_logitude=${HomeCategoryCubit.get(navigatorKey.currentContext).position!.longitude}';
    }else{
      url = '$providerBranchesUrl$providerBranchesId?page=$page';
    }
    emit(ProviderBranchesLoadingState());
    DioHelper.getData(
      url: url,
      token: 'Bearer $token',
    ).then((value) {
      print(value.data);
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          providerBranchesModel = ProviderBranchesModel.fromJson(value.data);
        }
        else{
          providerBranchesModel!.data!.currentPage = value.data['data']['currentPage'];
          providerBranchesModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            providerBranchesModel!.data!.data!.add(ProviderData.fromJson(e));
          });
        }
        emit(ProviderBranchesSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(ProviderBranchesWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('server_error'),toastState: false);
      emit(ProviderBranchesErrorState());
    });
  }

  void paginationProviderBranches(){
    providerBranchesScrollController.addListener(() {
      if (providerBranchesScrollController.offset == providerBranchesScrollController.position.maxScrollExtent){
        if (providerBranchesModel!.data!.currentPage != providerBranchesModel!.data!.pages) {
          if(state is! ProviderBranchesLoadingState){
            int currentPage = providerBranchesModel!.data!.currentPage! +1;
            getAllProductsBranches(page: currentPage);
          }
        }
      }
    });
  }
  List<String> extraId = [];
  String typeId = '';
  String productId="";
  String quantity="";
  String   selectedSizeId="";
  void addToCart({
  required String productId,
  required BuildContext context,
  required String  selectedSizeId,
  required String  typeId,
  required String  quantity,
  required List<String>  extras,
}){
    this.extraId= extras;
    this.typeId= typeId;
    this.productId= productId;
    this.quantity= quantity;
    this.selectedSizeId= selectedSizeId;
    print("quantity");
    print(this.quantity);
    print(productId);
    print(this.productId);
    print(extras);
    print(extraId);
    FormData formData  = FormData.fromMap({
      'quantity':quantity,
      'product_id':productId,
      'mobile_MAC_address':fcmToken,
      'selected_size':selectedSizeId,
      'types[0]':typeId,
    });
    if(extras.isNotEmpty){
      for(int i = 0 ; i< extras.length; i++){
        formData.fields.add(MapEntry('extras[$i]', extras[i]));
      }
    }
    emit(AddToCartLoadingState());
    DioHelper.postData2(
      url: addToCartUrl,
      token:'Bearer $token',
      formData: formData
    ).then((value) async {
      print("add to cart");
      print(value.data);
      if(value.data['status']==true){

         // showToast(msg: value.data['message']);
         showDialog(
             context: context,
             builder: (context)=>ItemAddedDialog()
         );

         emit(AddToCartSuccessState());


         getAllCarts();

      }
      else if(value.data['status']==false&&value.data['data']!=null){
        if(value.data['data']['is_different_store'] == true){
          // showToast(msg: value.data['message']);
          showDialog(
              context: context,
              builder: (context)=>DeleteCartDialog(quantity: quantity,productId: providerId,extraId: extraId,typeId: typeId,)
          );
          emit(AddToCartWrongState());
        }
      }else{
        // showToast(msg: tr('wrong'),toastState: true);
        emit(AddToCartWrongState());
      }
    }).catchError((e){
      print("error is ${e}");
      showToast(msg: tr('server_error'),toastState: false);
      emit(AddToCartErrorState());
    });
  }
  String cartId =  '';
  void updateCart({
    required String productId,
    required int quantity,
  }){
    this.cartId = productId;
    emit(AddToCartLoadingState());
    DioHelper.putData(
        url: updateCartUrl,
        token:'Bearer $token',
        data: {
          'cart_item_id':productId,
          'quantity':quantity,
        }
    ).then((value) {
      if(value.data['status']==true){
        this.cartId = '';
        showToast(msg: value.data['message']);
        getAllCarts();
      }else{
        this.cartId = '';
        showToast(msg: tr('wrong'),toastState: true);
        emit(AddToCartWrongState());
      }
    }).catchError((e){
      this.cartId = '';
      showToast(msg: tr('wrong'),toastState: false);
      emit(AddToCartErrorState());
    });
  }

  void getAllCarts({int page = 1}){
    emit(GetCartLoadingState());
    DioHelper.getData(
      url: '$cartUrl$fcmToken',
      token: 'Bearer $token',

      //   query: {
      //
      //   'mobile_MAC_address':fcmToken,
      // }

    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        // if(page == 1) {
          cartModel = CartModel.fromJson(value.data);
        // }
        // else{
        //   cartModel!.data!.currentPage = value.data['data']['currentPage'];
        //   cartModel!.data!.pages = value.data['data']['pages'];
        //   value.data['data']['data'].forEach((e){
        //     cartModel!.data!.data!.cart!.add(Cart.fromJson(e));
        //   });
        // }
        emit(GetCartSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        // showToast(msg: tr('wrong'));
        emit(GetCartWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('server_error'),toastState: false);
      emit(GetCartErrorState());
    });
  }

  void paginationCarts(){
    cartScrollController.addListener(() {
      if (cartScrollController.offset == cartScrollController.position.maxScrollExtent){
        // if (cartModel!.data!.currentPage != cartModel!.data!.pages) {
        //   if(state is! GetCartLoadingState){
        //     int currentPage = cartModel!.data!.currentPage! +1;
        //     getAllCarts(page: currentPage);
        //   }
        // }
      }
    });
  }

  void deleteCart({required String cartId}){
    this.cartId = cartId;
    emit(AddToCartLoadingState());
    DioHelper.deleteData(
        url: '$deleteCartUrl$cartId',
        token:'Bearer $token',
    ).then((value) {
      if(value.data['status']==true){
        this.cartId = '';
        showToast(msg: value.data['message']);
        getAllCarts();
      }else{
        this.cartId = '';
        showToast(msg: tr('wrong'),toastState: true);
        emit(AddToCartWrongState());
      }
    }).catchError((e){
      this.cartId = '';
      showToast(msg: tr('server_error'),toastState: false);
      emit(AddToCartErrorState());
    });
  }

  void createOrder({
  required String date,
  String? additionalNotes,
  required String paymentMethod,
  required int serviceType,
  String? noOfPeople,
  String? noOfTable,
  // String? colorOfCar,
  // String? noOfCar,
  String? couponCode,
    // int? foodType,
}){
     print("aslasklkdlkdkldalda");
     print("date $date");
     print("additionalNotes $additionalNotes");
     print("paymentMethod $paymentMethod");
     print("serviceType $serviceType");
     print("noOfPeople $noOfPeople");
     print("noOfTable $noOfTable");
     print("couponCode $couponCode");
     print("long ${CacheHelper.getData(key: "long",)}");
     print("lat ${CacheHelper.getData(key: "lat",)}");
    FormData formData = FormData.fromMap({
      'ordered_date':date,
      if(additionalNotes!=null)'additional_notes':additionalNotes,
      if(couponCode!=null)'coupoun_code':couponCode,
      if(noOfPeople!=null)'no_of_people':noOfPeople,
      if(noOfTable!=null)'no_of_table':noOfTable,
      // if(colorOfCar!=null)'color_of_car':colorOfCar,
      // if(noOfCar!=null)'number_of_car':noOfCar,
      'payment_method':paymentMethod,
      'service_type':serviceType,
      if(CacheHelper.getData(key: "long",  ) !=null) 'user_longitude': CacheHelper.getData(key: "long",  ),
      if(CacheHelper.getData(key: "lat",  ) !=null) 'user_latitude': CacheHelper.getData(key: "lat",  ),
      // 'dinner_type':foodType,
    });
    for(int i = 0 ; i < cartModel!.data!.cart!.length; i++){
      print("cartModel?.data?.data?.cart?[i].productId");
      print(cartModel?.data?.cart?[i].productId);
      print(cartModel?.data?.cart?[i].productSelectedSizeId);
      // print(cartModel?.data?.data?.cart?[i].types?[0].selectedType??"");

      formData.fields.add(
          MapEntry('products[$i][product_id]', cartModel?.data?.cart?[i].productId??''),
      );
      formData.fields.add(
          MapEntry('products[$i][quantity]', '${cartModel?.data?.cart?[i].quantity??''}'),
      );
      formData.fields.add(
          MapEntry('products[$i][selected_size_id]', '${cartModel?.data?.cart?[i].productSelectedSizeId??''}'),
      );
      if(cartModel?.data?.cart?[i].types?.isNotEmpty??true){
        formData.fields.add(
          MapEntry('products[$i][types][0]', '${cartModel?.data?.cart?[i].types?[0].selectedType??''}'),
        );
      }

      for(int i2 = 0 ; i2 < cartModel!.data!.cart![i].extras!.length; i2++){
        formData.fields.add(
          MapEntry('products[$i][extras][$i2]' , '${cartModel?.data?.cart?[i].extras?[i2].selectedExtra??''}'),
        );
      }
    }
    emit(CreateOrderLoadingState());
    DioHelper.postData2(
        url: createOrderUrl,
        token:'Bearer $token',
        formData: formData
    ).then((value) {
      print("value.data");
      print(value.data);
      if(value.data['status']==true){
        createOrderModel=CreateOrderModel.fromJson(value.data);
        showToast(msg: value.data['message']);
        couponModel = null;


        emit(CreateOrderSuccessState());
        getAllCarts();
        if(paymentMethod=="online"){
          // showDialog(context: navigatorKey.currentContext!, barrierDismissible: false, builder: (context) => CheckoutDone(
          //     value.data['data']["payment_data"]["data"]??"",true));
          print("order id is ");
          print(value.data['data']["order"]["id"]);
          navigateTo(navigatorKey.currentContext, WebViewCustomScreen(url: value.data['data']["payment_data"]["data"],
          orderId: value.data['data']["order"]["id"],data:  createOrderModel!.data!.order!));
        }else{
          showDialog(context: navigatorKey.currentContext!, barrierDismissible: false, builder: (context) =>
              CheckoutDone("",false,data:  createOrderModel!.data!.order!));
        }

        print("value.data['data'][" "][" "]");
        // print(value.data['data']["payment_data"]["data"]);
      }else{
        showToast(msg: value.data['message'],toastState: true);
        emit(CreateOrderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(CreateOrderErrorState());
    });
  }

  void notifyMe({
  required String id, BuildContext? context,
  required int notificationStatus,
}){
    emit(NotifyMeLoadingState());
    DioHelper.putData(
      url: '$notifyMeUrl$id',
      token: 'Bearer $token',
      data: {
        'notification_status':notificationStatus
      }
    ).then((value) {
      print(value);
      if(value.data['data']!=null){
        showToast(msg: value.data['message']);
        if(context!=null){
          HomeCategoryCubit.get(context).getProviderCategory();
          showDialog(
              context: context,
              builder: (context)=>const NotifyDialog()
          );
          Future.delayed(Duration(seconds: 2),(){
            navigateAndFinish(context, FastLayout());
          });
        }
        emit(NotifyMeSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(NotifyMeWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(NotifyMeErrorState());
    });
  }

  void deleteAllCart( ){
    emit(DeleteAllCartLoadingState());
    DioHelper.deleteData(
      url: deleteAllCartUrl,
      token: 'Bearer $token',
        data: {

          'mobile_MAC_address':fcmToken,
        }
    ).then((value) {
      print(value.data);
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        emit(DeleteAllCartSuccessState());
          addToCart(
            context: navigatorKey.currentContext!,
            quantity: quantity.toString(),
            productId: productId??'',
            selectedSizeId: selectedSizeId ,
            extras: extraId ,
            typeId: typeId
        );
      }else{
        // showToast(msg: tr('wrong'),toastState: true);
        emit(DeleteAllCartWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(DeleteAllCartErrorState());
    });
  }

  void coupon(String code){
    emit(CouponLoadingState());
    DioHelper.postData(
        url: couponUrl,
        token: 'Bearer $token',
        lang: myLocale,
        data: {'code':code}
    ).then((value) {
      if(value.data['data']!=null){
        showToast(msg: value.data['message']);
        if(value.data['data']['is_applied']==true){
          couponModel = CouponModel.fromJson(value.data);
          emit(CouponSuccessState());
        }else{
          emit(CouponWrongState());
        }
      }else{
        // showToast(msg: tr('wrong'));
        emit(CouponWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(CouponErrorState());
    });
  }

  Future checkOrderStatusApi({required String chargeId,required String orderId, OrderData? data})async{
    emit(CheckOrderStatusLoadingState());
    DioHelper.postData(
        url: "$checkOrderStatus$orderId",
        token: 'Bearer $token',
        lang: myLocale,
        data: {'charge_id':chargeId}
    ).then((value) async {
      print("order status data");
      if(value.data['status']==true){
        showToast(msg: value.data['message']);

          checkOrderStatusModel = CheckOrderStatusModel.fromJson(value.data);
          emit(CheckOrderStatusSuccessState());
        await  Future.delayed(Duration(milliseconds: 300));
        if(checkOrderStatusModel?.data?.completeOrderStatus=="completed"){
          showDialog(context: navigatorKey.currentContext!, barrierDismissible: false, builder: (context) =>
              CheckoutDone("",false,data: data,));
        }

      }else{
        showToast(msg: value.data['message']);
        emit(CheckOrderStatusWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(CheckOrderStatusErrorState());
    });
  }


  void singleProvider(String id,BuildContext context){
    // showToast(msg: tr('please_wait'));
    emit(SingleProviderLoadingState());
    DioHelper.getData(
        url: '$singleProviderUrl$id',
        lang: myLocale,
      token:'Bearer ${token??""}'
    ).then((value) {
      print("value.data");
      print(value.data.toString());
      if(value.data['data']!=null){
        print("value.data11111111");
        print(value.data['data']['is_favorited']);
        singleProviderModel = SingleProviderModel.fromJson(value.data);

        productsModel.clear();

        providerId = singleProviderModel?.data?.id??'';
        print("aaaaaaaaaaaaa");
        if(singleProviderModel?.data?.childCategoriesModified?.isNotEmpty??true){
          singleProviderModel?.data?.childCategoriesModified?.forEach((element) {
            providerProductId = element.id??'';
            getAllProducts();
          });
        }

        print("providerProductId");

        providerBranchesModel=null;
        print(singleProviderModel?.data?.id??'');

        providerBranchesId = singleProviderModel?.data?.id??'';


        print("value.data33333333");
        // navigateTo(context, RestaurantScreen(singleProviderModel!.data!,isBranch: false,));
        emit(SingleProviderSuccessState());
        getAllProductsBranches();
        //getAllProducts();
      }else{
        // showToast(msg: tr('wrong'));
        emit(SingleProviderWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(SingleProviderErrorState());
    });
  }

  ///add or remove product
  void addRemoveProviderFromFavorite({
    required String favoritedProviderId, BuildContext? context,

  }){
    emit(AddOrRemoveProductFavoriteLoadingState());
    print("token");
    print(token);
    DioHelper.postData(
        url: '$addRemoveProviderFromFav',
        token: 'Bearer $token',
        data: {
          'favorited_provider':favoritedProviderId
        }
    ).then((value) {
      print(value);
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        if(context!=null){
          HomeCategoryCubit.get(context).getProviderCategory();

          Future.delayed(Duration(seconds: 2),(){
            navigateAndFinish(context, FastLayout());
          });
        }
        emit(AddOrRemoveProductFavoriteSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(AddOrRemoveProductFavoriteWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('server_error'),toastState: false);
      emit(AddOrRemoveProductFavoriteErrorState());
    });
  }
}