import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';

class BookingDate extends StatelessWidget {
  BookingDate(this.date);

  String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('booking_date'),
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10,),
        Container(
          height: 39,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(6.5),
            color: defaultColor
          ),
          padding: EdgeInsets.symmetric(horizontal: 10,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Mon',
                style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.w500),
              ),
              Text(
                '01',
                style: TextStyle(color: Colors.white,fontSize: 19.5,fontWeight: FontWeight.w500,height: 1),
              ),
            ],
          ),
        )
      ],
    );
  }
}
