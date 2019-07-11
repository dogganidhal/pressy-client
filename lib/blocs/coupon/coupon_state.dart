import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/coupon_builder/coupon_builder.dart';
import 'package:pressy_client/utils/errors/base_error.dart';

//class CouponState extends Equatable {
//  final CouponRequestBuilder couponRequestBuilder;
//  final CouponSuccessState couponSuccessState;
//  final CouponFailureState couponFailureState;
//  final CouponLoadingState couponLoadingState;
//  final bool isLoading;
//  final bool success;
//  final AppError error;
//  final bool isValid;
//
//  CouponState(
//      {@required this.couponRequestBuilder,
//      this.isLoading = false,
//      this.success = false,
//      this.isValid,
//      this.error})
//      : super([CouponRequestBuilder, isLoading, success]);
//
//  CouponState copyWith(
//          {CouponRequestBuilder couponRequestBuilder,
//          int step,
//          bool isLoading,
//          bool success,
//          bool isValid,
//          AppError error}) =>
//      CouponState(
//          couponRequestBuilder:
//              couponRequestBuilder ?? this.couponRequestBuilder,
//          isLoading: isLoading ?? this.isLoading,
//          success: success ?? this.success,
//          isValid: isValid ?? this.isValid,
//          error: error ?? this.error);
//}
@immutable
abstract class CouponState extends Equatable {
  CouponState([List props]) : super(props);
}

@immutable
class CouponSuccessState extends CouponState {
  final bool isValid;
  final Coupon coupon;
  final String category;
  CouponSuccessState(
      {@required this.isValid, @required this.coupon, @required this.category})
      : super([isValid, coupon, category]);
  @override
  String toString() => "Coupon redeemed successfully";
}

@immutable
class CouponFailureState extends CouponState {
  final AppError error;

  CouponFailureState({this.error});

  @override
  String toString() => "Coupon failed state: $error";
}

@immutable
class CouponLoadingState extends CouponState {
  @override
  String toString() => "Coupon loading state";
}

@immutable
class CouponInitialState extends CouponState {
  @override
  String toString() => "Initial State";
}
