import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safri/shared/styles/colors.dart';

import '../images/images.dart';


class UTI{
  UTI._();
  static Widget backIcon()=>const Icon(Icons.arrow_back_ios);
  static void showProgressIndicator(BuildContext context, ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              height: 100,
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  )
              ),
              child:    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Text( tr("please_wait"),style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),),
                  ),
                  const SizedBox(width: 15,),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircularProgressIndicator(
                      color: defaultColor,

                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Widget cachedImage(String? url, {double? height, double? width, double? radius,
    BoxFit? fit}) {
    if (url == null) {
      return ClipRRect(borderRadius: BorderRadius.circular(radius ?? 0),
          child: UTI.noImage(height: height, width: width));
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: CachedNetworkImage(
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(Images.holder,fit:fit,width: width,height: height,),
                    CupertinoActivityIndicator()
                  ],
                ),
              ),
        // placeholder: (_, __) => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        errorWidget: (_, __, ___) => UTI.noImage(),
        imageUrl: url ?? '',
        height: height,
        width: width,
        fit:fit?? BoxFit.cover,
      ),
    );
  }
  static Widget noImage({double? width, double? height}) =>
      Image.asset(Images.holder, width: width, height: height);



  static showSnackBar(context, message, status) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: status == 'error' ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  static Future showToast ({required String msg , bool? toastState,ToastGravity gravity = ToastGravity.BOTTOM})
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

  static Widget dataEmptyWidget({required String noData, required String imageName,double? width,double? height}) => Center(

    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 35,),
          Center(child: SvgPicture.asset(imageName, fit: BoxFit.cover,width: width,height: height,)),
          const SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              noData,
              style: const TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(height: 10,),
        ],
      ),
    ),
  );


  static List<String> imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp',
    'tiff',
    'svg',
    'webp',
    'ico',
    'raw',
    'psd',
  ];
  static List<String> docExtensions = [
    'pdf',
    'doc',
    'docx'
  ];
}