import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safri/layout/cubit/cubit.dart';
import 'package:safri/layout/cubit/states.dart';
import 'package:safri/modules/addresses/add_new_address_screen.dart';
import 'package:safri/modules/addresses/widgets/addresses_list.dart';
import 'package:safri/shared/components/components.dart';
import 'package:safri/shared/components/constant.dart';
import 'package:safri/shared/images/images.dart';
import 'package:safri/widgets/cart/checkout/pick_up.dart';
import 'package:safri/widgets/item_shared/default_button.dart';
import 'package:safri/widgets/item_shared/defult_form.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../widgets/cart/checkout/checkout_done.dart';
import '../../widgets/cart/checkout/checkout_list_item.dart';
import '../../widgets/cart/checkout/have_discount.dart';
import '../../widgets/cart/checkout/invoice.dart';
import '../../widgets/cart/checkout/payment_method.dart';
import '../../widgets/cart/checkout/pick_time.dart';
import '../../widgets/cart/checkout/select_sevice_type.dart';
import '../../widgets/item_shared/default_appbar.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  SelectServiceType selectServiceType = SelectServiceType();
  PickUp pickUp = PickUp();
  PickTime pickTime = PickTime();
  PaymentMethod paymentMethod = PaymentMethod();
  late HaveDiscount haveDiscount;

  TextEditingController noteController = TextEditingController();
  TextEditingController noPeopleController = TextEditingController();
  TextEditingController noOfTableController = TextEditingController();
  TextEditingController noCarController = TextEditingController();
  TextEditingController carColorController = TextEditingController();
  TextEditingController couponController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  String? dropVal;

  @override
  Widget build(BuildContext context) {
    haveDiscount = HaveDiscount(couponController);
    return Scaffold(
      body: BlocConsumer<FastCubit, FastStates>(
        listener: (c, s) {
          if (s is CreateOrderSuccessState) {

          }
        },
        builder: (context, state) {
          var cubit = FastCubit.get(context);
          return InkWell(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Column(
              children: [
                DefaultAppBar(tr('checkout'),),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CheckOutListItem(),
                          selectServiceType,
                          // if(selectServiceType.currentIndex==2)pickTime,
                          if (selectServiceType.currentIndex == 3)
                            SizedBox(
                              height: 10,
                            ),
                          if (selectServiceType.currentIndex == 3)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  // Image.asset(Images.calendar,width: 16,height: 16,),
                                  // const SizedBox(width: 3,),
                                  AutoSizeText(
                                    // '${tr('reservation')} ${DateFormat.yMEd().add_jms().format(pickTime.dateTime)}'
                                    '${tr('Dine_In_Time')}',
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          // if(selectServiceType.currentIndex==2)pickUp,

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                            child: Column(
                              children: [
                                if (selectServiceType.currentIndex == 1)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: AutoSizeText(
                                          tr("Select_Address"),
                                          minFontSize: 8,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (selectServiceType.currentIndex == 1) addressList(context),
                                // if(selectServiceType.currentIndex==2)
                                // if(pickUp.currentIndex ==0)
                                // DefaultForm(
                                //   hint: tr('car_number'),
                                //   controller: noCarController,
                                //   onChange: (s){
                                //     formKey.currentState!.validate();
                                //   },
                                //   validator: (str){
                                //     if(str.isEmpty)return tr('car_number_empty');
                                //     return null;
                                //   },
                                // ),

                                if (selectServiceType.currentIndex == 3)
                                  DefaultForm(
                                    hint: tr('number_of_people'),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9!@#$%^&*(),.?":{}|<>+|-]')),
                                    ],
                                    onChange: (s) {
                                      formKey.currentState!.validate();
                                    },
                                    type: TextInputType.number,
                                    controller: noPeopleController,
                                    // validator: (str) {
                                    //   if (str.isEmpty) return tr('number_of_people_empty');
                                    //   return null;
                                    // },
                                  ),
                                // if(selectServiceType.currentIndex==2)
                                //   const SizedBox(height: 20,),
                                if (selectServiceType.currentIndex == 3)
                                  const SizedBox(
                                    height: 20,
                                  ),
                                if (selectServiceType.currentIndex == 3)
                                  DefaultForm(
                                    hint: tr('number_of_table'),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9!@#$%^&*(),.?":{}|<>+|-]')),
                                    ],
                                    onChange: (s) {
                                      formKey.currentState!.validate();
                                    },
                                    type: TextInputType.number,
                                    controller: noOfTableController,
                                    validator: (str) {
                                      if (str.isEmpty) return tr('number_of_table_empty');
                                      return null;
                                    },
                                  ),
                                // if(selectServiceType.currentIndex==3)
                                //  const SizedBox(height: 20,),
                                // if(selectServiceType.currentIndex==2)
                                //   if(pickUp.currentIndex ==0)
                                //   DefaultForm(
                                //   hint: tr('color_of_car'),
                                //     controller: carColorController,
                                //     onChange: (s){
                                //       formKey.currentState!.validate();
                                //     },
                                //     validator: (str){
                                //       if(str.isEmpty)return tr('color_of_car_empty');
                                //       return null;
                                //     },
                                // ),
                                if (pickUp.currentIndex == 0)
                                  const SizedBox(
                                    height: 20,
                                  ),
                                if(selectServiceType.currentIndex !=1)
                                DefaultForm(
                                  hint: tr('note'),
                                  maxLines: 3,
                                  controller: noteController,
                                ),
                                // if(selectServiceType.currentIndex!=1)
                                //   const SizedBox(height: 20,),
                                // if(selectServiceType.currentIndex!=1)
                                // DropdownButtonFormField(
                                //     items: [
                                //       DropdownMenuItem(
                                //           child: Text(
                                //             tr('breakfast'),
                                //           ),
                                //         value: 'breakfast',
                                //       ),
                                //       DropdownMenuItem(
                                //           child: Text(
                                //             tr('lunch'),
                                //           ),
                                //         value: 'lunch',
                                //       ),
                                //       DropdownMenuItem(
                                //           child: Text(
                                //             tr('dinner'),
                                //           ),
                                //         value: 'dinner',
                                //       ),
                                //     ],
                                //     decoration: InputDecoration(
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.all(Radius.circular(15)),
                                //         borderSide: BorderSide(color: Colors.grey)
                                //       ),
                                //       enabledBorder: OutlineInputBorder(
                                //           borderRadius: BorderRadius.all(Radius.circular(15)),
                                //           borderSide: BorderSide(color: Colors.grey)
                                //       ),
                                //     ),
                                //     hint: Text(tr('breakfast')),
                                //     value:dropVal,
                                //     onChanged: (String? string){
                                //       dropVal = string;
                                //     }
                                // )
                              ],
                            ),
                          ),
                          paymentMethod,
                          Text("${cubit.couponModel?.data?.discountType??" "}"),
                          if (cubit.couponModel == null) haveDiscount,
                          Invoice(
                            selectServiceType: getServiceTypeIndex(),
                            delivery: cubit.cartModel?.data?.invoiceSummary?.shippingCharges ?? '',
                            discount: cubit.couponModel?.data?.discountValue,
                            discountType: cubit.couponModel?.data?.discountType,
                            tax: cubit.cartModel?.data?.invoiceSummary?.vatValue ?? '',
                            subtotal: cubit.cartModel?.data?.invoiceSummary?.subTotalPrice ?? '',
                            // appFee: cubit.cartModel?.data?.data?.invoiceSummary?.appFees ?? '',
                            total: cubit.couponModel != null
                                ? cubit.couponModel?.data?.discountType == 1
                                    ? int.tryParse(cubit.cartModel!.data!.invoiceSummary!.totalPrice!)! -
                                        (int.tryParse(cubit.cartModel!.data!.invoiceSummary!.totalPrice!)! / cubit.couponModel!.data!.discountValue!).round()
                                    : (int.tryParse(cubit.cartModel!.data!.invoiceSummary!.totalPrice!)! - cubit.couponModel!.data!.discountValue!)
                                : cubit.cartModel?.data?.invoiceSummary?.totalPrice ?? '',
                          ),
                          ConditionalBuilder(
                            condition: state is! CreateOrderLoadingState,
                            fallback: (c) => Center(
                              child: CupertinoActivityIndicator(),
                            ),
                            builder: (c) => DefaultButton(
                              onTap: () {
                                // if (formKey.currentState!.validate()) {
                                print("CacheHelper.getData  ");
                                print(CacheHelper.getData(key: "lat",  ));
                                  if(selectServiceType.currentIndex==1 && (CacheHelper.getData(key: "lat",  ) ==null)){
                                    showToast(msg: tr('pleaseSelectAddressFirst'),toastState: false);
                                    return;
                                  }
                                  if(selectServiceType.currentIndex==3 &&(noOfTableController.text.isEmpty)){
                                    showToast(msg: tr('Please_the_table_number_must_not_be_empty'),toastState: false);
                                    return;
                                  }
                                  FastCubit.get(context).createOrder(
                                      date:
                                          '${pickTime.dateTime.month}-${pickTime.dateTime.day}-${pickTime.dateTime.year} ${pickTime.dateTime.hour}:${pickTime.dateTime.minute}:${pickTime.dateTime.second}',
                                      paymentMethod: paymentMethod.method,
                                      serviceType: getServiceTypeIndex(),
                                      couponCode: haveDiscount.controller.text.isNotEmpty ? haveDiscount.controller.text : null,
                                      // colorOfCar: carColorController.text.isNotEmpty ? carColorController.text : null,
                                      noOfPeople: noPeopleController.text.isNotEmpty ? noPeopleController.text : null,
                                      noOfTable: noOfTableController.text.isNotEmpty ? noOfTableController.text : null,
                                      additionalNotes: noteController.text.isNotEmpty ? noteController.text : null,
                                      // noOfCar: noCarController.text.isNotEmpty ? noCarController.text : null
                                      // foodType: dropVal != null
                                      //     ? 1
                                      //     : dropVal == 'breakfast'
                                      //         ? 1
                                      //         : dropVal == 'lunch'
                                      //             ? 2
                                      //             : 3
                                      );
                                // } else {
                                //   print('hi');
                                // }
                              },
                              text: tr('place_order'),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  int getServiceTypeIndex() {
    int? index;
    if(selectServiceType.currentIndex==1){
      index=3;
    }
    if(selectServiceType.currentIndex==2){
      index=1;
    }
    if(selectServiceType.currentIndex==3){
      index=2;
    }
    return index!;
  }
  Widget addressList(context) {
    return Column(
      children: [
        AddressesList(isCheckout: true),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: DefaultButton(
            height: 50,
            onTap: (){
               navigateTo(context, AddNewAddressScreen());
            },
            text: tr('Add_New_Address'),
          ),
        ),
      ],
    );
  }
}
