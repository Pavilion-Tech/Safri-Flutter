


class UpdateAddressRequest {



  String? addressId;
  String? latitude;
  String? longitude;
  String? title;
  String? addressDetails;






  UpdateAddressRequest({  this.addressId,    this.latitude,    this.longitude,  this.title,this.addressDetails,   });

   toRequest() {
     return {

     'latitude':   latitude,
     'longitude': longitude,
    'title': title,



  };
   }


}