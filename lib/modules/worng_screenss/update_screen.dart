import 'package:flutter/material.dart';
import 'package:safri/modules/worng_screenss/wrong_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({
    required this.releaseNote,
    required this.url,
  });
  String url;
  String releaseNote;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrongScreen(
        image: Images.update,
        title: 'update_title',
        desc: releaseNote,
        textButton: 'update_now',
        onTap: (){
          openUrl(url);
        },
      ),
    );
  }
}
