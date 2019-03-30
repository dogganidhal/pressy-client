import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/order/order_bloc.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/blocs/order/order_state.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/address/address_step_widget.dart';
import 'package:pressy_client/widgets/order/estimate_order/estimate_order_step_widget.dart';
import 'package:pressy_client/widgets/order/payment_method/payment_method_step_widget.dart';
import 'package:pressy_client/widgets/order/slot/slot_step_widget.dart';

class OrderWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _OrderWidgetState();

}

class _OrderWidgetState extends State<OrderWidget> {

  OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    this._orderBloc = new OrderBloc(
      orderDataSource: ServiceProvider.of(this.context).getService<IOrderDataSource>(),
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>()
    );
    this._orderBloc.dispatch(new FetchOrderDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        backgroundColor: Colors.white,
        title: new Text("Passer une commande"),
        centerTitle: true,
      ),
      body: new BlocBuilder<OrderEvent, OrderState>(
        bloc: this._orderBloc,
        builder: (context, state) {
          return new Stepper(
            physics: new FixedExtentScrollPhysics(),
            currentStep: state.step,
            type: StepperType.horizontal,
            steps: [
              new Step(
                isActive: state.step >= 0,
                state: this._stepState(0),
                title: new SizedBox(width: 0),
                content: new SlotWidget(
                  title: "Créneau de collecte",
                  isLoading: state.pickupSlotState is OrderSlotLoadingState,
                  canMoveForward: state.pickupSlotState is OrderSlotReadyState ?
                    (state.pickupSlotState as OrderSlotReadyState).canMoveForward :
                    false,
                  slots: state.pickupSlotState is OrderSlotReadyState ?
                    (state.pickupSlotState as OrderSlotReadyState).slots :
                    [],
                  onSlotSelected: (slot) => this._orderBloc.dispatch(new SelectPickupSlotEvent(slot)),
                  onSlotConfirmed: () => this._orderBloc.dispatch(new GoToNextStepEvent()),
                )
              ),
              new Step(
                isActive: state.step >= 1,
                state: this._stepState(1),
                title: new SizedBox(width: 0),
                content: new SlotWidget(
                  title: "Créneau de livraison",
                  isLoading: state.deliverySlotState is OrderSlotLoadingState,
                  canMoveForward: state.deliverySlotState is OrderSlotReadyState ?
                    (state.deliverySlotState as OrderSlotReadyState).canMoveForward :
                    false,
                  slots: state.deliverySlotState is OrderSlotReadyState ?
                    (state.deliverySlotState as OrderSlotReadyState).slots :
                    [],
                  onSlotSelected: (slot) => this._orderBloc.dispatch(new SelectDeliverySlotEvent(slot)),
                  onSlotConfirmed: () => this._orderBloc.dispatch(new GoToNextStepEvent()),
                )
              ),
              new Step(
                isActive: state.step >= 2,
                state: this._stepState(2),
                title: new SizedBox(width: 0),
                content: new EstimateOrderStepWidget(
                  articles: state.articleState is ArticlesReadyState ?
                    (state.articleState as ArticlesReadyState).articles :
                    [],
                weightedArticle: state.articleState is ArticlesReadyState ?
                  (state.articleState as ArticlesReadyState).weightedArticle:
                  null,
                  onFinish: () => this._orderBloc.dispatch(new GoToNextStepEvent())
                )
              ),
              new Step(
                isActive: state.step >= 3,
                state: this._stepState(3),
                title: new SizedBox(width: 0),
                content: new AddressStepWidget(
                  isLoading: state.addressState is OrderAddressLoadingState,
                  addresses: state.addressState is OrderAddressReadyState ?
                    (state.addressState as OrderAddressReadyState).addresses :
                    [],
                  onAddressSelected: (address) => this._orderBloc.dispatch(new SelectAddressEvent(address)),
                  onAddressConfirmed: () => this._orderBloc.dispatch(new GoToNextStepEvent()),
                )
              ),
              new Step(
                isActive: state.step >= 4,
                state: this._stepState(4),
                title: new SizedBox(width: 0),
                content: new PaymentAccountStepWidget(
                  isLoading: state.paymentAccountState is OrderPaymentAccountLoadingState,
                  paymentAccounts: state.paymentAccountState is OrderPaymentAccountReadyState ?
                    (state.paymentAccountState as OrderPaymentAccountReadyState).paymentAccounts :
                    [],
                  onPaymentAccountSelected: (account) =>
                    this._orderBloc.dispatch(new SelectPaymentAccountEvent(account)),
                  onPaymentAccountConfirmed: () => this._orderBloc.dispatch(new GoToNextStepEvent()),
                )
              ),
              new Step(
                  isActive: state.step >= 5,
                state: this._stepState(5),
                title: new SizedBox(width: 0),
                content: new Container(
                  padding: new EdgeInsets.all(64),
                  child: new Center(
                    child: new Icon(Icons.adjust),
                  ),
                )
              )
            ],
            onStepContinue: this._onStepContinue,
            onStepCancel: this._onStepCancel,
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return new Container();
            },
          );
        },
      ),
    );
  }

  void _onStepContinue() {
//    if (this._currentStep == 5) return;
//    this.setState(() => this._currentStep++);
  }
  
  void _onStepCancel() {
//    if (this._currentStep == 0) return;
//    this.setState(() => this._currentStep--);
  }
  
  StepState _stepState(int stepIndex) {
//    if (this._currentStep > stepIndex)
//      return StepState.complete;
    return StepState.indexed;
  }

}