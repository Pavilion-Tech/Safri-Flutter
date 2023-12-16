import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/layout_screen.dart';
import '../../../models/order_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/uti.dart';
import 'checkout_done.dart';


class WebViewCustomScreen extends StatefulWidget {
  final String? url;
  final String orderId;
  final AppBar? appBar;
  final OrderData? data;

  const WebViewCustomScreen(
      {Key? key,
     required this.orderId,
      required this.url,
      this.appBar,
      this.data})
      : super(key: key);

  @override
  _WebViewCustomScreenState createState() => _WebViewCustomScreenState();
}

class _WebViewCustomScreenState extends State<WebViewCustomScreen> {
  bool isLoading = false;
  bool isCheckStatus = true;
  String html = '';
  String url = '';
  late WebViewController _webViewController;

  @override
  void initState() {
    // #docregion platform_features
    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();
    final WebViewController webViewController =
        WebViewController.fromPlatformCreationParams(params);

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            isLoading=progress!=100;
            print("progress");
            print(progress);
            setState(() {

            });
            webViewController.runJavaScriptReturningResult(
                "javascript:(function() { "
                "var head = document.getElementsByTagName('header')[0];"
                "head.parentNode.removeChild(head);"
                "var sale = document.getElementsByClassName('hot-sale-bar')[0];"
                "sale.parentNode.removeChild(sale);"
                "var footer = document.getElementsByClassName('footer-bottom dark_style')[0];"
                "footer.parentNode.removeChild(footer);"
                "})()"
            );
          },

          onPageStarted: (String url) {
            print("onPageStarted");
            print(url);
          },

          onUrlChange: (UrlChange change) {

             debugPrint('url change to ${change.url}');
             Uri uri = Uri.parse(change.url!);
             String? tapId = uri.queryParameters['tap_id'];
             print("tapId is ");
             print(tapId);

             if(tapId !=null&&isCheckStatus==true){

               FastCubit.get(context).checkOrderStatusApi(chargeId: tapId, orderId: widget.orderId,data: widget.data);
               isCheckStatus=false;
               return;
             }

          },
          onPageFinished: (String url) {


          },

          onWebResourceError: (WebResourceError error) {
            print("onWebResourceError");
          },
          onNavigationRequest: (NavigationRequest request) {
            print("NavigationRequest");
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url ?? ''));
    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _webViewController = webViewController;
    super.initState();
  }

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
                    child: Text(tr("please_wait"),style: const TextStyle(
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit,FastStates>(
      listener: (context, state) {
         if(state is CheckOrderStatusLoadingState){
           showProgressIndicator(context);
         }
         if(state is CheckOrderStatusSuccessState){
             Navigator.pop(context);
         }
         if(state is CheckOrderStatusErrorState){
            Navigator.pop(context);
         }
         if(state is CheckOrderStatusWrongState){
            Navigator.pop(context);
         }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: widget.appBar ??
              AppBar(
                backgroundColor: defaultColor,
                elevation: 0.0,
                title: Image.asset(
                  Images.appIcon,
                  height: 40,
                ),
                centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white),
                leading: Builder(builder: (buildContext) {
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () async {

                          FastCubit.get(context).changeIndex(0);
                          navigateAndFinish(context,FastLayout());

                        },
                      ),

                    ],
                  );
                }),
              ),
          body: WillPopScope(
            onWillPop: ()async{
              FastCubit.get(context).changeIndex(0);
              navigateAndFinish(context,FastLayout());
              return true;
            },
            child: Builder(builder: (BuildContext context) {
              if(isLoading) return Center(child: CircularProgressIndicator(color: defaultColor),);
              return  WebViewWidget(
                controller: _webViewController,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{}..add(
                    Factory<TapGestureRecognizer>(
                            () => TapGestureRecognizer()..onTapDown = (tap) {})),
              );
            }),
          ),
        );
      },


    );
  }
}
