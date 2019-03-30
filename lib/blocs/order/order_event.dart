import 'package:equatable/equatable.dart';
import 'package:pressy_client/data/model/model.dart';

abstract class OrderEvent extends Equatable {
  OrderEvent([List props]) : super (props);
}


class FetchOrderDataEvent extends OrderEvent { }

class GoToNextStepEvent extends OrderEvent { }

class SelectPickupSlotEvent extends OrderEvent {
  
  final Slot pickupSlot;

  SelectPickupSlotEvent(this.pickupSlot) : super([pickupSlot]);
  
}

class SelectDeliverySlotEvent extends OrderEvent {

  final Slot deliverySlot;

  SelectDeliverySlotEvent(this.deliverySlot) : super([deliverySlot]);

}

class SelectAddressEvent extends OrderEvent {

  final MemberAddress address;

  SelectAddressEvent(this.address) : super([address]);

}

class SelectPaymentAccountEvent extends OrderEvent {

  final PaymentAccount paymentAccount;

  SelectPaymentAccountEvent(this.paymentAccount) : super([paymentAccount]);

}