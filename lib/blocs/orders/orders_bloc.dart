import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/orders/orders_event.dart';
import 'package:pressy_client/blocs/orders/orders_state.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';


class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {

  final IOrderDataSource orderDataSource;

  OrdersBloc({@required this.orderDataSource});
  
  @override
  OrdersState get initialState => OrdersReadyState(
    futureOrders: [],
    ongoingOrders: [],
    pastOrders: []
  );

  @override
  Stream<OrdersState> mapEventToState(OrdersState currentState, OrdersEvent event) async* {
    
    if (event is LoadOrdersEvent) {

      yield OrdersLoadingState();
      var orders = await this.orderDataSource.getMemberOrders();
      var pastOrders = orders.where((order) =>
        order.deliverySlot.startDate.add(Duration(minutes: 30)).isBefore(DateTime.now())
      );
      var ongoingOrders = orders.where((order) =>
        order.pickupSlot.startDate.add(Duration(minutes: 30)).isBefore(DateTime.now()) &&
        order.deliverySlot.startDate.isAfter(DateTime.now())
      );
      var futureOrders = orders.where((order) =>
        order.pickupSlot.startDate.isAfter(DateTime.now())
      );
      yield OrdersReadyState(
        futureOrders: futureOrders.toList(), 
        ongoingOrders: ongoingOrders.toList(), 
        pastOrders: pastOrders.toList()
      );

    }

  }

}