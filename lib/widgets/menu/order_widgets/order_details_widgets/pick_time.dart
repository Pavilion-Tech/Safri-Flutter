import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/images/images.dart';

class PickUpTime extends StatelessWidget {
  PickUpTime(this.time);

  String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          tr('pick_up_time'),
          minFontSize: 8,
          maxLines: 1,
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            Image.asset(Images.calendar,width: 28,),
            const SizedBox(width: 10,),
            AutoSizeText(
              '${tr('pick_up_time')}  $time',
              minFontSize: 6,
              maxLines: 1,
              style:const TextStyle(fontSize: 10,fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
