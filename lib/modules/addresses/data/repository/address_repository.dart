
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../shared/api/data_source/end_point.dart';
import '../../../../shared/api/shared/shared_methods.dart';
import '../../../../shared/error/error_handler/failure.dart';
import '../request/add_address_request.dart';
import '../request/update_address_request.dart';
import '../response/add_or_update_address_response.dart';
import '../response/addresses_response.dart';



abstract class AddressRepository {

    Future<Either<Failure, AddOrUpdateAddressResponse>> addAddress({required AddAddressRequest addAddressRequest } );
    Future<Either<Failure, AddressesResponse>> getAddresses( );
    Future<Either<Failure,  AddOrUpdateAddressResponse>> updateAddress({required UpdateAddressRequest updateAddressRequest ,required String addressId});
    Future<Either<Failure,  AddOrUpdateAddressResponse>> setAddressAsDefault({ required String addressId});
    Future<Either<Failure,  AddOrUpdateAddressResponse>> deleteAddress({ required String addressId});




}

class AddressImplement implements AddressRepository {


  @override
  Future<Either<Failure, AddressesResponse>> getAddresses(  )async {
    return await handleResponse(
      endPoint: EndPoints.getAddresses,
      asObject: (e) => AddressesResponse.fromJson(e),
      method: DioMethod.get,

      // page: page,

    );
  }

  @override
  Future<Either<Failure, AddOrUpdateAddressResponse>> addAddress({required AddAddressRequest addAddressRequest })async {
    Map<String, dynamic> req = await addAddressRequest.toRequest();

    req.removeWhere((key, value) => value == null);

    return await handleResponse(
      endPoint: EndPoints.addAddress,
      asObject: (e) => AddOrUpdateAddressResponse.fromJson(e),
      data: FormData.fromMap(req),
      method: DioMethod.post,
    );
  }
  @override
  Future<Either<Failure, AddOrUpdateAddressResponse>> updateAddress({required UpdateAddressRequest updateAddressRequest ,required String addressId})async {
    Map<String, dynamic> req = await updateAddressRequest.toRequest();

    req.removeWhere((key, value) => value == null);

    return await handleResponse(
      endPoint: "${EndPoints.updateAddress}$addressId",
      asObject: (e) => AddOrUpdateAddressResponse.fromJson(e),
      data: FormData.fromMap(req),
      method: DioMethod.put,
    );
  }

  @override
  Future<Either<Failure,AddOrUpdateAddressResponse>> setAddressAsDefault({ required String addressId})async {


    return await handleResponse(
      endPoint: "${EndPoints.setDefaultAddress}$addressId",
      asObject: (e) => AddOrUpdateAddressResponse.fromJson(e),

      method: DioMethod.put,
    );
  }


  @override
  Future<Either<Failure,AddOrUpdateAddressResponse>> deleteAddress({ required String addressId})async {


    return await handleResponse(
      endPoint: "${EndPoints.deleteAddress}$addressId",
      asObject: (e) => AddOrUpdateAddressResponse.fromJson(e),

      method: DioMethod.delete
    );
  }



}
