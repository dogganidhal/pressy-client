import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pressy_client/blocs/orders/orders_bloc.dart';
import 'package:pressy_client/blocs/orders/orders_event.dart';
import 'package:pressy_client/blocs/orders/orders_state.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/order/order/order.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class OrdersWidget extends StatefulWidget {

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> with SingleTickerProviderStateMixin {
  
  DateFormat _dateFormat = DateFormat("EEEE dd MMM HH'h'mm");
  TabController _tabController;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    this._tabController = TabController(vsync: this, length: 3);
    this._ordersBloc = OrdersBloc(orderDataSource: ServiceProvider.of(this.context).getService<IOrderDataSource>());
    this._ordersBloc.dispatch(LoadOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Mes commandes"),
        centerTitle: true,
        bottom: TabBar(
          controller: this._tabController,
          tabs: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              child: Text("PRÉCEDENTES", style: TextStyle(color: ColorPalette.orange))
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              child: Text("EN COURS", style: TextStyle(color: ColorPalette.orange)),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8, top: 8),
              child: Text("À VENIR", style: TextStyle(color: ColorPalette.orange)),
            )
          ],
        ),
      ),
      body: BlocBuilder<OrdersEvent, OrdersState>(
        bloc: this._ordersBloc,
        builder: (context, state) => TabBarView(
          controller: this._tabController,
          children: <Widget>[
            this._pastOrdersWidget(state),
            this._ongoingOrdersWidget(state),
            this._futureOrdersWidget(state)
          ],
        ),
      ),
    );
  }

  Widget _pastOrdersWidget(OrdersState state) {
    if (state is OrdersLoadingState) {
      return this._loadingWidget;
    } else if (state is OrdersReadyState) {
      return state.pastOrders.length > 0 ?
      ListView.builder(
        itemCount: state.pastOrders.length,
        itemBuilder: (context, index) => this._orderWidget(state.pastOrders[index]),
        padding: EdgeInsets.all(8),
      ) : Center(child: Text("Aucune commande passée"));
    }
    return Container();
  }

  Widget _ongoingOrdersWidget(OrdersState state) {
    if (state is OrdersLoadingState) {
      return this._loadingWidget;
    } else if (state is OrdersReadyState) {
      return state.ongoingOrders.length > 0 ?
      ListView.builder(
        itemCount: state.ongoingOrders.length,
        itemBuilder: (context, index) => this._orderWidget(state.ongoingOrders[index]),
        padding: EdgeInsets.all(8),
      ) : Center(child: Text("Aucune commande en cours"));
    }
    return Container();
  }

  Widget _futureOrdersWidget(OrdersState state) {
    if (state is OrdersLoadingState) {
      return this._loadingWidget;
    } else if (state is OrdersReadyState) {
      return state.ongoingOrders.length > 0 ?
      ListView.builder(
        itemCount: state.ongoingOrders.length,
        itemBuilder: (context, index) => this._orderWidget(state.ongoingOrders[index]),
        padding: EdgeInsets.all(8),
      ) : Center(child: Text("Aucune commande dans le future"));
    }
    return Container();
  }

  Widget get _loadingWidget => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 32, height: 32,
          child: CircularProgressIndicator()
        ),
      ],
    ),
  );

  Widget _orderWidget(Order order) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 1, color: ColorPalette.borderGray)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Text(
            "Créneau ${order.pickupSlot.type}",
            style: TextStyle(
              color: ColorPalette.textBlack,
              fontSize: 20,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: <Widget>[
              Text(
                "Collecte prévue : ",
                style: TextStyle(
                  color: ColorPalette.textGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                this._dateFormat.format(order.pickupSlot.startDate),
                style: TextStyle(
                  color: ColorPalette.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: <Widget>[
              Text(
                "Livraison prévue : ",
                style: TextStyle(
                  color: ColorPalette.textGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                this._dateFormat.format(order.deliverySlot.startDate),
                style: TextStyle(
                  color: ColorPalette.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: <Widget>[
              Text(
                "Adresse : ",
                style: TextStyle(
                  color: ColorPalette.textGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
              Text(
                order.address.formattedAddress,
                style: TextStyle(
                  color: ColorPalette.textBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}