import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  OrderEvent([List props]) : super (props);
}


class FetchOrderDataEvent extends OrderEvent { }