import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/modules/auth/cubit/auth_cubit.dart';
import 'package:safri/modules/auth/cubit/auth_states.dart';
import 'package:safri/modules/auth/verification.dart';
import 'package:safri/modules/log_body.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';
import 'package:safri/widgets/menu/lang_dialog.dart';

import '../../shared/components/components.dart';
import '../../widgets/item_shared/phone_form.dart';

class LoginScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 100,
            leading: TextButton(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20),
                child: AutoSizeText(
                  tr('current_lang'),
                  minFontSize: 8,
                  maxLines: 1,
                  style: TextStyle(color: defaultColor, fontSize: 15),
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => LangDialog()
                );
              },
            ),
          ),
          body: LogBody(),
        );
      },
    );
  }
}
