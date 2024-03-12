import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/models/provider_products_model.dart';
import 'package:safri/shared/styles/colors.dart';


class SelectSize extends StatefulWidget {
  SelectSize(this.sizes);
  List<Sizes> sizes;

  String? sizedId;

  @override
  State<SelectSize> createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  int currentIndex = 0;


  @override
  void initState() {
    if(widget.sizes.isNotEmpty)
    Future.delayed(Duration.zero,(){
      setState(() {
        widget.sizedId = widget.sizes[0].id??'';
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
        return listItem(model: widget.sizes[index],index:index );
      }, separatorBuilder: (context, index) {
        return Container(
          height: 1,
          margin: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          color: Color(0xffBEBEBE),
        );
      }, itemCount: widget.sizes.length)
      
      // Wrap(
      //   spacing: 15,
      //   runSpacing: 15,
      //   children: List.generate(widget.sizes.length, (i) =>itemBuilder(widget.sizes[i],i)),
      // ),
    );
  }

  Widget listItem({required Sizes model,required int index} ) {
    return GestureDetector(
      onTap: (){
        currentIndex = index;
        widget.sizedId = model.id??'';

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
              child: AutoSizeText(
                  model.name??'',
                minFontSize: 8,
                maxLines: 1,
                style: const TextStyle(
                    color:  Color(0xff6E6E6E),
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
            AutoSizeText(
              model.priceAfterDiscount !="null"?model.priceAfterDiscount.toString():   '0',
              minFontSize: 8,
              maxLines: 1,
              style: const TextStyle(
                  color:  Color(0xff6E6E6E),
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 3,
            ),
            AutoSizeText(
              tr("KWD"),
              minFontSize: 8,
              maxLines: 1,
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
    );
  }

}
