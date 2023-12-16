import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding:const EdgeInsets.all(10),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (c,i)=> Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color:Colors.grey
            ),
          ),
        ),
        separatorBuilder: (c,i)=>const SizedBox(height: 10,),
        itemCount: 7
    );
  }
}
