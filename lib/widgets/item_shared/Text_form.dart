
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InputTextFormField extends StatelessWidget {
 final String hintText;
 final Widget? prefixIcon;
 final Widget? suffixIcon;
 final TextEditingController? textEditingController;
 final  Function(String) validator;
 final int? maxLines;
 final int? minLines;
 final int? maxLength;
 final FocusNode? focusNode;
 final Color? fillColor;
 final Color? searchColor;
 final Color? hintColor;
 final bool? readOnly;
 final bool? isContentPadding;
 final void Function()? onTap;
 final double? paddingVertical;
 final double? paddingHorizontal;
 final List<TextInputFormatter>? inputFormatters;
 final FocusNode? nextFocusNode;
 final TextInputType? textInputType;
 final TextInputAction? inputAction;
 final  bool secure;
 final void Function(String)? onChanged;

  const InputTextFormField({
    Key? key,
    this.prefixIcon,
    required this.hintText,
    required this.textEditingController,
    required this.validator,
    this.suffixIcon,
    this.fillColor,
    this.searchColor,
    this.onChanged,
    this.readOnly,
    this.isContentPadding,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.focusNode,
    this.nextFocusNode,
    this.textInputType,
    this.inputAction,
    this.secure = false, this.paddingVertical,  this.paddingHorizontal,
    this.onTap, this.inputFormatters, this.hintColor,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.symmetric(vertical: paddingVertical??10,horizontal:paddingHorizontal??20 ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey,width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextFormField(
          onTap:onTap ,
          controller: textEditingController,
          textAlignVertical: TextAlignVertical.center,
          validator: (val) => validator(val!),
          maxLines: maxLines,
          style:   TextStyle(wordSpacing: 2,
            fontSize: 16,
            color: searchColor?? const Color(0xff979797),
            fontWeight: FontWeight.w600,
          ),
          inputFormatters:inputFormatters??  [],
          minLines: minLines,
          focusNode: focusNode,
          maxLength: maxLength,
          onChanged: onChanged,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(nextFocusNode),
          keyboardType: textInputType,
          textInputAction: inputAction,
          obscureText: secure,

          readOnly: readOnly ?? false,
          decoration: InputDecoration(

            hintText: hintText,
              contentPadding:isContentPadding==true?  EdgeInsets.zero:const EdgeInsets.fromLTRB(12, 8, 12, 8), // Remove any padding
            isDense: true,
            hintStyle:    TextStyle(wordSpacing: 2,
                fontSize: 16,
                color: hintColor?? const Color(0xff979797),
                fontWeight: FontWeight.w600,
               ),
            filled: true,
            fillColor: fillColor ?? const Color(0xffECECEC),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            // contentPadding: EdgeInsets.zero,
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
