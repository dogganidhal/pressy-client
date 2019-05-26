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
import 'package:pressy_client/widgets/order/confirmation/order_confirmation.dart';
import 'package:pressy_client/widgets/order/estimate_order/estimate_order_step_widget.dart';
import 'package:pressy_client/widgets/order/payment_method/payment_method_step_widget.dart';
import 'package:pressy_client/widgets/order/slot/slot_step_widget.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';

class OrderWidget extends StatefulWidget {
  final VoidCallback onOrderSuccessful;

  const OrderWidget({Key key, this.onOrderSuccessful}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderWidgetState();

}

class _OrderWidgetState extends State<OrderWidget> 
  with ErrorMixin, LoaderMixin, WidgetLifeCycleMixin {

  OrderBloc _orderBloc;
  GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    this._orderBloc = OrderBloc(
      orderDataSource: ServiceProvider.of(this.context).getService<IOrderDataSource>(),
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>()
    );
    this._orderBloc.dispatch(FetchOrderDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Passer une commande"),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderEvent, OrderState>(
        key: this._scaffoldKey,
        bloc: this._orderBloc,
        builder: (context, state) {
          this._handleState(state);
          return Stepper(
            physics: FixedExtentScrollPhysics(),
            currentStep: state.step,
            type: StepperType.horizontal,
            steps: [
              Step(
                isActive: state.step >= 0,
                state: this._stepState(state, 0),
                title: SizedBox(width: 0),
                content: SlotWidget(
                  title: "Créneau de collecte",
                  isLoading: state.pickupSlotState is OrderSlotLoadingState,
                  canMoveForward: state.pickupSlotState is OrderSlotReadyState ?
                    (state.pickupSlotState as OrderSlotReadyState).canMoveForward :
                    false,
                  slots: state.pickupSlotState is OrderSlotReadyState ?
                    (state.pickupSlotState as OrderSlotReadyState).slots :
                    [],
                  onSlotSelected: (slot) => this._orderBloc.dispatch(SelectPickupSlotEvent(slot)),
                  onSlotConfirmed: () => this._orderBloc.dispatch(GoToNextStepEvent()),
                )
              ),
              Step(
                isActive: state.step >= 1,
                state: this._stepState(state, 1),
                title: SizedBox(width: 0),
                content: SlotWidget(
                  title: "Créneau de livraison",
                  displaySlotTypeInfo: false,
                  slotType: state.orderRequestBuilder.pickupSlot?.slotType,
                  isLoading: state.deliverySlotState is OrderSlotLoadingState,
                  canMoveForward: state.deliverySlotState is OrderSlotReadyState ?
                    (state.deliverySlotState as OrderSlotReadyState).canMoveForward :
                    false,
                  slots: state.deliverySlotState is OrderSlotReadyState ?
                    (state.deliverySlotState as OrderSlotReadyState).slots :
                    [],
                  onSlotSelected: (slot) => this._orderBloc.dispatch(SelectDeliverySlotEvent(slot)),
                  onSlotConfirmed: () => this._orderBloc.dispatch(GoToNextStepEvent()),
                )
              ),
              Step(
                isActive: state.step >= 2,
                state: this._stepState(state, 2),
                title: SizedBox(width: 0),
                content: EstimateOrderStepWidget(
                  articles: state.articleState is ArticlesReadyState ?
                    (state.articleState as ArticlesReadyState).articles :
                    [],
                  weightedArticle: state.articleState is ArticlesReadyState ?
                    (state.articleState as ArticlesReadyState).weightedArticle:
                    null,
                  onFinish: (orderType, estimatedPrice) {
                    this._orderBloc.dispatch(SelectOrderTypeEvent(orderType, estimatedPrice));
                    this._orderBloc.dispatch(GoToNextStepEvent());
                  }

                )
              ),
              Step(
                isActive: state.step >= 3,
                state: this._stepState(state, 3),
                title: SizedBox(width: 0),
                content: AddressStepWidget(
                  isLoading: state.addressState is OrderAddressLoadingState,
                  addresses: state.addressState is OrderAddressReadyState ?
                    (state.addressState as OrderAddressReadyState).addresses :
                    [],
                  onAddressSelected: (address) => this._orderBloc.dispatch(SelectAddressEvent(address)),
                  onAddressConfirmed: () => this._orderBloc.dispatch(GoToNextStepEvent()),
                )
              ),
              Step(
                isActive: state.step >= 4,
                state: this._stepState(state, 4),
                title: SizedBox(width: 0),
                content: PaymentAccountStepWidget(
                  isLoading: state.paymentAccountState is OrderPaymentAccountLoadingState,
                  paymentAccounts: state.paymentAccountState is OrderPaymentAccountReadyState ?
                    (state.paymentAccountState as OrderPaymentAccountReadyState).paymentAccounts :
                    [],
                  onPaymentAccountSelected: (account) =>
                    this._orderBloc.dispatch(SelectPaymentAccountEvent(account)),
                  onPaymentAccountConfirmed: () => this._orderBloc.dispatch(GoToNextStepEvent()),
                )
              ),
              Step(
                isActive: state.step >= 5,
                state: this._stepState(state, 5),
                title: SizedBox(width: 0),
                content: OrderConfirmationWidget(
                  orderRequest: state.orderRequestBuilder,
                  onOrderConfirmed: () => this._orderBloc.dispatch(ConfirmOrderEvent()),
                )
              )
            ],
            onStepContinue: this._onStepContinue,
            onStepCancel: this._onStepCancel,
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return Container();
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
  
  StepState _stepState(OrderState state, int stepIndex) {
    if (state.step > stepIndex)
      return StepState.complete;
    return StepState.indexed;
  }

  void _handleState(OrderState state) {
    if (state.success) {
      this.onWidgetDidBuild(this.widget.onOrderSuccessful);
    }
    
    if (state.isLoading) {
      this.onWidgetDidBuild(() => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
    } else {
      this.onWidgetDidBuild(() => this.hideLoaderSnackBar(this._scaffoldKey.currentContext));
    }
    
    if (state.error != null) {
      this.onWidgetDidBuild(() => this.showErrorDialog(this._scaffoldKey.currentContext, state.error));
    }
  }

}