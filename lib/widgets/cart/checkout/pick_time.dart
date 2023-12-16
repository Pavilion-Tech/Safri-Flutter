import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../shared/images/images.dart';
import '../../item_shared/default_button.dart';

class PickTime extends StatefulWidget {
  PickTime({Key? key}) : super(key: key);

  DateTime dateTime = DateTime.now();

  @override
  State<PickTime> createState() => _PickTimeState();
}

class _PickTimeState extends State<PickTime> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsetsDirectional.only(top: 30.0,bottom: 10,start: 20),
          child: AutoSizeText(
            tr('pick_up_time'),
            minFontSize: 8,
            maxLines: 1,
            style:const TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              itemBuilder(
                  title: 'immediately',
                  index: 0
              ),
              const SizedBox(width: 40,),
              itemBuilder(
                  title: 'waiting',
                  index: 1
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget itemBuilder({
    required String title,
    required int index,
  }){
    return Expanded(
      child: DefaultButton(
        text: tr(title),
        color:currentIndex == index?null:Colors.grey,
        onTap: (){
          setState(() {
            currentIndex = index;
          });
          if(currentIndex == 1){
            showCupertinoModalPopup(
                context: context,
                builder:(context)=> Container(
                  height: 190,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    minimumDate:DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,DateTime.now().hour -1) ,
                    onDateTimeChanged: (date){
                      setState(() {
                        widget.dateTime = date;
                      });
                      FastCubit.get(context).emitState();
                    },
                  ),
                )
            );
          }
          FastCubit.get(context).emitState();
        },
      ),
    );
  }
}
