import 'package:flutter/material.dart';
import 'package:safri/models/ads_model.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/item_shared/image_net.dart';

import '../../modules/product/product_screen.dart';
import '../../modules/restaurant/restaurant_screen.dart';
import '../../shared/components/components.dart';
import '../item_shared/image_screen.dart';

class AdDialog extends StatelessWidget {
  AdDialog(this.ad);

  ImageAdvertisements ad;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(15)
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            InkWell(
                onTap: (){
                  // if(ad.advertisementViewType==2){
                  if(ad.type==1){
                    Navigator.pop(context);
                    navigateTo(context, ImageScreen(ad.backgroundImage??""));
                  }else if(ad.type==2){
                    print("url");
                    Navigator.pop(context);
                    openUrl(ad.link??'');
                  }
                  else if(ad.type==3){
                    print("goooo");
                    print(ad.id);
                    Navigator.pop(context);
                    navigateTo(context, RestaurantScreen(id: ad.link??'',isBranch: false,));
                  }else if(ad.type==4){
                    print(" go to product screen");
                    print(ad.id);
                    print(ad.link);
                    Navigator.pop(context);
                    navigateTo(context, ProductScreen(id: ad.link??'' ));
                    return;
                    // print("goooo");
                    // print(ad.id);
                    // navigateTo(context, RestaurantScreen(id: ad.link??'',isBranch: false,));
                  }
                  // }

                },
            child: ImageNet(image: ad.backgroundImage??'',fit: null,width: null,height: null,haveLoading: false,)),
            Positioned(
              top: 4,right: 6,
              child: IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: Image.asset(Images.close,width: 45,height: 45,)),
            )
          ],
        ),
      ),
    );
  }
}
