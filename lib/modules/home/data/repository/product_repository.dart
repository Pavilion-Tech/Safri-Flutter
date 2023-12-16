
import 'package:dartz/dartz.dart';

import '../../../../shared/api/data_source/end_point.dart';
import '../../../../shared/api/shared/shared_methods.dart';
import '../../../../shared/error/error_handler/failure.dart';

import '../response/add_review_to_product_response.dart';




abstract class ProductRepository {



    Future<Either<Failure,  AddReviewToProductResponse>> addReviewToProvider({ required String providerId, required String content, required int rate,});




}

class ProductImplement implements ProductRepository {




  @override
  Future<Either<Failure,AddReviewToProductResponse>> addReviewToProvider({ required String providerId, required String content, required int rate,})async {


    return await handleResponse(
      endPoint: EndPoints.addReviewToProduct,
      asObject: (e) => AddReviewToProductResponse.fromJson(e),

      method: DioMethod.post,
      data: {
        "provider_id":providerId,
        "review_rate":rate,
        "review_content":content,
      }

    );
  }



}
