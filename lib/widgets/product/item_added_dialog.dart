import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/layout_screen.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

class ItemAddedDialog extends StatelessWidget {
    ItemAddedDialog({Key? key,  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding:const EdgeInsets.symmetric(horizontal: 20),
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
                Images.checkoutDialog,
                width: 200,
              ),
              Text(
                tr('cart_success'),
                style:const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              const SizedBox(height: 20,),
              DefaultButton(
                  text: tr('continue_shopping'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }),
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
  }
}
