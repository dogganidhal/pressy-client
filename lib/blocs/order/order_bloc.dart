import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/blocs/order/order_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/order/order_builder/order_builder.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {

  final IOrderDataSource orderDataSource;
  final IMemberDataSource memberDataSource;

  OrderBloc({@required this.orderDataSource, @required this.memberDataSource});
  
  @override
  OrderState get initialState => new OrderState(
    orderRequestBuilder: new OrderRequestBuilder(),
    // TODO: Decide whether put null or empty
    deliverySlotState: new OrderSlotReadyState(slots: []),
    pickupSlotState: new OrderSlotReadyState(slots: []),
    addressState: new OrderAddressReadyState(addresses: []),
    paymentAccountState: new OrderPaymentAccountReadyState(paymentAccounts: [])
  );

  @override
  Stream<OrderState> mapEventToState(OrderState currentState, OrderEvent event) async* {



  }

}