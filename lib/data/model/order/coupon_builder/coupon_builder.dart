import 'package:pressy_client/data/model/order/coupon_request/coupon_request.dart';

class CouponRequestBuilder {
  String _id;
  String get id => this._id;

  CouponRequestBuilder setId(String id) {
    this._id = id;
    return this;
  }

  CouponVerifyRequestModel build() {
    return CouponVerifyRequestModel(
      id: this._id,
    );
  }
}
