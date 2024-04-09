import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../models/provider_products_model.dart';


class ExtraWidget extends StatefulWidget {

  ExtraWidget(this.extras);

  List<Extra> extras;
  List<String> extraId = [];

  @override
  State<ExtraWidget> createState() => _ExtraWidgetState();
}

class _ExtraWidgetState extends State<ExtraWidget> {
  List<int> indexes = [];


  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child:ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return listItem(model: widget.extras[index],index:index );
        }, separatorBuilder: (context, index) {
      return Container(
        height: 1,
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        color: Color(0xffBEBEBE),
      );
    }, itemCount: widget.extras.length)
    // Wrap(
    //   spacing: 15,
    //   runSpacing: 15,
    //   children: List.generate(widget.extras.length, (i) =>itemBuilder(widget.extras[i],i)),
    // ),
  );
  }
  Widget listItem({required Extra model,required int index} ) {
    return  model.name!= ''? GestureDetector(
      onTap: (){
        if(model.isMulti != 'multi'){
          widget.extraId.clear();
          indexes.clear();
        }
        setState(() {
          if(indexes.any((element) => index == element)){
            indexes.remove(index);
            widget.extraId.remove(model.id);
          }else{
            indexes.add(index);
            widget.extraId.add(model.id??'');
          }
        });

      },
      child: Container(
        padding:   EdgeInsets.symmetric(
            horizontal: 0,vertical: 4
        ),

        child: Row(
          children: [
            Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    color:indexes.any((element) => index == element) ? defaultColor:  Color(0xffCACACA),

                    shape: BoxShape.circle),

              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                model.name??'',
                style: const TextStyle(
                    color:  Color(0xff6E6E6E),
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
            Text(
              '${model.price??''}',
              style: const TextStyle(
                  color:  Color(0xff6E6E6E),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              tr("KWD"),
              style: const TextStyle(
                  color:  Color(0xff6E6E6E),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),

          ],
        ),
      ),
    ):SizedBox.shrink() ;
  }
  Widget itemBuilder(Extra model,int index){
    return model.name!=''?InkWell(
      onTap: (){
        setState(() {
          if(indexes.any((element) => index == element)){
            indexes.remove(index);
            widget.extraId.remove(model.id);
          }else{
            indexes.add(index);
            widget.extraId.add(model.id??'');
          }
        });
      },
      child: Container(
        height: 34,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: indexes.any((element) => index == element) ?defaultColor:Colors.grey.shade500,
          borderRadius: BorderRadiusDirectional.circular(20)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                model.name??'',
                style:const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
              ),
            ),
            Text(
              '${model.price??''} ${tr("KWD")}',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ):SizedBox();
  }
}
