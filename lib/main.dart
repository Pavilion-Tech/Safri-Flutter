import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/modules/auth/cubit/auth_cubit.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/shared/api/dio_helper.dart';
import 'package:safri/shared/bloc_observer.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/firebase_helper/messaging.dart';
import 'package:safri/shared/network/local/cache_helper.dart';
import 'package:safri/shared/network/remote/dio.dart';
import 'package:safri/splash_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';
import 'modules/addresses/cubit/address_cubit/address_cubit.dart';
import 'modules/chat/presentation/cubit/chat_msg_cubit/chat_msg_cubit.dart';
import 'modules/home/cubits/ads_cubit/ads_cubit.dart';
import 'modules/home/cubits/home_category_cubit/home_category_cubit.dart';
import 'modules/home/cubits/review_cubit/review_cubit.dart';
import 'modules/menu/cubit/fav_provider_cubit/fav_provider_cubit.dart';
import 'modules/product/cubit/product_cubit/product_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  try{
    await Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform
    );
    Messaging.initFCM();
    await FirebaseMessaging.instance.requestPermission();
     fcmToken = await  FirebaseMessaging.instance.getToken();
    print("fcmToken");
    print(fcmToken);
  }catch(e){
    print(e.toString());
  }
  DioHelper.init();
  DioHelper1.init();
  await CacheHelper.init();
  lat = CacheHelper.getData(key: 'lat');
  lng = CacheHelper.getData(key: 'lng');
  id = CacheHelper.getData(key: 'id');
   token = CacheHelper.getData(key: 'token');
    print("token");
    print(token);

  isIntro = CacheHelper.getData(key: 'intro');
  String? loca = CacheHelper.getData(key: 'locale') ;
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  version = packageInfo.version;
  if(loca !=null){
    myLocale = loca;
  }else{
    Platform.localeName.contains('ar')
        ?myLocale = 'ar'
        :myLocale = 'en';
  }

  BlocOverrides.runZoned(
        () {
      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          useOnlyLangCode: true,
          path: 'assets/langs',
          fallbackLocale: const Locale('en'),
          startLocale: Locale(myLocale),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color.fromRGBO(41, 167, 77, 50),
        //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
        providers:[
          BlocProvider(create:(context)=> HomeCategoryCubit() ),
          BlocProvider(create:(context)=> FastCubit()..checkInterNet()..init() ),
          BlocProvider(create:(context)=> MenuCubit()..checkInterNet()..init()),
          BlocProvider(create:(context)=> AuthCubit()..checkInterNet()),
          BlocProvider(create:(context)=> ChatMsgCubit() ),
          BlocProvider(create:(context)=> ProductCubit() ),
          BlocProvider(create:(context)=> ReviewCubit() ),
          BlocProvider(create:(context)=> AddressCubit() ),
          BlocProvider(create:(context)=> FavoriteProvidersCubit() ),
          BlocProvider(create:(context)=> AdsCubit() ),


        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            fontFamily: 'Cairo',
            appBarTheme: AppBarTheme(
                color: Colors.transparent,
                elevation: 0,iconTheme: IconThemeData(color: Colors.black)
            ),
            primarySwatch: Colors.blue,
          ),
          home:SplashScreen(),
        )
    );
  }
}

