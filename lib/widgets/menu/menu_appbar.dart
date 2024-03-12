import 'package:flutter/material.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../shared/components/constant.dart';
import '../item_shared/image_net.dart';
import 'choose_proifle_photo.dart';

class MenuAppBar extends StatelessWidget {
  const MenuAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 132,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(30),
                  bottomStart: Radius.circular(30),
              ),
              color: defaultColor
            ),
          //  child: Image.asset(Images.bubbles,height: 132,width: double.infinity,),
          ),
          if(token!=null)
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Stack(
              children: [
                Container(
                  height: 133,width: 133,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ImageNet(image: MenuCubit.get(context).userModel?.data?.personalPhoto??'',),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context)=>ChooseProfilePhotoType()
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,shape: BoxShape.circle
                      ),
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.edit,color: defaultColor,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
