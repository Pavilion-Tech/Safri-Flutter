
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../shared/api/data_source/end_point.dart';
import '../../../../shared/api/shared/shared_methods.dart';
import '../../../../shared/error/error_handler/failure.dart';

import '../response/fav_providers_response.dart';



abstract class FavoriteProviderRepository {


    Future<Either<Failure, AllFavoriteProvidersModel>> getFavoriteProviders( );





}

class FavoriteProviderImplement implements FavoriteProviderRepository {


  @override
  Future<Either<Failure, AllFavoriteProvidersModel>> getFavoriteProviders( )async {
    return await handleResponse(
      endPoint: EndPoints.favoriteProviders,
      asObject: (e) => AllFavoriteProvidersModel.fromJson(e),
      method: DioMethod.get,

      // page: page,

    );
  }





}
