import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safri/shared/network/local/cache_helper.dart';
 import '../../../../main.dart';
import '../../../../shared/components/uti.dart';
import '../../data/repository/address_repository.dart';
import '../../data/request/add_address_request.dart';
import '../../data/request/update_address_request.dart';
import '../../data/response/addresses_response.dart';
import 'address_state.dart';


class AddressCubit extends Cubit<AddressState>  {
  AddressCubit() : super(AddressInitial()) ;

  static AddressCubit get(BuildContext context) => BlocProvider.of(context);


    final AddressRepository _repo = AddressImplement();







  /// add address
  List<AddressesData>  addressesData=[] ;

  Future<void> getAddresses() async {
    emit(AddressesLoadState());

    final res = await _repo.getAddresses();
    res.fold(
          (l) {
        emit(AddressesErrorState());
      },
          (r) {
            if(r.status ==true) {
            if(r.data != null) {
              addressesData=r.data!;

            }
            addressesData.forEach((element) {
              if(element.isDefault==true){
                CacheHelper.saveData(key: 'lat',value:element.latitude??"" );
                CacheHelper.saveData(key: 'long',value: element.longitude??"" );
              }
            });


              emit(AddressesSuccessState());
            if(addressesData.isEmpty){
              CacheHelper.removeData('lat');
              CacheHelper.removeData('long');
            }

            }


      },
    );
  }
  String? lat;
  String? lang;
  var addressDetailsController=TextEditingController();
  /// add  address
  Future<void> addAddress(
      {required AddAddressRequest addAddressRequest ,required context}
      ) async {
    emit(AddOrUpdateAddressLoadState());

    final res = await _repo.addAddress(addAddressRequest: addAddressRequest, );
    res.fold(
          (l) {
        UTI.showSnackBar(navigatorKey.currentContext, l.message, 'error');


        emit(AddOrUpdateAddressErrorState());
      },
          (r) {
        if(r.status ==true) {

          UTI.showSnackBar(navigatorKey.currentContext, r.message, 'success');

          emit(AddOrUpdateAddressSuccessState());
          getAddresses();
          Navigator.pop(context);

        }


      },
    );
  }

  /// update  address
  Future<void> updateAddress(
      {required UpdateAddressRequest updateAddressRequest ,required String addressId ,required context}
      ) async {
    emit(AddOrUpdateAddressLoadState());

    final res = await _repo.updateAddress(updateAddressRequest: updateAddressRequest,addressId:addressId  );
    res.fold(
          (l) {
        UTI.showSnackBar(navigatorKey.currentContext, l.message, 'error');


        emit(AddOrUpdateAddressErrorState());
      },
          (r) {
        if(r.status ==true) {

          UTI.showSnackBar(navigatorKey.currentContext, r.message, 'success');

          emit(AddOrUpdateAddressSuccessState());
          getAddresses();

        }


      },
    );
  }


  /// delete  address
  Future<void> deleteAddress(
      { required String addressId ,required context}
      ) async {
    emit(DeleteAddressLoadState());

    final res = await _repo.deleteAddress(  addressId:addressId  );
    res.fold(
          (l) {
        UTI.showSnackBar(navigatorKey.currentContext, l.message, 'error');


        emit(DeleteAddressErrorState());
      },
          (r) {
        if(r.status ==true) {

          UTI.showSnackBar(navigatorKey.currentContext, r.message, 'success');

          emit(DeleteAddressSuccessState());
          getAddresses();

        }


      },
    );
  }

  /// set default  address
  Future<void> setDefaultAddress(
      { required String addressId ,required context,required AddressesData addressesData}
      ) async {
    emit(SetDefaultAddressLoadState());

    final res = await _repo.setAddressAsDefault( addressId:addressId  );
    res.fold(
          (l) {
        UTI.showSnackBar(navigatorKey.currentContext, l.message, 'error');


        emit(SetDefaultAddressErrorState());
      },
          (r) {
        if(r.status ==true) {

          UTI.showSnackBar(navigatorKey.currentContext, r.message, 'success');

          emit(SetDefaultAddressSuccessState());
          CacheHelper.saveData(key: "lat", value: addressesData.latitude.toString());
          CacheHelper.saveData(key: "long", value: addressesData.longitude.toString());
          print("latitude");
          print(    CacheHelper.getData(key: "long",  ));
          print(    CacheHelper.getData(key: "lat",  ));
          getAddresses();

        }


      },
    );
  }






}


