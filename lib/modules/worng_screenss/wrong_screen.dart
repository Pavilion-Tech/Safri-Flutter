import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

class WrongScreen extends StatelessWidget {

  WrongScreen({
    required this.image,
    required this.title,
    required this.desc,
    this.textButton,
    this.onTap
});

  String image;
  String title;
  String desc;
  String? textButton;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Images.bubbles),
        SizedBox(height: size!.height*.15,),
        Image.asset(image,height: 156,width: 156,),
        AutoSizeText(
          tr(title),
          minFontSize: 8,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 26),
        ),
        AutoSizeText(
          tr(desc),
          minFontSize: 8,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
        ),
        const SizedBox(height: 20,),
        if(onTap!=null)
        DefaultButton(
            text:tr(textButton!),
            onTap: onTap!
        )
      ],
    );
  }
}
