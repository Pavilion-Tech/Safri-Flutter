
import 'package:flutter/material.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}







//add review to product
class AddReviewToProviderLoadState extends ReviewState {}
class AddReviewToProviderSuccessState extends ReviewState {}
class AddReviewToProviderErrorState extends ReviewState {}