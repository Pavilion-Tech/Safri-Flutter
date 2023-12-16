import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safri/modules/menu/cubit/menu_cubit.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../shared/components/constant.dart';
import '../../shared/network/local/cache_helper.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                tr('delete_account_sure'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15.5,fontWeight: FontWeight.w600),
              ),
            ),
            DefaultButton(
                text: tr('delete_account'),
                onTap: ()=>MenuCubit.get(context).log(context,isDelete: true)
            ),
            const SizedBox(height: 20,),
            DefaultButton(
                text: tr('discard'),
                color: Colors.white,
                textColor: defaultColor,
                onTap: ()=>Navigator.pop(context)
            ),
          ],
        ),
      ),
    );
  }

}
