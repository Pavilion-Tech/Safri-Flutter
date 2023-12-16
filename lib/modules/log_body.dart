import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/modules/auth/cubit/auth_cubit.dart';

import '../shared/components/components.dart';
import '../shared/components/constant.dart';
import '../shared/images/images.dart';
import '../shared/styles/colors.dart';
import '../widgets/item_shared/default_button.dart';
import '../widgets/item_shared/phone_form.dart';
import 'auth/cubit/auth_states.dart';

class LogBody extends StatelessWidget {
  LogBody({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Images.login,
                    width: size!.width * .8, height: size!.height * .3,
                  ),
                  AutoSizeText(
                    tr('hello'),
                    minFontSize: 8,
                    maxLines: 1,
                    style: TextStyle(color: defaultColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50, left: 50),
                    child: AutoSizeText(
                      tr('i_happy'),
                      minFontSize: 8,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: PhoneForm(
                        controller: AuthCubit.get(context).phoneController,
                        validator: (str){
                          if(str.isEmpty)return tr('phone_empty');
                        },
                      ),
                    ),
                  ),
                  state is! LoginLoadingState?
                  DefaultButton(
                      text: tr('sign_in'),
                      onTap: () {
                        if(formKey.currentState!.validate()){
                          AuthCubit.get(context).login(context: context);
                        }
                      }
                  ):CupertinoActivityIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
