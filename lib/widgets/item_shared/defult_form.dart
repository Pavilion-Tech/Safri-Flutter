import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safri/shared/styles/colors.dart';

class DefaultForm extends StatelessWidget {
  DefaultForm({
    required this.hint,
     this.suffix,
     this.prefix,
     this.type,
     this.onChange,
     this.onTap,
    this.maxLines = 1,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.readOnly = false
});

  String hint;
  int maxLines;
  Widget? suffix;
  Widget? prefix;
  final List<TextInputFormatter>? inputFormatters;
  bool readOnly;
  TextInputType? type;
  ValueChanged<String>? onChange;
  GestureTapCallback? onTap;
  TextEditingController? controller;
  FormFieldValidator? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: defaultColor,
      keyboardType: type,
      inputFormatters:inputFormatters??  [],
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      readOnly: readOnly,
      controller: controller,
      maxLines: maxLines,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: defaultColor)
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
        hintText: hint,hintStyle: TextStyle(color: Colors.grey)
      ),
    );
  }
}
