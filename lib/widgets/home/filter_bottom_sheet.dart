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
  int currentService = 0;

  int currentStatus = 0;

  List<String> titles = [
    'all_service',
    'pick_up_service',
    'dine_in_service',
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              tr('service'),style:const TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 32,
            child: ListView.separated(
                itemBuilder: (c,i)=>itemBuilder(
                  text: titles[i],
                  isSelected: currentService == i ,
                  index: i
                ),
                shrinkWrap: true,
                separatorBuilder: (c,i)=>const SizedBox(width: 10,),
                scrollDirection: Axis.horizontal,
                itemCount: 3
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 10),
            child: Text(
              tr('status'),style:const TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              itemBuilder(text: 'open',isSelected: currentStatus == 0,index: 0,isService: false),
              const SizedBox(width: 10,),
              itemBuilder(text: 'not_crowded',isSelected: currentStatus == 1,index: 1,isService: false),
            ],
          ),
          const SizedBox(height: 30,),
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
   bool isService = true,
}){
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: (){
        setState(() {
          isService? currentService = index:currentStatus = index;
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
