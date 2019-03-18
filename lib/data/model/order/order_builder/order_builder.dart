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

  int _type;
  int get type => this._type;

  OrderRequestBuilder setPickupSlot(Slot slot) {
    this._pickupSlot = slot;
    return this;
  }

  OrderRequestBuilder setDeliverySlot(Slot slot) {
    this._deliverySlot = slot;
    return this;
  }

  OrderRequestBuilder setAddressSlot(MemberAddress address) {
    this._address = address;
    return this;
  }

  OrderRequestBuilder setPaymentAccountSlot(PaymentAccount paymentAccount) {
    this._paymentAccount = paymentAccount;
    return this;
  }

  OrderRequestBuilder setOrderType(int type) {
    this._type = type;
    return this;
  }

  OrderRequestModel build() {
    return new OrderRequestModel(
      pickupSlotId: this._pickupSlot.id,
      deliverySlotId: this._deliverySlot.id,
      addressId: this._address.id,
      type: this._type
    );
  }

}