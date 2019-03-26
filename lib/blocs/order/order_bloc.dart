import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/blocs/order/order_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/order_builder/order_builder.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {

  final IOrderDataSource orderDataSource;
  final IMemberDataSource memberDataSource;

  OrderBloc({@required this.orderDataSource, @required this.memberDataSource});
  
  @override
  OrderState get initialState => new OrderState(
    orderRequestBuilder: new OrderRequestBuilder(),
    deliverySlotState: new OrderSlotLoadingState(),
    pickupSlotState: new OrderSlotLoadingState(),
    addressState: new OrderAddressLoadingState(),
    paymentAccountState: new OrderPaymentAccountLoadingState()
  );

  @override
  Stream<OrderState> mapEventToState(OrderState currentState, OrderEvent event) async* {

    if (event is FetchOrderDataEvent) {

      List<Slot> pickupSlots = await this.orderDataSource.getPickupSlots();
      List<Article> allArticles = await this.orderDataSource.getArticles();

      yield currentState.copyWith(
        pickupSlotState: new OrderSlotReadyState(slots: pickupSlots)
      );

    }

    if (event is GoToNextStepEvent) {
      yield currentState.copyWith(step: currentState.step + 1);
    }

    if (event is SelectPickupSlotEvent) {
      currentState.orderRequestBuilder.setPickupSlot(event.pickupSlot);
      var state = currentState.copyWith(
          deliverySlotState: new OrderSlotLoadingState()
      );
      yield state;
      final deliverySlots = await this.orderDataSource.getDeliverySlots(event.pickupSlot);
      yield state.copyWith(
        deliverySlotState: new OrderSlotReadyState(
          slots: deliverySlots
        )
      );
    }

    if (event is SelectDeliverySlotEvent) {
      currentState.orderRequestBuilder.setDeliverySlot(event.deliverySlot);
    }

  }

}