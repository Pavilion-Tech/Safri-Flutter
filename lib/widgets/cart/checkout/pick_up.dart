import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/images/images.dart';

class PickUp extends StatefulWidget {
  PickUp({Key? key}) : super(key: key);
  int currentIndex = 0;

  @override
  State<PickUp> createState() => _PickUpState();
}

class _PickUpState extends State<PickUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          itemBuilder(
              image: Images.dineIn1,
              title: 'driver_thur',
              index: 0
          ),
          itemBuilder(
              image: Images.pickUp,
              title: 'by_person',
              index: 1
          )
        ],
      ),
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
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              children: [
                Image.asset(image,width: 78,),
                Text(
                  tr(title),
                  style:const TextStyle(fontSize: 16),
                ),
              ],
            ),
            if(widget.currentIndex != index)
              Container(color: Colors.grey.shade100.withOpacity(.6),height: 120,width: 120,)
          ],
        ),
      ),
    );
  }
}


