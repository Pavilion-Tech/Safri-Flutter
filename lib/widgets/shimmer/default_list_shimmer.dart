import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DefaultListShimmer extends StatelessWidget {
  DefaultListShimmer({this.havePadding = true});

  bool havePadding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (c,i)=>Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey.shade200,
        child: Container(
          width: double.infinity,
          height: 84,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: Colors.white
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: havePadding?20:0),
      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
      itemCount: 8,
    );
  }
}
