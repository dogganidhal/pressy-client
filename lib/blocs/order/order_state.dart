import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/order_builder/order_builder.dart';
import 'package:pressy_client/utils/errors/base_error.dart';

class OrderState extends Equatable {
  
  final OrderRequestBuilder orderRequestBuilder;
  final OrderSlotState pickupSlotState;
  final OrderSlotState deliverySlotState;
  final ArticleState articleState;
  final OrderAddressState addressState;
  final OrderPaymentAccountState paymentAccountState;
  final int step;
  final bool isLoading;
  final bool success;
  final AppError error;

  OrderState({
    @required this.orderRequestBuilder,
    this.pickupSlotState,
    this.deliverySlotState,
    this.articleState,
    this.paymentAccountState,
    this.addressState,
    this.step = 0,
    this.isLoading = false,
    this.success = false,
    this.error
  }) : super([
    orderRequestBuilder, pickupSlotState, deliverySlotState, error,
    paymentAccountState, addressState, step, articleState, isLoading, success
  ]);

  OrderState copyWith({
    OrderRequestBuilder orderRequestBuilder,
    OrderSlotState pickupSlotState,
    OrderSlotState deliverySlotState,
    ArticleState articleState,
    OrderAddressState addressState,
    OrderPaymentAccountState paymentAccountState,
    int step,
    bool isLoading,
    bool success,
    AppError error
  }) => new OrderState(
    orderRequestBuilder: orderRequestBuilder ?? this.orderRequestBuilder,
    pickupSlotState: pickupSlotState ?? this.pickupSlotState,
    deliverySlotState: deliverySlotState ?? this.deliverySlotState,
    articleState: articleState ?? this.articleState,
    paymentAccountState: paymentAccountState ?? this.paymentAccountState,
    addressState: addressState ?? this.addressState,
    step: step ?? this.step,
    isLoading: isLoading ?? this.isLoading,
    success: success ?? this.success,
    error: error ?? this.error
  );
  
}

abstract class ArticleState extends Equatable {
  ArticleState([List props]) : super(props);
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

class ArticlesLoadingState extends ArticleState { }

class OrderPaymentAccountReadyState extends OrderPaymentAccountState {
  
  final List<PaymentAccount> paymentAccounts;

  OrderPaymentAccountReadyState({this.paymentAccounts}) : super([paymentAccounts]);
  
}

class OrderAddressReadyState extends OrderAddressState {
  
  final List<MemberAddress> addresses;

  OrderAddressReadyState({this.addresses}) : super([addresses]);
  
}

class OrderSlotReadyState extends OrderSlotState {

  final bool canMoveForward;
  final List<Slot> slots;

  OrderSlotReadyState({this.slots, this.canMoveForward}) : super([slots, canMoveForward]);

}

class ArticlesReadyState extends ArticleState{

  final Article weightedArticle;
  final List<Article> articles;

  ArticlesReadyState({this.weightedArticle, this.articles}) :
    super([articles, weightedArticle]);

}