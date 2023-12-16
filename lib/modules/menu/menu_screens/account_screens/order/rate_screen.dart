import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import '../../../../../shared/components/constant.dart';
import '../../../../../shared/images/images.dart';
import '../../../../../widgets/item_shared/default_appbar.dart';
import '../../../../../widgets/item_shared/default_button.dart';

class RateScreen extends StatefulWidget {

  String id;
  RateScreen(this.id);
  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {


  int currentStar = 1;

  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {
    if(state is RateSuccessState)Navigator.pop(context);
  },
  builder: (context, state) {
    return Scaffold(
      body: InkWell(
        onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        child: Column(
          children: [
            DefaultAppBar(tr('rate')),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40,),
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
                        const SizedBox(height: 40,),
                        AutoSizeText(
                          tr('comment'),
                          minFontSize: 8,
                          maxLines: 1,
                          style:const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Container(
                          width: double.infinity,
                          height: 171,
                          padding:
                              const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadiusDirectional.circular(18),
                          ),
                          child: TextFormField(
                            maxLines: 6,
                            onTap: (){
                              Future.delayed(Duration(milliseconds: 500),(){
                                scrollController.position.jumpTo(scrollController.position.maxScrollExtent);
                              });
                            },
                            controller: controller,
                            validator: (str){
                              if(str!.isEmpty)return tr('comment_empty');
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: tr('comment')),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RateLoadingState,
                            fallback: (c)=>CupertinoActivityIndicator(),
                          builder: (c)=> DefaultButton(
                                text: tr('submit_review'),
                                onTap: (){
                                  if(formKey.currentState!.validate()){
                                    FastCubit.get(context).rateRestaurant(
                                      providerId: widget.id,
                                      rateContent: controller.text,
                                      rateNum: currentStar
                                    );
                                  }
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  },
);
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
