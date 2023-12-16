import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../models/provider_products_model.dart';


class SelectType extends StatefulWidget {

  SelectType(this.types);

  List<Types> types;
  String typeId = '';

  @override
  State<SelectType> createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  int currentIndex = 0;

  @override
  void initState() {
    if(widget.types.isNotEmpty)
    Future.delayed(Duration.zero,(){
      setState(() {
        widget.typeId = widget.types[0].id??'';
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child:ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return listItem(model: widget.types[index],index:index );
        }, separatorBuilder: (context, index) {
      return Container(
        height: 1,
        margin: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        color: Color(0xffBEBEBE),
      );
    }, itemCount: widget.types.length)

    // Wrap(
    //   spacing: 15,
    //   runSpacing: 15,
    //   children: List.generate(widget.types.length, (i) =>itemBuilder(widget.types[i],i)),
    // ),
  );
  }
  Widget listItem({required Types model,required int index} ) {
    return model.name!= ''? GestureDetector(
      onTap: (){
        currentIndex = index;
        widget.typeId = model.id??'';

        setState(() {

        });

      },
      child: Container(
        padding:   EdgeInsets.symmetric(
             vertical: 4
        ),

        child: Row(
          children: [
            Center(
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: currentIndex==index? defaultColor: Color(0xff6E6E6E), // Set the border color here
                      width: 1, // Set the border width here
                    ),
                    shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    child: Icon(Icons.check,size: 16,color:currentIndex==index? defaultColor:Colors.transparent,),),
                )
                ,
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
    ):SizedBox.shrink();
  }

}
