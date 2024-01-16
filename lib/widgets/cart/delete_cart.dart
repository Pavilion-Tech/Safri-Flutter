import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

class DeleteCartDialog extends StatelessWidget {
  DeleteCartDialog({Key? key,required this.quantity,required this.productId,required  this.typeId,required this.extraId}) : super(key: key);
  List<String> extraId = [];
  String typeId = '';
  String productId="";
  String quantity="";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
      listener: (context, state) {
        if(state is DeleteAllCartSuccessState)Navigator.pop(context);
      },
      builder: (context, state) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20)),
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 40),
            child: InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () => Navigator.pop(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Images.bin,
                    height: 200,
                    width: 200,
                    color: defaultColor,
                  ),
                  Text(
                    tr('delete_cart_note'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 20,),
                  ConditionalBuilder(
                    condition: state is! DeleteAllCartLoadingState,
                    fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
                    builder: (c)=> DefaultButton(
                        text: tr('delete_cart'),
                        onTap: () {
                          FastCubit.get(context).deleteAllCart( );
                        }),
                  ),
                  TextButton(
                      onPressed: () {
                        FastCubit.get(context).changeIndex(1);
                        navigateAndFinish(context, FastLayout());
                      },
                      child: Text(
                        tr('cart'),
                        style: TextStyle(
                            color: defaultColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
