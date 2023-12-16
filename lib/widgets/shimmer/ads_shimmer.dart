import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/components/constant.dart';
import 'default_list_shimmer.dart';
import 'line_shimmer.dart';

class AdsShimmer extends StatelessWidget {
  const AdsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey.shade200,
              child: Container(
                height: 142,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(21),
                    color: Colors.white
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
