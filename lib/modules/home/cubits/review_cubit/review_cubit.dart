import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/uti.dart';
import '../../data/repository/product_repository.dart';
import 'review_state.dart';


class ReviewCubit extends Cubit<ReviewState>  {
  ReviewCubit() : super(ReviewInitial()) ;

  static ReviewCubit get(BuildContext context) => BlocProvider.of(context);


    final ProductRepository _repo = ProductImplement();
 



  /// add review to product
  Future<void> addReviewToProvider(
      {required String providerId ,required context,required content,required int rate}
      ) async {
    emit(AddReviewToProviderLoadState());

    final res = await _repo.addReviewToProvider(providerId: providerId ,content:content,rate:rate);
    res.fold(
          (l) {
        UTI.showSnackBar( context, l.message, 'error');


        emit(AddReviewToProviderErrorState());
      },
          (r) {
        if(r.status ==true) {

          UTI.showSnackBar(context, r.message, 'success');


          emit(AddReviewToProviderSuccessState());

        }


      },
    );
  }



}



