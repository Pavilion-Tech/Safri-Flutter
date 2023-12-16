import 'package:flutter/material.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/styles/colors.dart';

class DefaultButton extends StatelessWidget {

  DefaultButton({
    required this.text,
    required this.onTap,
    this.textColor = Colors.white,
    this.height = 45,
    this.radius = 5,
    this.width,
    this.color
    
});

  VoidCallback onTap;
  String text;
  Color textColor;
  double height;
  double radius;
  double? width;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width??size!.width*.8,
        decoration: BoxDecoration(
          color:color??defaultColor,
          borderRadius: BorderRadiusDirectional.circular(radius),
          border: Border.all(color: defaultColor)
        ),
        alignment: AlignmentDirectional.center,
        child: Text(
            text,
          style: TextStyle(
            color: textColor,fontSize: 15,fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
