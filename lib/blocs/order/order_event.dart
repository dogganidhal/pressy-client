import 'package:equatable/equatable.dart';
import 'package:pressy_client/data/model/model.dart';

abstract class OrderEvent extends Equatable {
  OrderEvent([List props]) : super (props);
}


class FetchOrderDataEvent extends OrderEvent { }

class GoToNextStepEvent extends OrderEvent { }

class SelectPickupSlotEvent extends OrderEvent {
  
  final Slot pickupSlot;

  SelectPickupSlotEvent(this.pickupSlot);
  
}

class SelectDeliverySlotEvent extends OrderEvent {

  final Slot deliverySlot;

  SelectDeliverySlotEvent(this.deliverySlot);

}