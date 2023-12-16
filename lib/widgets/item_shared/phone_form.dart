import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/shared/styles/colors.dart';

import '../../shared/components/constant.dart';

class PhoneForm extends StatelessWidget {
  PhoneForm({required this.controller,required this.validator,this.readOnly = false});

  FocusNode focusNode = FocusNode();
  bool readOnly;

  TextEditingController controller;
  FormFieldValidator validator;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color:focusNode.hasFocus?defaultColor: Colors.grey)
          ),
          alignment: AlignmentDirectional.center,
        ),
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 15),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              children: [
                AbsorbPointer(child: DropDownCode()),
                Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      focusNode: focusNode,
                      controller: controller,
                      readOnly: readOnly,
                      validator: validator,
                      decoration: InputDecoration(
                          hintText :'X XXXX XXXX',
                          hintStyle:const TextStyle(color: Colors.grey),
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                    )
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DropDownCode extends StatefulWidget {

  @override
  State<DropDownCode> createState() => _DropDownCodeState();
}

class _DropDownCodeState extends State<DropDownCode> {
List<DropDownCodeModel> model = [
  DropDownCodeModel(
    code: ' + 965',
    flag: Images.flag7,
  ),
  // DropDownCodeModel(
  //   code: ' + 971',
  //   flag: Images.flag,
  // ),
  // DropDownCodeModel(
  //   code: ' + 20',
  //   flag: Images.flag2,
  // ),
  // DropDownCodeModel(
  //   code: ' + 968',
  //   flag: Images.flag3,
  // ),
  // DropDownCodeModel(
  //   code: ' + 973',
  //   flag: Images.flag4,
  // ),
  // DropDownCodeModel(
  //   code: ' + 974',
  //   flag: Images.flag5,
  // ),
  // DropDownCodeModel(
  //   code: ' + 964',
  //   flag: Images.flag6,
  // ),
  //
  // DropDownCodeModel(
  //   code: ' + 966',
  //   flag: Images.flag8,
  // ),
];

DropDownCodeModel? value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
        elevation: 0,
        focusColor: Colors.transparent,
        underline: const SizedBox(),
     //   iconEnabledColor: Colors.transparent,
       // iconDisabledColor: Colors.transparent,
        hint: Row(
          children: [
            Image.asset(model[0].flag,width: 25,),
            AutoSizeText(
              model[0].code,
              minFontSize: 8,
              maxLines: 1,
              style:const TextStyle(fontSize: 9.7,color: Colors.grey),
            ),
          ],
        ),
        items: model.map((e){
          return DropdownMenuItem<DropDownCodeModel>(
              child:Row(
                children: [
                  Image.asset(e.flag,width: 25,),
                  AutoSizeText(
                    e.code,
                    minFontSize: 8,
                    maxLines: 1,
                    style:const TextStyle(fontSize: 9.7,color: Colors.grey),
                  ),
                ],
              ),
            value: e,
          );
        }).toList(),
        onChanged: (DropDownCodeModel? val){
        setState(() {
          value = val;
        });
        },
    );
  }
}

class DropDownCodeModel{
  DropDownCodeModel({
    required this.code,
    required this.flag,
});
  String flag;
  String code;
}

