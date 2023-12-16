import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/network/local/cache_helper.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/item_shared/default_button.dart';
import '../auth/login_screen.dart';

class IntroModel{
  String image;
  String title;
  String desc;
  IntroModel({
    required this.title,
    required this.image,
    required this.desc,
});
}

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  PageController pageController = PageController();
  List<IntroModel> intro = [
    IntroModel(
      image: Images.intro1,
      title: tr('Good_Food'),
      desc:tr('You can choose the restaurant you want to order food from, and you can order food for delivery, eat it in the restaurant, or take it away') ,
    ),
    IntroModel(
      image: Images.intro2,
      title: tr('Easy Payment'),
      desc:tr('You can pay in cash or pay through the payment methods available within the application') ,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            TextButton(
                onPressed: (){
                  isIntro = true;
                  CacheHelper.saveData(key: 'intro', value: isIntro);
                  navigateAndFinish(context, FastLayout());
                },
                child: AutoSizeText(tr('Skip'), minFontSize: 8,
                  maxLines: 1,style: TextStyle(color: defaultColor),)
            )
          ],
        ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height:size!.height*.52,
              child: PageView.builder(
                  controller: pageController,
                  itemCount:intro.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (c,i){
                    return IntroItem(model: intro[i]);
                  }
              ),
            ),
            SmoothPageIndicator(
                controller: pageController, // PageController
                count: 2,
                effect: ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotWidth: 7,
                    dotHeight: 7,
                    spacing: 5,
                    dotColor: Colors.grey.shade300
                ), // your preferred effect
                onDotClicked: (index) {}
            ),
            const SizedBox(height: 30,),
            DefaultButton(
              text: tr('Next'),
              onTap: (){
                if(pageController.page != 1.0){
                  pageController.animateTo(
                      pageController.position.maxScrollExtent,
                      duration:const Duration(milliseconds: 500),
                      curve: Curves.easeInOutSine
                  );
                }else{
                  isIntro = true;
                  CacheHelper.saveData(key: 'intro', value: isIntro);
                  navigateAndFinish(context, FastLayout());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  IntroItem({required this.model});

  IntroModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          model.image,
          height: size!.height*.3,
          width: size!.width*.7,
        ),
        SizedBox(height: size!.height*.04,),
        AutoSizeText(
          model.title,
          minFontSize: 8,
          maxLines: 1,
          style:TextStyle(color:defaultColor,fontWeight:FontWeight.w600,fontSize:35),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AutoSizeText(
            model.desc,
            minFontSize: 8,
            maxLines: 1,
            textAlign: TextAlign.center,
            style:const TextStyle(fontWeight:FontWeight.w400,fontSize:13),
          ),
        ),
      ],
    );
  }
}

