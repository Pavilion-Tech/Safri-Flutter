import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (c,i)=>Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Colors.grey.shade200,
        child: Container(
          width: double.infinity,
          height: 135,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: Colors.white
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      separatorBuilder: (c,i)=>const SizedBox(height: 20,),
      itemCount: 8,
    );
  }
}
