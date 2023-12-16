
import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../layout/cubit/cubit.dart';
import '../../modules/home/cubits/review_cubit/review_cubit.dart';
import '../../modules/home/cubits/review_cubit/review_state.dart';
import '../../shared/components/constant.dart';
import '../../shared/images/images.dart';
import '../item_shared/default_button.dart';



class ReviewRestaurantDialog extends StatefulWidget {
  final String providerId;
  const ReviewRestaurantDialog({Key? key, required this.providerId,    }) : super(key: key);

  @override
  ReviewRestaurantDialogState createState() => ReviewRestaurantDialogState();
}

class ReviewRestaurantDialogState extends State<ReviewRestaurantDialog> {
  @override
  void initState() {
    super.initState();

  }
  int currentStar = 1;

  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(

        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child:SingleChildScrollView(
          child: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(),
                            Image.asset(Images.appIcon,height: 100,width: 100,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: AutoSizeText(tr("Skip"),
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: TextStyle(color: Color(0xff6E6E6E),fontSize: 16,fontWeight: FontWeight.w400),)),
                            )
                          ],
                        ),
                        AutoSizeText("Name Of Restaurant", minFontSize: 8,
                          maxLines: 1,style: TextStyle(color: Color(0xff000000),fontSize: 20,fontWeight: FontWeight.w600),),
                        AutoSizeText("Tell Us how you rate our restaurant",
                          minFontSize: 8,
                          maxLines: 1,style: TextStyle(color: Color(0xff2C2C2C),fontSize: 14,fontWeight: FontWeight.w500),),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            itemBuilder(1, Images.star1Yes, Images.star1No),
                            itemBuilder(2, Images.star2Yes, Images.star2No),
                            itemBuilder(3, Images.star3Yes, Images.star3No),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemBuilder(4, Images.star4Yes, Images.star4No),
                            SizedBox(
                              width: size!.width * .1,
                            ),
                            SizedBox(
                                width: size!.width * .25,
                                child: itemBuilder(5, Images.star5Yes, Images.star5No)),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: double.infinity,

                          padding:
                          const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffB3B3B3),width: 1),
                            borderRadius: BorderRadiusDirectional.circular(15),
                          ),
                          child: TextFormField(
                            maxLines: 3,
                            onTap: (){
                              Future.delayed(Duration(milliseconds: 500),(){
                                scrollController.position.jumpTo(scrollController.position.maxScrollExtent);
                              });
                            },
                            controller: controller,

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: tr('Leave_Us_a_comment')),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocConsumer<ReviewCubit,ReviewState>(
                          listener: (context, state) {
                            if(state is AddReviewToProviderSuccessState){
                              Navigator.pop(context);

                            }
                          },
                          builder: (context, state) {
                            return
                              state is AddReviewToProviderLoadState?
                              Center(child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: CircularProgressIndicator(color: defaultColor,),
                              ),):
                              Center(
                                child: DefaultButton(
                                    color: Color(0xffED285D),
                                    text: tr('submit_review'),
                                    onTap: (){
                                      if(formKey.currentState!.validate()){
                                        ReviewCubit.get(context).addReviewToProvider(providerId:  widget.providerId,
                                            context: context, content: controller.text, rate: currentStar);
                                      }
                                    }
                                ),
                              );
                          },
                        ),


                        SizedBox(height: 15,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget itemBuilder(int index, String imageYes, String imageNo) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        setState(() {
          currentStar = index;
        });
      },
      child: Image.asset(
        currentStar == index ? imageYes : imageNo,
        width: size!.width * .2,
      ),
    );
  }
}
