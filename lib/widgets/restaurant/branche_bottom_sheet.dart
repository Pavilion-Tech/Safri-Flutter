import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';

import '../item_shared/provider_item.dart';

class BrancheBottomSheet extends StatelessWidget {
  const BrancheBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FastCubit.get(context);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: AutoSizeText(
                tr('change_branch'),
                minFontSize: 8,
                maxLines: 1,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            ConditionalBuilder(
              condition: cubit.providerBranchesModel!=null,
              fallback: (c)=>Center(child: CupertinoActivityIndicator(),),
              builder: (c)=> ConditionalBuilder(
                condition: cubit.providerBranchesModel!.data!.data!.isNotEmpty,
                fallback: (c)=>Center(child: AutoSizeText(tr('no_branches'),
                  minFontSize: 8,
                  maxLines: 1,)),
                builder: (c){
                  Future.delayed(Duration.zero,(){
                    cubit.paginationProviderBranches();
                  });
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListView.separated(
                        itemBuilder: (c, i) => ProviderItem(
                            providerData:cubit.providerBranchesModel!.data!.data![i],
                            isBranch: true),
                        separatorBuilder: (c, i) => const SizedBox(height: 20,),
                        shrinkWrap: true,
                        controller: cubit.providerBranchesScrollController,
                        itemCount: cubit.providerBranchesModel!.data!.data!.length,
                        padding: EdgeInsets.all(20),
                      ),
                      if(state is ProviderBranchesLoadingState)
                        CupertinoActivityIndicator()
                    ],
                  );
                }
              ),
            )
          ],
        );
      },
    );
  }
}
