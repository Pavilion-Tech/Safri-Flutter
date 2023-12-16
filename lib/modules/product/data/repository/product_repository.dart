
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../shared/api/data_source/end_point.dart';
import '../../../../shared/api/shared/shared_methods.dart';
import '../../../../shared/error/error_handler/failure.dart';

import '../response/product_details_response.dart';



abstract class ProductRepository {

    Future<Either<Failure,  ProductDetailsResponse>> getProductDetails({ required String productId});




}

class ProductImplement implements ProductRepository {





  @override
  Future<Either<Failure,ProductDetailsResponse>> getProductDetails({ required String productId})async {


    return await handleResponse(
      endPoint: "${EndPoints.productDetails}$productId",
      asObject: (e) => ProductDetailsResponse.fromJson(e),

      method: DioMethod.get
    );
  }



}
