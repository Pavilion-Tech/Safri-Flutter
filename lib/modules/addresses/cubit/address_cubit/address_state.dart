
import 'package:flutter/material.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}



//Address
class AddressesLoadState extends AddressState {}
class AddressesSuccessState extends AddressState {}
class AddressesErrorState extends AddressState {}

//add Address
class AddOrUpdateAddressLoadState extends AddressState {}
class AddOrUpdateAddressSuccessState extends AddressState {}
class AddOrUpdateAddressErrorState extends AddressState {}

//add Address
class SetDefaultAddressLoadState extends AddressState {}
class SetDefaultAddressSuccessState extends AddressState {}
class SetDefaultAddressErrorState extends AddressState {}

//delete Address
class DeleteAddressLoadState extends AddressState {}
class DeleteAddressSuccessState extends AddressState {}
class DeleteAddressErrorState extends AddressState {}









