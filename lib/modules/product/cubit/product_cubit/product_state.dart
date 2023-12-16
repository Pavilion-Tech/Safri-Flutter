
import 'package:flutter/material.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}



//Product
class ProductLoadState extends ProductState {}
class ProductSuccessState extends ProductState {}
class ProductErrorState extends ProductState {}











