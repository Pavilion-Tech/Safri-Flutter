import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/provider_products_model.dart';
import '../../data/repository/product_repository.dart';
import '../../data/response/product_details_response.dart';
import 'product_state.dart';


class ProductCubit extends Cubit<ProductState>  {
  ProductCubit() : super(ProductInitial()) ;

  static ProductCubit get(BuildContext context) => BlocProvider.of(context);


    final ProductRepository _repo =ProductImplement();







  /// get product
  ProductData? productDetails  ;

  Future<void> getProductDetails({required String id}) async {
    emit(ProductLoadState());

    final res = await _repo.getProductDetails(productId: id);
    res.fold(
          (l) {
        emit(ProductErrorState());
      },
          (r) {
            if(r.status ==true) {
            if(r.data != null) {
              productDetails=r.data!;
            }

              emit(ProductSuccessState());

            }


      },
    );
  }








}


