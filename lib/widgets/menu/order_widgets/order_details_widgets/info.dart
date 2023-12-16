import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  Info({
    required this.title,
    required this.subTitle,
    required this.subTitleDesc,
    this.subSubTitle,
    this.subSubTitleDesc,
});

  String title;
  String subTitle;
  String subTitleDesc;
  String? subSubTitle;
  String? subSubTitleDesc;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("subSubTitleDesc");
    print(widget.subSubTitleDesc);
    print(widget.subTitleDesc);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 16),
        ),
        if(widget.subTitleDesc !="null")
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Text(
                widget.subTitle,
                style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              Text(
                widget.subTitleDesc,
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
              ),
            ],
          ),
        ),
        if(widget.subSubTitleDesc !="null")
        Row(
          children: [
            Text(
              widget.subSubTitle??"",
              style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
            ),
            const Spacer(),
            AutoSizeText(
              widget.subSubTitleDesc??"",
              minFontSize: 10,
              maxLines: 2,
              style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}
