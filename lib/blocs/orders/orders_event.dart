import 'package:equatable/equatable.dart';


abstract class OrdersEvent extends Equatable {
  OrdersEvent([List props]) : super(props);
}


class LoadOrdersEvent extends OrdersEvent {
  LoadOrdersEvent() : super([]);
}