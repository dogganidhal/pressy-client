import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';

abstract class CouponsEvent extends Equatable {
  CouponsEvent([List props]) : super(props);
}

class RedeemEvent extends CouponsEvent {
  @required
  final String id;
  RedeemEvent({this.id}) : super([]);
}
