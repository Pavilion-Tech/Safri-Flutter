import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

class FilterBottomSheet extends StatefulWidget {
  FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {

  int currentStatus = 0;

  List<String> titles = [
    'opened',
    'not_crowded',
    'nearest',
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Text(
              tr('filters'),style:const TextStyle(fontSize: 16),
            ),
          ),
          ListView.separated(
              itemBuilder: (c,i)=>itemBuilder(
                text: titles[i],
                isSelected: currentStatus == i ,
                index: i
              ),
              shrinkWrap: true,
              separatorBuilder: (c,i)=>const SizedBox(height: 20,),
              itemCount: 3
          ),
          const SizedBox(height: 15,),
          DefaultButton(
            text: tr('apply'),
            onTap: (){
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Widget itemBuilder({
  required String text,
  required bool isSelected,
  required int index,
}){
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: (){
        setState(() {
          currentStatus = index;
        });
      },
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          border: Border.all(color:  isSelected?defaultColor:Colors.grey)
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(isSelected)
            Icon(Icons.check,color: defaultColor,),
            if(isSelected)
            const SizedBox(width: 10,),
            Text(
              tr(text),
              style: TextStyle(color: isSelected?defaultColor:Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
