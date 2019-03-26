import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/order_builder/order_builder.dart';

class OrderState extends Equatable {
  
  final OrderRequestBuilder orderRequestBuilder;
  final OrderSlotState pickupSlotState;
  final OrderSlotState deliverySlotState;
  final OrderAddressState addressState;
  final OrderPaymentAccountState paymentAccountState;
  final int step;

  OrderState({
    @required this.orderRequestBuilder,
    this.pickupSlotState,
    this.deliverySlotState,
    this.paymentAccountState,
    this.addressState,
    this.step = 0
  }) : super([
    orderRequestBuilder, pickupSlotState, deliverySlotState,
    paymentAccountState, addressState, step
  ]);

  OrderState copyWith({
    OrderRequestBuilder orderRequestBuilder,
    OrderSlotState pickupSlotState,
    OrderSlotState deliverySlotState,
    OrderAddressState addressState,
    OrderPaymentAccountState paymentAccountState,
    int step
  }) => new OrderState(
    orderRequestBuilder: orderRequestBuilder ?? this.orderRequestBuilder,
    pickupSlotState: pickupSlotState ?? this.pickupSlotState,
    deliverySlotState: deliverySlotState ?? this.deliverySlotState,
    paymentAccountState: paymentAccountState ?? this.paymentAccountState,
    addressState: addressState ?? this.addressState,
    step: step ?? this.step
  );
  
}

abstract class OrderAddressState extends Equatable {
  OrderAddressState([List props]) : super(props);
}

abstract class OrderPaymentAccountState extends Equatable {
  OrderPaymentAccountState([List props]) : super(props);
}

abstract class OrderSlotState extends Equatable {
  OrderSlotState([List props]) : super(props);
}

class OrderAddressLoadingState extends OrderAddressState { }

class OrderPaymentAccountLoadingState extends OrderPaymentAccountState { }

class OrderSlotLoadingState extends OrderSlotState { }

class OrderPaymentAccountReadyState extends OrderPaymentAccountState {
  
  final List<PaymentAccount> paymentAccounts;

  OrderPaymentAccountReadyState({this.paymentAccounts}) : super([paymentAccounts]);
  
}

class OrderAddressReadyState extends OrderAddressState {
  
  final List<MemberAddress> addresses;

  OrderAddressReadyState({this.addresses}) : super([addresses]);
  
}

class OrderSlotReadyState extends OrderSlotState {
  
  final List<Slot> slots;

  OrderSlotReadyState({this.slots}) : super([slots]);

}