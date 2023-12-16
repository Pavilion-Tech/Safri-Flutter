import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/modules/worng_screenss/wrong_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';

class NoNetScreen extends StatelessWidget {
  const NoNetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrongScreen(
        image: Images.noNet,
        title: 'no_net_title',
        desc: 'no_net_desc',
        textButton: 'reload',
        onTap: (){
          FastCubit.get(context).init();
          MenuCubit.get(context).init();
          navigateAndFinish(context, FastLayout());
        },
      ),
    );
  }
}
