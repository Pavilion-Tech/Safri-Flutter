import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:safri/shared/images/images.dart';

import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import '../item_shared/image_net.dart';
import '../item_shared/image_screen.dart';

class ProductImages extends StatefulWidget {
  ProductImages({Key? key,this.image}) : super(key: key);

  List<String>? image;

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30,right: 10,left: 10),
        child: ConditionalBuilder(
          condition: widget.image?.isNotEmpty??false,
          fallback: (c)=>Image.asset(Images.holder,
            height: 258,width: double.infinity,fit: BoxFit.cover,),
          builder: (c)=> ConditionalBuilder(
            condition: widget.image!.length != 1,
            fallback: (c)=>InkWell(
              onTap: ()=>navigateTo(context, ImageScreen(widget.image?[0]??'',)),
              child: ImageNet(image: widget.image?[0]??'',height: 258,width: double.infinity,fit: null,)),
            builder: (c)=> Column(
              children: [
                CarouselSlider(
                  items: List.generate(widget.image?.length??0, (index) =>InkWell(
                      onTap: ()=>navigateTo(context, ImageScreen(widget.image?[index]??'',)),
                      child: ImageNet(image: widget.image?[index]??'',height: 258,width: double.infinity,fit: null,)),),
                  options: CarouselOptions(
                      height: 258,
                      initialPage: 0,
                      onPageChanged: (int page, CarouselPageChangedReason changedReason) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 3),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                      viewportFraction: 1,
                      enlargeCenterPage: true
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.image!.length, (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: AnimatedContainer(
                      duration:const Duration(milliseconds: 500),
                      height: 4.22,
                      width: currentPage ==index?30:5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(11),
                          color: currentPage ==index?defaultColor:Colors.grey.shade300),
                    ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
