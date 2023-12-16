import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safri/modules/worng_screenss/no_net_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';


Future<XFile?> checkImageSize (XFile? image)async{
  if(image!=null) {
    final bytes = (await image.readAsBytes()).lengthInBytes;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    if(mb<5.0){
      return image;
    }else {
      showToast(msg: tr('image_size'));
      return null;
    }
  }
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => widget,
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.fastOutSlowIn;

          final tween = Tween(begin: begin, end: end);
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        }
    ),
        (route) => false,
  );
}




Future showToast ({required String msg , bool? toastState,ToastGravity gravity = ToastGravity.BOTTOM})
{
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 5,
    textColor: Colors.white,
    fontSize: 16.0,
    backgroundColor: toastState != null
        ? toastState ?Colors.yellow[900]
        : Colors.red : Colors.green,
  );
}

Future<void> openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


checkNet(context) {
  if (!isConnect!) {
    navigateTo(context,const NoNetScreen(),);
  }
}

