import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/modules/auth/cubit/auth_cubit.dart';
import 'package:safri/modules/auth/cubit/auth_states.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../layout/layout_screen.dart';
import '../../shared/components/constant.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  TextEditingController otpController1 = TextEditingController();

  TextEditingController otpController2 = TextEditingController();

  TextEditingController otpController3 = TextEditingController();

  TextEditingController otpController4 = TextEditingController();

  int _start = 60;

  bool timerFinished = false;

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  bool checkCode() {
    String codeFromOtp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text;
    return int.parse(myLocale == 'en'
        ? codeFromOtp
        : String.fromCharCodes(codeFromOtp.runes.toList().reversed)) ==
        code;
  }

  bool checkOTP() {
    if (otpController1.text.isEmpty ||
        otpController2.text.isEmpty ||
        otpController3.text.isEmpty ||
        otpController4.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void submit(BuildContext context) {
    if (checkOTP()) {
      if (checkCode()) {
        AuthCubit.get(context).verificationCode(context);
      } else {
        showToast(msg: tr('code_invalid'), toastState: true);
      }
    } else {
      showToast(msg: tr('code_empty'), toastState: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
  listener: (context, state) {
    if(state is VerificationCodeSuccessState)navigateAndFinish(context, FastLayout());
  },
  builder: (context, state) {
    return InkWell(
      onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(
            right: 40,left: 40,
            bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 30,bottom: size!.height*.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                tr('verification'),
                minFontSize: 8,
                maxLines: 1,
                style:const TextStyle(fontWeight: FontWeight.w500,fontSize: 30),
              ),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: tr('enter_code_from_phone'),
                  style: TextStyle(color: Colors.grey.shade600),
                  children: [
                    TextSpan(
                      text: AuthCubit.get(context).phoneController.text,
                        style: const TextStyle(color: Colors.black)
                    )
                  ]
                )
              ),
             Padding(
               padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 40),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   OTPWidget(
                     autofocus: myLocale == 'ar'?false:true,
                     onFinished: () {
                       if (myLocale != 'en') {
                         submit(context);
                       }
                     },
                     controller: otpController1,
                   ),
                   OTPWidget(controller: otpController2,),
                   OTPWidget(controller: otpController3,),
                   OTPWidget(
                     autofocus: myLocale == 'ar'?true:false,
                     controller: otpController4,
                     onFinished: () {
                       if (myLocale != 'ar') {
                         submit(context);
                       }
                     },
                   ),
                 ],
               ),
             ),
              const SizedBox(height: 10,),
              if (!timerFinished)
                AutoSizeText(
                  '00:$_start',
                  minFontSize: 8,
                  maxLines: 1,
                ),
              if (timerFinished)
                InkWell(
                  onTap: () {
                    timer;
                    _start = 60;
                    timerFinished = false;
                    startTimer();
                    AuthCubit.get(context).login();
                  },
                  child:AutoSizeText(
                    tr('try_again'),
                    minFontSize: 8,
                    maxLines: 1,
                  ),
                ),
              const SizedBox(height: 10,),
              state is! VerificationCodeLoadingState?
              DefaultButton(
                  text: tr('verify'),
                  onTap: (){
                    submit(context);
                  }
              ):CupertinoActivityIndicator()
            ],
          ),
        ),
      ),
    );
  },
);
  }
}


class OTPWidget extends StatelessWidget {

  OTPWidget({this.autofocus = false,this.onFinished,required this.controller});

  bool autofocus;
  VoidCallback? onFinished;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        autofocus:autofocus,
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.phone,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: '*',
          hintStyle:const TextStyle(fontSize: 40),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          borderSide:const BorderSide(color:Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color:defaultColor)
          )
        ),
        onChanged: (value) {
          if(value.isNotEmpty){
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.previousFocus()
                :FocusManager.instance.primaryFocus!.nextFocus();
            if(onFinished!=null)onFinished!();
          }else{
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.nextFocus()
                :FocusManager.instance.primaryFocus!.previousFocus();
          }
          },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}

