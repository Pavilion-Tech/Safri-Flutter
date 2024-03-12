import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/images/images.dart';


class ImageNet extends StatelessWidget {
  ImageNet({
    required this.image,
    this.height = double.infinity,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
    this.haveLoading=true
});

 final String image;
  double? height;
  double? width;
  BoxFit? fit;
  bool haveLoading;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: image,
        httpHeaders: {
          'Accept': 'image/*'
        },
        height: height,width: width,
        fit: fit,
        errorWidget: (context, url, error) => Image.asset(Images.holder,fit:fit,width: width,height: height,),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            ConditionalBuilder(
              condition: haveLoading,
              fallback: (c)=>SizedBox(),
              builder: (c)=> Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(Images.holder,fit:fit,width: width,height: height,),
                    CupertinoActivityIndicator()
                  ],
                ),
              ),
            )
    );
  }
}
