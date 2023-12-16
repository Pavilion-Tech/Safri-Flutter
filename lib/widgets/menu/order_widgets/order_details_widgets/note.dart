import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  Note(this.note);
  String note;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          tr('notes'),
          minFontSize: 8,
          maxLines: 1,
          style:const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10,),
        AutoSizeText(
          note,
          minFontSize: 8,
          maxLines: 1,
          style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
