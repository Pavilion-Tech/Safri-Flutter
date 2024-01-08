import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/uti.dart';
import '../../../shared/images/images.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/shimmer/notification_shimmer.dart';
import '../add_new_address_screen.dart';
import '../cubit/address_cubit/address_cubit.dart';
import '../cubit/address_cubit/address_state.dart';
import '../data/request/update_address_request.dart';

class AddressesList extends StatefulWidget {
  final bool isCheckout;
  const AddressesList({Key? key,   this.isCheckout=false}) : super(key: key);

  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddressCubit.get(context).getAddresses();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is SetDefaultAddressLoadState) {
          UTI.showProgressIndicator(context);
        }
        if (state is SetDefaultAddressErrorState) {
          Navigator.pop(context);
        }
        if (state is SetDefaultAddressSuccessState) {
          Navigator.pop(context);
        }

        if (state is DeleteAddressLoadState) {
          UTI.showProgressIndicator(context);
        }
        if (state is DeleteAddressErrorState) {
          Navigator.pop(context);
        }
        if (state is DeleteAddressSuccessState) {
          Navigator.pop(context);
          AddressCubit.get(context).addressesData.clear();
          AddressCubit.get(context).getAddresses();



        }
      },
      builder: (context, state) {
        var addressesCubit = AddressCubit.get(context);
        if (addressesCubit.addressesData.isEmpty && state is AddressesLoadState) {
          return const NotificationShimmer();
          // return Center(child: UTI.loadingWidget(),);
        }
        if (addressesCubit.addressesData.isEmpty && state is AddressesSuccessState) {
          return widget.isCheckout==true?Container(): Column(
            children: [
              const SizedBox(
                height:  50,
              ),
              UTI.dataEmptyWidget(noData: tr("noDataFounded"), imageName: Images.productNotFound),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  navigateTo(context, AddNewAddressScreen(updateAddressRequest: UpdateAddressRequest(),));
                  // Navigator.pushNamed(context, Routes.addNewAddressScreen, arguments: UpdateAddressRequest());
                },
                child: Container(
                  padding: const EdgeInsets.all( 20),
                  margin: const EdgeInsets.symmetric(horizontal:  20),
                  decoration: BoxDecoration(
                    color: defaultColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr("Addresses"),
                        style: TextStyle(fontSize:  16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(
                        width:  10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color:  Colors.white,
                          shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                            child: Icon(
                              Icons.add,
                              color: defaultColor,
                              size: 12,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        if (state is AddressesErrorState) {
          return UTI.dataEmptyWidget(noData:  tr("noDataFounded"), imageName: Images.productNotFound);
        }
        return  ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics:widget.isCheckout==true? const NeverScrollableScrollPhysics():ScrollPhysics(),
            itemBuilder: (context, index) {

              return addressesItem(context, addressesCubit, index);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: addressesCubit.addressesData.length);
      },

    );
  }
  Widget addressesItem(BuildContext context, AddressCubit addressesCubit, int index) {
    return  Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Color(0xffB3B3B3).withOpacity(0.3)
          ),
        ),
        GestureDetector(
          onTap: () {
            AddressCubit.get(context).setDefaultAddress(addressId: addressesCubit.addressesData[index].id.toString(), context: context,
                addressesData: addressesCubit.addressesData[index]);

          },
          child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal:   20, vertical:  10),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffB3B3B3).withOpacity(0.3),
                  border: addressesCubit.addressesData[index].isDefault == true
                      ? Border.all(
                    color: defaultColor, // Set the border color here
                    width: 1, // Set the border width here
                  )
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            addressesCubit.addressesData[index].title ?? "",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff3B3B3B)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Images.location1,color: Color(0xffEF7F18),),
                              SizedBox(
                                width: 3,
                              ),
                              Expanded(
                                child: AutoSizeText(
                                  addressesCubit.addressesData[index].address ?? "",
                                  maxLines: 3,
                                  minFontSize: 10,
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff5C5C5C)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          InkWell(
                              onTap: () {
                                AddressCubit.get(context).deleteAddress(addressId: addressesCubit.addressesData[index].id.toString(), context: context);

                              },
                              child: Image.asset(Images.bin,width: 20,height: 20,)
                          ),
                          const SizedBox(height: 20,),
                          InkWell(
                              onTap: () {
                                navigateTo(context, AddNewAddressScreen(updateAddressRequest:  UpdateAddressRequest(
                                  addressId: addressesCubit.addressesData[index].id.toString(),
                                  addressDetails: addressesCubit.addressesData[index].address.toString(),
                                  latitude: addressesCubit.addressesData[index].latitude.toString(),
                                  longitude: addressesCubit.addressesData[index].longitude.toString(),
                                  title: addressesCubit.addressesData[index].title.toString(),
                                )));

                              },
                              child: SvgPicture.asset(Images.edit,color: defaultColor,)),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
