import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../models/provider_category_model.dart';
import '../../data/repository/fav_providers_repository.dart';
import 'fav_provider_state.dart';


class FavoriteProvidersCubit extends Cubit<FavoriteProvidersState>  {
  FavoriteProvidersCubit() : super(FavoriteProvidersInitial()) ;

  static FavoriteProvidersCubit get(BuildContext context) => BlocProvider.of(context);


    final FavoriteProviderRepository _repo = FavoriteProviderImplement();







  /// get all
  List<ProviderData>  providerFavData=[] ;

  Future<void> getFavoriteProviders( ) async {
    emit(FavoriteProvidersLoadState());

    final res = await _repo.getFavoriteProviders();
    res.fold(
          (l) {
        emit(FavoriteProvidersErrorState());
      },
          (r) {
            if(r.status ==true) {
            if(r.data != null) {
              providerFavData=r.data?.data??[];
            }

              emit(FavoriteProvidersSuccessState());

            }


      },
    );
  }










}


