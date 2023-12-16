import 'dart:async';

import 'package:flutter/material.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:video_player/video_player.dart';
import 'modules/intro/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // late VideoPlayerController _controller;

  @override
  void initState() {
    // _controller = VideoPlayerController.asset(Images.splash)
    //   ..initialize().then((_) {
    //     setState(() {
    //       if (_controller.value.isInitialized) {
    //         _controller.play();
    //       }
    //     });
    //   });
    // _controller.play();
    // _controller.addListener(() {
    //
    //   setState(() async {
    //     if (_controller.value.position >= _controller.value.duration){
    //     await  Future.delayed(Duration(seconds: 5));
    //       if(isIntro!=null){
    //         print("ramadan1");
    //         print(_controller.value.position);
    //         print(_controller.value.duration);
    //         navigateAndFinish(context, FastLayout());
    //       }else{
    //         navigateAndFinish(context, IntroScreen());
    //           }
    //     }
    //   });
    // });
     _goNext();
    super.initState();
  }

  Future<void> _goNext() async {
     await  Future.delayed(Duration(seconds: 3));
    if(isIntro!=null){
      print("ramadan1");
      // print(_controller.value.position);
      // print(_controller.value.duration);
      navigateAndFinish(context, FastLayout());
    }else{
      navigateAndFinish(context, IntroScreen());
    }
  }

  @override
  void dispose() {
    // _controller.dispose();
    // _controller.removeListener(() { });
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 180,
              width: 310,
              child:Image.asset(Images.appIcon, width: 180, height: 180),
            ),

            Text("SAFRI",style: TextStyle(color: defaultColor,fontWeight: FontWeight.w700,fontSize: 28),),
          ],
        ),
      ),
    );
  }
}
