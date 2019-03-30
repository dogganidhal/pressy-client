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

      yield currentState.copyWith(
        pickupSlotState: new OrderSlotReadyState(
          slots: pickupSlots,
          canMoveForward: pickupSlots.isNotEmpty
        )
      );
      if (pickupSlots.isNotEmpty)
        currentState.orderRequestBuilder.setPickupSlot(pickupSlots[0]);

    }

    if (event is GoToNextStepEvent) {
      var state = currentState.copyWith(step: currentState.step + 1);
      yield state;
      switch(state.step) {
        case 1:
          state = state.copyWith(
            deliverySlotState: new OrderSlotLoadingState()
          );
          yield state;
          final deliverySlots = await this.orderDataSource.getDeliverySlots(state.orderRequestBuilder.pickupSlot);
          yield state.copyWith(
            deliverySlotState: new OrderSlotReadyState(
              slots: deliverySlots,
              canMoveForward: deliverySlots.isNotEmpty
            )
          );
          if (deliverySlots.isNotEmpty)
            currentState.orderRequestBuilder.setPickupSlot(deliverySlots[0]);
          break;
        case 2:
            state = state.copyWith(
              articleState: new ArticlesLoadingState()
            );
            yield state;
            final articles = await this.orderDataSource.getArticles();
            final weightedArticle = await this.orderDataSource.getWeightedArticle();
            yield state.copyWith(
              articleState: new ArticlesReadyState(
                articles: articles,
                weightedArticle: weightedArticle
              )
            );
            break;
        case 3:
          state = state.copyWith(
            addressState: new OrderAddressLoadingState()
          );
          yield state;
          final addresses = await this.memberDataSource.getMemberAddresses();
          yield state.copyWith(
            addressState: new OrderAddressReadyState(
              addresses: addresses
            )
          );
          break;
        case 4:
          state = state.copyWith(
            paymentAccountState: new OrderPaymentAccountLoadingState()
          );
          yield state;
          final memberProfile = await this.memberDataSource.getMemberProfile();
          yield state.copyWith(
            paymentAccountState: new OrderPaymentAccountReadyState(
              paymentAccounts: memberProfile.paymentAccounts
            )
          );
          break;
        default: break;
      }
    }

    if (event is SelectPickupSlotEvent) {
      currentState.orderRequestBuilder.setPickupSlot(event.pickupSlot);
    }

    if (event is SelectDeliverySlotEvent) {
      currentState.orderRequestBuilder.setDeliverySlot(event.deliverySlot);
    }

    if (event is SelectAddressEvent) {
      currentState.orderRequestBuilder.setAddress(event.address);
    }

    if (event is SelectPaymentAccountEvent) {
      currentState.orderRequestBuilder.setPaymentAccount(event.paymentAccount);
    }

  }

}