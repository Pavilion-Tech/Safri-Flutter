import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:safri/modules/menu/cubit/menu_states.dart';
import 'package:safri/widgets/item_shared/default_appbar.dart';
import 'package:safri/widgets/shimmer/line_shimmer.dart';

import '../../../../shared/components/constant.dart';
import '../../cubit/menu_cubit.dart';

class AboutUsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: Column(
        children: [
          DefaultAppBar(tr('about_us')),
          Expanded(
            child: ConditionalBuilder(
              condition:  MenuCubit.get(context).staticPagesModel!=null,
              fallback: (c)=>ListView.separated(
                itemCount: 30,
                itemBuilder: (c,i)=>LineShimmer(),
                padding: EdgeInsets.symmetric(horizontal: 20),
                separatorBuilder: (c,i)=>const SizedBox(height: 20,),
              ),
              builder: (c)=> SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30,left: 30,bottom: 50),
                  child:  Html(
                      data:myLocale =='en'
                          ? MenuCubit.get(context).staticPagesModel?.data?.aboutUsEn??''
                          : MenuCubit.get(context).staticPagesModel?.data?.aboutUsAr??''
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }
}
