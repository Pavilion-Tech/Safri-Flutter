import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/widgets/cart/cart_item.dart';
import 'package:safri/widgets/item_shared/default_button.dart';
import '../../models/cart_model.dart';
import '../../shared/components/constant.dart';
import '../../widgets/cart/no_carts.dart';
import '../../widgets/item_shared/default_appbar.dart';
import '../../widgets/shimmer/cart_shimmer.dart';
import '../log_body.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(token ==null){
      FastCubit.get(context).cartModel=CartModel();
    }
    FastCubit.get(context).getAllCarts(page: 1);
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FastCubit, FastStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = FastCubit.get(context);
    print("cubit.cartModel?.data?.data?.cart");
    print(cubit.cartModel?.data?.cart?.length);
    return Stack(
      children: [
        Column(
          children: [
            DefaultAppBar(tr('cart'),isCart: true),
            Expanded(
              child: ConditionalBuilder(
                condition: token!=null,
                fallback: (c)=>LogBody(),
                builder: (c)=> ConditionalBuilder(
                  condition: cubit.cartModel!=null,
                  fallback: (c)=>CartShimmer(),
                  builder: (c)=> ConditionalBuilder(
                    condition: cubit.cartModel?.data?.cart?.isNotEmpty??true,
                    fallback: (c)=>NoCarts(),
                    builder: (c){
                      Future.delayed(Duration.zero,(){
                        cubit.paginationCarts();
                      });
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (c, i) => CartItem(cubit.cartModel!.data!.cart![i]),
                                controller:cubit.cartScrollController,
                                separatorBuilder: (c, i) => const SizedBox(
                                  height: 20,
                                ),
                                padding: EdgeInsetsDirectional.only(
                                    top: 20,bottom: 70,start: 20,end: 20
                                ),
                                itemCount: cubit.cartModel?.data?.cart?.length??0
                            ),
                          ),
                          if(state is GetCartLoadingState)
                            CupertinoActivityIndicator()
                        ],
                      );
                    }
                  ),
                ),
              ),
            ),
          ],
        ),
        if(token !=null)
        ConditionalBuilder(
          condition: cubit.cartModel!=null,
          fallback: (c)=>const SizedBox(),
          builder: (c)=> ConditionalBuilder(
            condition: cubit.cartModel?.data?.cart?.isNotEmpty??true,
            fallback: (c)=>const SizedBox(),
            builder: (c)=> Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: DefaultButton(
                  text: tr('checkout'),
                  onTap: () {
                    cubit.couponModel=null;
                    cubit.currentGift=null;
                    cubit.useWallet=false;
                    navigateTo(context, CheckoutScreen());
                  },
                ),
              ),
            ),
          ),
        ),

      ],
    );
  },
);
  }
}
