import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:safri/models/notification_model.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/network/local/cache_helper.dart';
import 'package:safri/splash_screen.dart';

import '../../../models/contact_us_model.dart';
import '../../../models/order_model.dart';
import '../../../models/settings_model.dart';
import '../../../models/static_pages_model.dart';
import '../../../models/user_model.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/network/remote/dio.dart';
import '../../../shared/network/remote/end_point.dart';

class MenuCubit extends Cubit<MenuStates>{

  MenuCubit():super(MenuInitState());
  static MenuCubit get(context)=>BlocProvider.of(context);

  UserModel? userModel;

  SettingsModel? settingsModel;

  OrderModel? orderModel;

  ContactUsModel? contactUsModel;

  StaticPagesModel? staticPagesModel;

  NotificationModel? notificationModel;

  ScrollController orderScrollController = ScrollController();

  ScrollController notificationScrollController = ScrollController();

  ScrollController contactusScrollController = ScrollController();

  ImagePicker picker = ImagePicker();

  XFile? profileImage;

  void emitState()=>emit(EmitState());

  Future<XFile?> pick(ImageSource source) async {
    try {
      return await picker.pickImage(source: source, imageQuality: 20);
    } catch (e) {
      print(e.toString());
      emit(ImageWrongState());
    }
    return null;
  }

  void checkInterNet() async {
    InternetConnectionChecker().onStatusChange.listen((event) {
      final state = event == InternetConnectionStatus.connected;
      isConnect = state;
      emit(EmitState());
    });
  }

  void init(){
    if(token!=null){
      getSettings();
      getStaticPages();
      getUser();
      getAllContactUs();
    }
  }

  void getStaticPages(){
    DioHelper.getData(
        url: staticPagesUrl,
        token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        staticPagesModel = StaticPagesModel.fromJson(value.data);
        emit(StaticPagesSuccessState());
      }else{
        emit(StaticPagesWrongState());
        showToast(msg: tr('wrong'),toastState: true);
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(StaticPagesErrorState());
    });
  }

  void getUser(){
    DioHelper.getData(
      url: userUrl,
      token: 'Bearer $token'
    ).then((value) {
      if(value.data['data']!=null){
        userModel = UserModel.fromJson(value.data);
        emit(UserSuccessState());
      }else{
        emit(UserWrongState());
        // showToast(msg: tr('wrong'),toastState: true);
      }
    }).catchError((e){
      // showToast(msg: tr('wrong'),toastState: false);
      emit(UserErrorState());
    });
  }

  void updateProfile({
    bool isPhoto = false,
    String? phone,
    String? name,
    String? email,
  }){
    emit(UpdateProfileLoadingState());
    DioHelper.putData(
        url: updateUserUrl,
        token: 'Bearer $token',
        formData: FormData.fromMap(!isPhoto?{
          'phone_number':phone,
          'name':name,
          'whatsapp_number':phone,
          'email':email,
          'firebase_token':fcmToken,
          'current_language':myLocale,
        }:{'personal_photo':MultipartFile.fromFileSync(profileImage!.path,filename: profileImage!.path.split('/').last)}),
    ).then((value) {
      print(value.data);
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        getUser();
        emit(UpdateProfileSuccessState());
      }else{
        // showToast(msg: tr('wrong'),toastState: true);
        emit(UpdateProfileWrongState());
      }
    }).catchError((e){
      // showToast(msg: tr('wrong'),toastState: false);
      print(e.toString());
      emit(UpdateProfileErrorState());
    });
  }

  void getSettings(){
    DioHelper.getData(
      url: settingsUrl,
    ).then((value) {
      if(value.data['status']==true){
        print("asasasasaassSettingsErrorState");
        print(value.data);
        settingsModel = SettingsModel.fromJson(value.data);
        print("settingsModel");
        print(settingsModel);
        emit(SettingsSuccessState());
      }else{
        // showToast(msg: tr('wrong'),toastState: true);
        emit(SettingsWrongState());
      }
    }).catchError((e){
      /// todo error here
      // showToast(msg: tr('wrong'),toastState: false);
      emit(SettingsErrorState());
    });
  }

  void getAllOrders({int page = 1,int? status,String searchText = ''}){
    emit(OrderLoadingState());
    DioHelper.getData(
      url: '$orderUrl${status??''}&page=$page&search_text=$searchText',
      token: 'Bearer $token',
    ).then((value) {
      print(value.data);
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          orderModel = OrderModel.fromJson(value.data);
        }
        else{
          orderModel!.data!.currentPage = value.data['data']['currentPage'];
          orderModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            orderModel!.data!.data!.add(OrderData.fromJson(e));
          });
        }
        emit(OrderSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        // showToast(msg: tr('wrong'));
        emit(OrderWrongState());
      }
    }).catchError((e){
      print(e.toString());
      // showToast(msg: tr('wrong'));
      emit(OrderErrorState());
    });
  }

  void paginationOrders({int?status,String searchText = ''}){
    orderScrollController.addListener(() {
      if (orderScrollController.offset == orderScrollController.position.maxScrollExtent){
        if (orderModel!.data!.currentPage != orderModel!.data!.pages) {
          if(state is! OrderLoadingState){
            int currentPage = orderModel!.data!.currentPage! +1;
            getAllOrders(page: currentPage,status: status,searchText: searchText);
          }
        }
      }
    });
  }


  void contactUs({
  required String subject,
  required String message,
  }){
    emit(ContactUsLoadingState());
    DioHelper.postData(
        url: contactUsUrl,
        token: 'Bearer $token',
        data: {
          'message':message,
          'subject':subject,
        }
    ).then((value) {
      print(value.data);
      if(value.data['status']==true){
        showToast(msg: value.data['message']);
        getAllContactUs();
        emit(ContactUsSuccessState());
      }else{
        showToast(msg: tr('wrong'),toastState: true);
        emit(ContactUsWrongState());
      }
    }).catchError((e){
      showToast(msg: tr('wrong'),toastState: false);
      emit(ContactUsErrorState());
    });
  }

  void getAllContactUs({int page = 1}){
    emit(GetContactUsLoadingState());
    DioHelper.getData(
      url: '$getContactUsUrl$page',
      token: 'Bearer $token',
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          contactUsModel = ContactUsModel.fromJson(value.data);
        }
        else{
          contactUsModel!.data!.currentPage = value.data['data']['currentPage'];
          contactUsModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            contactUsModel!.data!.data!.add(ContactUsData.fromJson(e));
          });
        }
        emit(GetContactUsSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(GetContactUsWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(GetContactUsErrorState());
    });
  }

  void paginationContactUs(){
    contactusScrollController.addListener(() {
      if (contactusScrollController.offset == contactusScrollController.position.maxScrollExtent){
        if (contactUsModel!.data!.currentPage != contactUsModel!.data!.pages) {
          if(state is! GetContactUsLoadingState){
            int currentPage = contactUsModel!.data!.currentPage! +1;
            getAllContactUs(page: currentPage);
          }
        }
      }
    });
  }

  void getAllNotification({int page = 1}){
    emit(NotificationLoadingState());
    DioHelper.getData(
      url: '$notificationUrl$page',
      token: 'Bearer $token',
    ).then((value) {
      if(value.data['status']==true&&value.data['data']!=null){
        if(page == 1) {
          notificationModel = NotificationModel.fromJson(value.data);
        }
        else{
          notificationModel!.data!.currentPage = value.data['data']['currentPage'];
          notificationModel!.data!.pages = value.data['data']['pages'];
          value.data['data']['data'].forEach((e){
            notificationModel!.data!.data!.add(NotificationData.fromJson(e));
          });
        }
        emit(NotificationSuccessState());
      }else if(value.data['status']==false&&value.data['data']!=null){
        showToast(msg: tr('wrong'));
        emit(NotificationWrongState());
      }
    }).catchError((e){
      print(e.toString());
      showToast(msg: tr('wrong'));
      emit(NotificationErrorState());
    });
  }

  void paginationNotification(){
    notificationScrollController.addListener(() {
      if (notificationScrollController.offset == notificationScrollController.position.maxScrollExtent){
        if (notificationModel!.data!.currentPage != notificationModel!.data!.pages) {
          if(state is! NotificationLoadingState){
            int currentPage = notificationModel!.data!.currentPage! +1;
            getAllNotification(page: currentPage);
          }
        }
      }
    });
  }
  
  void log(BuildContext context,{bool isDelete = false}){
    if(isDelete)DioHelper.getData(url: '$deleteUserUrl$id');
    token = null;
    id = null;
    CacheHelper.removeData('id');
    CacheHelper.removeData('token');
    CacheHelper.removeData('lat');
    CacheHelper.removeData('long');
    navigateAndFinish(context, SplashScreen());
  }



}