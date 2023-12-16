import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LineShimmer extends StatelessWidget {
  const LineShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade200,
      child: Container(
        height: 10,width: double.infinity,color: Colors.white,
      ),
    );
  }
}
