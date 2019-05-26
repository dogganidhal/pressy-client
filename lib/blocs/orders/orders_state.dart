


import 'package:equatable/equatable.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/errors/base_error.dart';

abstract class OrdersState extends Equatable {
  OrdersState([List props]): super(props);
}

class OrdersLoadingState extends OrdersState {
  OrdersLoadingState(): super([]);
}

class OrdersErrorState extends OrdersState {

  final AppError error;

  OrdersErrorState({this.error}): super([error]);

}

class OrdersReadyState extends OrdersState {

  final List<Order> pastOrders;
  final List<Order> ongoingOrders;
  final List<Order> futureOrders;

  OrdersReadyState({this.pastOrders, this.ongoingOrders, this.futureOrders}) : 
    super([pastOrders, ongoingOrders, futureOrders]);

}