import 'package:flutter/material.dart';
import 'image_net.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen(this.image);
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        leading: IconButton(
          icon:const Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: ()=>Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InteractiveViewer(
          child: Center(
            child: ImageNet(image: image, ),
          ),
        ),
      ),
    );
  }
}
