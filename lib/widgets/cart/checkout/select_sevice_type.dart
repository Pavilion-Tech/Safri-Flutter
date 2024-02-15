import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../../shared/images/images.dart';

class SelectServiceType extends StatefulWidget {
  SelectServiceType({Key? key}) : super(key: key);

  int currentIndex = 1;


  @override
  State<SelectServiceType> createState() => _SelectServiceTypeState();
}

class _SelectServiceTypeState extends State<SelectServiceType> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsetsDirectional.only(top: 0.0,bottom: 10,start: 20),
          child: Text(
            tr('select_service'),
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Row(
          children: [
            itemBuilder(
              image: Images.delivery,
              title: 'Delivery',
              index: 1
            ),
            itemBuilder(
                image: Images.pickup,
                title: 'pick_up',
                index: 2
            ),
            itemBuilder(
                image: Images.dineIn,
                title: 'dine_in',
                index: 3
            ),
          ],
        ),
      ],
    );
  }

  Widget itemBuilder({
  required String image,
  required String title,
  required int index,
}){
    return Expanded(
      child: InkWell(
        onTap: (){
          setState(() {
            widget.currentIndex = index;
          });
          FastCubit.get(context).emitState();
        },
        child: Column(
          children: [
            Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffB3B3B3).withOpacity(0.3)
                ),child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(image,width: 60,color: widget.currentIndex == index?defaultColor: Color(0xffB3B3B3),),
                )),
            Text(
              tr(title),
              style:  TextStyle(fontSize: 16,
              color: widget.currentIndex == index?Color(0xff4B4B4B): Color(0xffB3B3B3)),
            ),
          ],
        ),
      ),
    );
  }
}
