import 'package:flutter/material.dart';

import '../../shared/images/images.dart';
import '../../shared/styles/colors.dart';

class FilterWidget extends StatelessWidget {
  FilterWidget(this.onTap);

  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        height: 38,width: 38,
        padding: EdgeInsetsDirectional.all(8),
        decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadiusDirectional.circular(10.55)
        ),
        child: Image.asset(Images.filter),
      ),
    );
  }
}
