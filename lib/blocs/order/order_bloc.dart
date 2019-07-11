import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/blocs/order/order_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/order_builder/order_builder.dart';
import 'package:pressy_client/utils/errors/base_error.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IOrderDataSource orderDataSource;
  final IMemberDataSource memberDataSource;

  OrderBloc({@required this.orderDataSource, @required this.memberDataSource});

  @override
  OrderState get initialState => OrderState(
        orderRequestBuilder: OrderRequestBuilder(),
        deliverySlotState: OrderSlotLoadingState(),
        pickupSlotState: OrderSlotLoadingState(),
        addressState: OrderAddressLoadingState(),
        paymentAccountState: OrderPaymentAccountLoadingState(),
      );

  @override
  Stream<OrderState> mapEventToState(
      OrderState currentState, OrderEvent event) async* {
    if (event is FetchOrderDataEvent) {
      List<Slot> pickupSlots = await this.orderDataSource.getPickupSlots();

      yield currentState.copyWith(
          pickupSlotState: OrderSlotReadyState(
              slots: pickupSlots, canMoveForward: pickupSlots.isNotEmpty));
    }

    if (event is GoToNextStepEvent || event is GoToPreviousStepEvent) {
      var state;
      if (event is GoToPreviousStepEvent) {
        state = currentState.copyWith(step: currentState.step - 1);
      } else {
        state = currentState.copyWith(step: currentState.step + 1);
      }
      yield state;
      switch (state.step) {
        case 1:
          state = state.copyWith(deliverySlotState: OrderSlotLoadingState());
          yield state;
          final deliverySlots = await this
              .orderDataSource
              .getDeliverySlots(state.orderRequestBuilder.pickupSlot);
          yield state.copyWith(
              deliverySlotState: OrderSlotReadyState(
                  slots: deliverySlots,
                  canMoveForward: deliverySlots.isNotEmpty));
          break;
        case 2:
          state = state.copyWith(articleState: ArticlesLoadingState());
          yield state;
          final articles = await this.orderDataSource.getArticles();
          final weightedArticle =
              await this.orderDataSource.getWeightedArticle();
          yield state.copyWith(
              articleState: ArticlesReadyState(
                  articles: articles, weightedArticle: weightedArticle));
          break;
        case 3:
          state = state.copyWith(addressState: OrderAddressLoadingState());
          yield state;
          final addresses = await this.memberDataSource.getMemberAddresses();
          yield state.copyWith(
              addressState: OrderAddressReadyState(addresses: addresses));
          break;
        case 4:
          state = state.copyWith(
              paymentAccountState: OrderPaymentAccountLoadingState());
          yield state;
          final memberProfile = await this.memberDataSource.getMemberProfile();
          yield state.copyWith(
              paymentAccountState: OrderPaymentAccountReadyState(
                  paymentAccounts: memberProfile.paymentAccounts));
          break;
        default:
          break;
      }
    }

    if (event is SelectOrderTypeEvent) {
      currentState.orderRequestBuilder.setOrderType(event.orderType);
      currentState.orderRequestBuilder.setEstimatedPrice(event.estimatedPrice);
    }

    if (event is SelectPickupSlotEvent) {
      currentState.orderRequestBuilder.setPickupSlot(event.pickupSlot);
    }

    if (event is SelectDeliverySlotEvent) {
      currentState.orderRequestBuilder.setDeliverySlot(Slot(
          id: event.deliverySlot.id,
          startDate: event.deliverySlot.startDate,
          type: currentState.orderRequestBuilder.pickupSlot.type));
    }

    if (event is SelectAddressEvent) {
      currentState.orderRequestBuilder.setAddress(event.address);
    }

    if (event is SelectPaymentAccountEvent) {
      currentState.orderRequestBuilder.setPaymentAccount(event.paymentAccount);
    }

    if (event is ConfirmOrderEvent) {
      var state = currentState.copyWith(isLoading: true);
      yield state;
      final orderRequest = state.orderRequestBuilder.build();
      try {
        await this.orderDataSource.submitOrder(orderRequest);
        yield state.copyWith(success: true);
      } on AppError catch (error) {
        state = state.copyWith(isLoading: false, error: error);
      } catch (exception) {
        print(exception);
      }
    }
    if (event is SaveCouponInOrderStateEvent) {
      yield currentState.copyWith(
          isCouponValid: event.isCouponValid,
          coupon: event.coupon,
          category: event.category);
    }
  }
}
