import 'package:pressy_client/data/model/model.dart';


class OrderRequestBuilder {

  Slot _pickupSlot;
  Slot get pickupSlot => this._pickupSlot;

  Slot _deliverySlot;
  Slot get deliverySlot => this._deliverySlot;

  MemberAddress _address;
  MemberAddress get address => this._address;

  PaymentAccount _paymentAccount;
  PaymentAccount get paymentAccount => this._paymentAccount;
  
  OrderType _orderType;
  OrderType get orderType => this._orderType;

  double _estimatedPrice;
  double get estimatedPrice => this._estimatedPrice;

  OrderRequestBuilder setPickupSlot(Slot slot) {
    this._pickupSlot = slot;
    return this;
  }

  OrderRequestBuilder setDeliverySlot(Slot slot) {
    this._deliverySlot = slot;
    return this;
  }

  OrderRequestBuilder setAddress(MemberAddress address) {
    this._address = address;
    return this;
  }

  OrderRequestBuilder setPaymentAccount(PaymentAccount paymentAccount) {
    this._paymentAccount = paymentAccount;
    return this;
  }
  
  OrderRequestBuilder setOrderType(OrderType orderType) {
    this._orderType = orderType;
    return this;
  }

  OrderRequestBuilder setEstimatedPrice(double price) {
    this._estimatedPrice = price;
    return this;
  }

  OrderRequestModel build() {
    return OrderRequestModel(
      pickupSlotId: this._pickupSlot.id,
      deliverySlotId: this._deliverySlot.id,
      addressId: this._address.id,
      type: this._orderType.index.toString(),
      paymentAccountId: this._paymentAccount.id
    );
  }

}