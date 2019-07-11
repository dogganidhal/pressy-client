import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/coupon/coupon_event.dart';
import 'package:pressy_client/blocs/coupon/coupon_state.dart';
import 'package:pressy_client/data/data_source/coupon/coupon_data_source.dart';
import 'package:pressy_client/data/model/order/coupon_builder/coupon_builder.dart';
import 'package:pressy_client/data/model/order/coupon_response/coupon_response.dart';
import 'package:pressy_client/utils/errors/base_error.dart';
import 'package:dio/dio.dart';
import 'package:pressy_client/utils/errors/coupon_invalid.dart';

class CouponBloc extends Bloc<CouponsEvent, CouponState> {
  final ICouponsDataSource couponDataSource;

  CouponBloc({@required this.couponDataSource});
  @override
  CouponState get initialState => CouponInitialState();

  @override
  Stream<CouponState> mapEventToState(
      CouponState currentState, CouponsEvent event) async* {
    if (event is RedeemEvent) {
      yield CouponLoadingState();
      //final couponRequest = state.couponRequestBuilder.build();
      try {
        CouponVerifyResponseModel response =
            await this.couponDataSource.verifyCoupon(event.id);

//        yield state.copyWith(success: true, isValid: response.status);
        yield CouponSuccessState(
            isValid: response.status,
            coupon: response.coupon,
            category: response.category);
      } on AppError catch (error) {
        // state = state.copyWith(isLoading: false, error: error);
        yield CouponFailureState(error: error);
      } on DioError {
        //print(exception);
        yield CouponFailureState(error: InvalidCouponError());
      }
    }
  }
}
