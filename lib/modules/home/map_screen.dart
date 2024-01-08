import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/shared/network/local/cache_helper.dart';
import 'package:safri/shared/styles/colors.dart';
import 'package:safri/widgets/item_shared/default_button.dart';

import '../../shared/components/constant.dart';
import 'cubits/home_category_cubit/home_category_cubit.dart';
import 'cubits/home_category_cubit/home_category_states.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(HomeCategoryCubit.get(context).position==null){
      HomeCategoryCubit.get(context).position=LatLng(25.2048,55.2708);
      HomeCategoryCubit.get(context).getAddress(HomeCategoryCubit.get(context).position!);
    }
    if(lat!=null){
      HomeCategoryCubit.get(context).position=LatLng(lat!,lng!);
      HomeCategoryCubit.get(context).getAddress(HomeCategoryCubit.get(context).position!);
    }
    return BlocConsumer<HomeCategoryCubit, HomeCategoryStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCategoryCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,elevation: 0,
            leading: IconButton(
              onPressed: (){
                cubit.locationController.text = '';
                cubit.position = null;
                cubit.emitState();
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target:LatLng(
                        cubit.position?.latitude??25.2048,cubit.position?.longitude??55.2708
                    ),
                    zoom: 5
                  ),
                onTap: (latLng){
                  cubit.position = latLng;
                  cubit.getAddress(latLng);
                },
                myLocationEnabled: true,
                zoomGesturesEnabled: false,
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 50),
                  child: Column(
                    children: [
                      Container(
                        height: 50,width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(15),
                          color: Colors.white
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerStart,
                        child: AutoSizeText(
                          cubit.locationController.text,
                          minFontSize: 8,
                          maxLines: 1,
                        ),

                      ),
                      const Spacer(),
                      DefaultButton(
                          text: tr('done'),
                          onTap: (){
                            lat = cubit.position!.latitude;
                            lng = cubit.position!.longitude;
                            CacheHelper.saveData(key: 'lat', value: lat);
                            CacheHelper.saveData(key: 'lng', value: lng);
                            cubit.getProviderCategory();
                            Navigator.pop(context);
                          }
                      ),
                      const SizedBox(height: 20,),
                      DefaultButton(
                          text: tr('without_address'),
                          textColor: defaultColor,
                          color: Colors.white,
                          onTap: (){
                            lat = null;
                            lng = null;
                            CacheHelper.removeData('lat');
                            CacheHelper.removeData('lng');
                            cubit.position = null;
                            cubit.locationController.text = '';
                            cubit.getProviderCategory();
                            Navigator.pop(context);
                          }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
