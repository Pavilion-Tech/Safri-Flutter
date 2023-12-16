import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../shared/components/constant.dart';
import 'default_list_shimmer.dart';
import 'line_shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Shimmer.fromColors(
            //   highlightColor: Colors.white,
            //   baseColor: Colors.grey.shade200,
            //   child: Container(
            //     height: 142,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadiusDirectional.circular(21),
            //       color: Colors.white
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: List.generate(3, (i) => Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey.shade200,
                    child: Container(
                      height: 30,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(48),
                          color:Colors.white
                      ),
                    ),
                  )),
                ),
              ),
            ),
            DefaultListShimmer(havePadding: false,)
          ],
        ),
      ),
    );
  }
}
