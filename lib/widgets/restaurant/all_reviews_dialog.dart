
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../models/provider_category_model.dart';
import '../../shared/components/constant.dart';
import '../../shared/images/images.dart';
import '../item_shared/default_button.dart';



class AllReviewsDialog extends StatefulWidget {
  final List<Reviews> reviews;
  const AllReviewsDialog({Key? key, required this.reviews,    }) : super(key: key);

  @override
  AllReviewsDialogState createState() => AllReviewsDialogState();
}

class AllReviewsDialogState extends State<AllReviewsDialog> {
  @override
  void initState() {
    super.initState();

  }




  @override
  Widget build(BuildContext context) {
    return Dialog(

        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:Container(
          height: 600,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0,right: 20,left: 20,bottom: 20),
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(child: AutoSizeText(
                      tr('Reviews'), minFontSize: 8,
                      maxLines: 1,style:const TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color(0xffA3A3A3)),
                    ),),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },child: Icon(Icons.close,color: defaultColor,))
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data=widget.reviews[index];
                      return Padding(
                        padding:   EdgeInsets.only(top: 0.0,right: 20,left: 20,bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: AutoSizeText(data.userName??"",
                                  overflow: TextOverflow.ellipsis,
                                  minFontSize: 8,
                                  maxLines: 1,
                                  style:
                                  TextStyle(color:Color(0xff3B3B3B),fontWeight: FontWeight.w600,fontSize: 17),)),
                                SizedBox(width: 5,),
                                RatingBar.builder(
                                  initialRating: double.tryParse(data.rate.toString())??0,
                                  // initialRating:  0,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  ignoreGestures: true,
                                  itemSize: 18,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                  itemBuilder: (context, _) => Icon(

                                    Icons.star,
                                    color: Colors.amber,
                                    size: 5,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ],
                            ),
                            AutoSizeText( data.content??"",
                              minFontSize: 8,

                              style:
                              TextStyle(color:Color(0xff5C5C5C),fontWeight: FontWeight.w400,fontSize: 11),)
                          ],
                        ),
                      );
                    }, separatorBuilder: (context, index) {
                  return Container(height: 1,width: double.infinity,color: Color(0xffDFDFDF),
                    margin:   const EdgeInsets.only(top:10.0,right: 20,left: 20,bottom: 10) ,);
                }, itemCount: widget.reviews.length),
              ),
            ],
          ),
        ));
  }


}
