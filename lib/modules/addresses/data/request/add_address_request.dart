


class AddAddressRequest {



  String latitude;
  String longitude;
  String? title;






  AddAddressRequest({required this.latitude,required   this.longitude,required this.title,   });

   toRequest() {
     return {

     'latitude':   latitude,
     'longitude': longitude,
    'title': title,



  };
   }


}