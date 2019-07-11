import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/order/order_bloc.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/blocs/order/order_state.dart';
import 'package:pressy_client/blocs/settings/address/address_bloc.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
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
import 'package:pressy_client/widgets/settings/address/add_address_widget.dart';
import 'package:pressy_client/widgets/settings/address/addresses_widget.dart';
import 'package:pressy_client/widgets/settings/payment/add_payment_method_widget.dart';
import 'package:pressy_client/widgets/settings/payment/payment_methods_widget.dart';

class OrderWidget extends StatefulWidget {
  final VoidCallback onOrderSuccessful;

  const OrderWidget({Key key, this.onOrderSuccessful}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget>
    with ErrorMixin, LoaderMixin, WidgetLifeCycleMixin {
  OrderBloc _orderBloc;
  AddressBloc _addressBloc;
  GlobalKey _scaffoldKey = GlobalKey();
  double estimatedPrice = 0.0;
  double totalPrice = 0.0;
  OrderType orderType;
  double couponAmount = 0;
  String couponCategory = "";
  @override
  void initState() {
    super.initState();
    this._orderBloc = OrderBloc(
        orderDataSource:
            ServiceProvider.of(this.context).getService<IOrderDataSource>(),
        memberDataSource:
            ServiceProvider.of(this.context).getService<IMemberDataSource>());
    this._addressBloc = AddressBloc(
        memberSession:
            ServiceProvider.of(this.context).getService<IMemberSession>(),
        memberDataSource:
            ServiceProvider.of(this.context).getService<IMemberDataSource>());
    this._orderBloc.dispatch(FetchOrderDataEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this._orderBloc.dispose();
    this._addressBloc.dispose();
    super.dispose();
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
      body: BlocProvider(
        bloc: _orderBloc,
        child: BlocBuilder<OrderEvent, OrderState>(
          key: this._scaffoldKey,
          bloc: this._orderBloc,
          builder: (context, state) {
            this._handleState(state);
            return Stack(
              children: <Widget>[
                Stepper(
                  currentStep: state.step,
                  type: StepperType.horizontal,
                  steps: [
                    Step(
                        isActive: state.step >= 0,
                        state: this._stepState(state, 0),
                        title: SizedBox(width: 0),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            goToNextStepOrPrevStep(
                                step: state.step, context: context),
                            SlotWidget(
                              title: "Créneau de collecte",
                              promoAmount: state.coupon?.amountOff?.toDouble(),
                              isLoading: state.pickupSlotState
                                  is OrderSlotLoadingState,
                              canMoveForward:
                                  state.pickupSlotState is OrderSlotReadyState
                                      ? (state.pickupSlotState
                                              as OrderSlotReadyState)
                                          .canMoveForward
                                      : false,
                              slots:
                                  state.pickupSlotState is OrderSlotReadyState
                                      ? (state.pickupSlotState
                                              as OrderSlotReadyState)
                                          .slots
                                      : [],
                              onSlotSelected: (slot) => this
                                  ._orderBloc
                                  .dispatch(SelectPickupSlotEvent(slot)),
                              onSlotConfirmed: () =>
                                  this._orderBloc.dispatch(GoToNextStepEvent()),
                              onCouponAppliedCallback:
                                  (category, couponValue, coupon) {
                                setState(() {
                                  this.couponAmount = couponValue.toDouble();
                                  this.couponCategory = category;
                                });
                                this._orderBloc.dispatch(
                                    SaveCouponInOrderStateEvent(
                                        category: category,
                                        coupon: coupon,
                                        isCouponValid:
                                            coupon == null ? false : true));
                              },
                            ),
                          ],
                        )),
                    Step(
                        isActive: state.step >= 1,
                        state: this._stepState(state, 1),
                        title: SizedBox(width: 0),
                        content: Column(
                          children: <Widget>[
                            goToNextStepOrPrevStep(
                                step: state.step, context: context),
                            SlotWidget(
                              title: "Créneau de livraison",
                              displaySlotTypeInfo: false,
                              slotType: state
                                  .orderRequestBuilder.pickupSlot?.slotType,
                              isLoading: state.deliverySlotState
                                  is OrderSlotLoadingState,
                              canMoveForward:
                                  state.deliverySlotState is OrderSlotReadyState
                                      ? (state.deliverySlotState
                                              as OrderSlotReadyState)
                                          .canMoveForward
                                      : false,
                              slots:
                                  state.deliverySlotState is OrderSlotReadyState
                                      ? (state.deliverySlotState
                                              as OrderSlotReadyState)
                                          .slots
                                      : [],
                              onSlotSelected: (slot) => this
                                  ._orderBloc
                                  .dispatch(SelectDeliverySlotEvent(slot)),
                              onSlotConfirmed: () =>
                                  this._orderBloc.dispatch(GoToNextStepEvent()),
                              promoAmount: state.coupon?.amountOff?.toDouble(),
                            ),
                          ],
                        )),
                    Step(
                        isActive: state.step >= 2,
                        state: this._stepState(state, 2),
                        title: SizedBox(width: 0),
                        content: Column(
                          children: <Widget>[
                            goToNextStepOrPrevStep(
                                step: state.step, context: context),
                            EstimateOrderStepWidget(
                              articles: state.articleState is ArticlesReadyState
                                  ? (state.articleState as ArticlesReadyState)
                                      .articles
                                  : [],
                              weightedArticle: state.articleState
                                      is ArticlesReadyState
                                  ? (state.articleState as ArticlesReadyState)
                                      .weightedArticle
                                  : null,
//                            onFinish: (orderType, estimatedPrice) {
//                              setState(() {
//                                this.orderType = orderType;
//                                this.estimatedPrice = estimatedPrice;
//                              });
//                            },
                              onChange:
                                  (totalPrice, orderType, estimatedPrice) {
                                setState(() {
                                  this.totalPrice = totalPrice;
                                  this.orderType = orderType;
                                  this.estimatedPrice = estimatedPrice;
                                });
                              },
                            ),
                          ],
                        )),
                    Step(
                        isActive: state.step >= 3,
                        state: this._stepState(state, 3),
                        title: SizedBox(width: 0),
                        content: Column(
                          children: <Widget>[
                            goToNextStepOrPrevStep(
                                step: state.step, context: context),
                            AddressStepWidget(
                              isLoading: state.addressState
                                  is OrderAddressLoadingState,
                              addresses:
                                  state.addressState is OrderAddressReadyState
                                      ? (state.addressState
                                              as OrderAddressReadyState)
                                          .addresses
                                      : [],
                              onAddressSelected: (address) => this
                                  ._orderBloc
                                  .dispatch(SelectAddressEvent(address)),
                              onAddressConfirmed: () =>
                                  this._orderBloc.dispatch(GoToNextStepEvent()),
                            ),
                          ],
                        )),
                    Step(
                        isActive: state.step >= 4,
                        state: this._stepState(state, 4),
                        title: SizedBox(width: 0),
                        content: Column(
                          children: <Widget>[
                            goToNextStepOrPrevStep(
                                step: state.step, context: context),
                            PaymentAccountStepWidget(
                              isLoading: state.paymentAccountState
                                  is OrderPaymentAccountLoadingState,
                              paymentAccounts: state.paymentAccountState
                                      is OrderPaymentAccountReadyState
                                  ? (state.paymentAccountState
                                          as OrderPaymentAccountReadyState)
                                      .paymentAccounts
                                  : [],
                              onPaymentAccountSelected: (account) => this
                                  ._orderBloc
                                  .dispatch(SelectPaymentAccountEvent(account)),
                              onPaymentAccountConfirmed: () =>
                                  this._orderBloc.dispatch(GoToNextStepEvent()),
                            ),
                          ],
                        )),
                    Step(
                        isActive: state.step >= 5,
                        state: this._stepState(state, 5),
                        title: SizedBox(width: 0),
                        content: Column(
                          children: <Widget>[
                            goToNextStepOrPrevStep(
                                step: state.step, context: context),
                            OrderConfirmationWidget(
                              orderRequest: state.orderRequestBuilder,
                              appliedCoupon: state.coupon,
                              couponCategory: state.category,
                              onOrderConfirmed: () =>
                                  this._orderBloc.dispatch(ConfirmOrderEvent()),
                            ),
                          ],
                        ))
                  ],
                  onStepContinue: this._onStepContinue,
                  onStepCancel: this._onStepCancel,
                  controlsBuilder: (context, {onStepContinue, onStepCancel}) {
                    return Container();
                  },
                ),
                state.step == 2
                    ? Positioned(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding:
                              EdgeInsets.only(top: 12, left: 22, right: 13),
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: ColorPalette.borderGray, width: 1)),
                            color: Colors.white.withOpacity(0.8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("Total :",
                                      style: TextStyle(
                                          color: ColorPalette.darkGray,
                                          fontSize: 14)),
                                  Text(
                                      "${this.totalPrice.toStringAsFixed(2)} €",
                                      style: TextStyle(
                                          color: ColorPalette.textBlack,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              FlatButton(
                                  onPressed: () {
                                    if (this.couponAmount != 0) {
                                      if (this.estimatedPrice >
                                          this.couponAmount) {
                                        this._orderBloc.dispatch(
                                            SelectOrderTypeEvent(this.orderType,
                                                this.estimatedPrice));
                                        this
                                            ._orderBloc
                                            .dispatch(GoToNextStepEvent());
                                      } else {
                                        print(
                                            "${this.estimatedPrice}  ${this.couponAmount}");
                                        this.showLoaderSnackBar(context,
                                            loaderText:
                                                "Ce coupon ne peut être appliqué à l'achat de moins de ${this.couponAmount}€",
                                            showLoadingProgressBar: false,
                                            durationInSec: 4);
                                      }
                                    } else {
                                      this._orderBloc.dispatch(
                                          SelectOrderTypeEvent(this.orderType,
                                              this.estimatedPrice));
                                      this
                                          ._orderBloc
                                          .dispatch(GoToNextStepEvent());
                                    }
                                  },
                                  child: Text("SUIVANT",
                                      style: TextStyle(
                                          color: ColorPalette.orange))),
                            ],
                          ),
                        ),
                        bottom: 0,
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget goToNextStepOrPrevStep(
      {@required int step, @required BuildContext context}) {
    return Row(
      children: <Widget>[
        step != 0
            ? FlatButton(
                onPressed: () =>
                    this._orderBloc.dispatch(GoToPreviousStepEvent()),
                child: Text("Back"),
                textColor: Colors.white,
                color: ColorPalette.orange,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12)),
              )
            : Container(),
        step == 2
            ? FlatButton(
                onPressed: () => this._orderBloc.dispatch(GoToNextStepEvent()),
                child: Text("Skip"),
                color: ColorPalette.orange,
                textColor: Colors.white,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white)),
              )
            : step == 3
                ? IconButton(
                    icon: Icon(
                      Icons.add,
                      color: ColorPalette.orange,
                    ),
                    onPressed: () => this._launchAddAddressWidget())
                : step == 4
                    ? IconButton(
                        icon: Icon(
                          Icons.add,
                          color: ColorPalette.orange,
                        ),
                        onPressed: () => this._launchAddPaymentWidget())
                    : Container(),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    if (state.step > stepIndex) return StepState.complete;
    return StepState.indexed;
  }

  void _handleState(OrderState state) {
    if (state.success) {
      this.onWidgetDidBuild(this.widget.onOrderSuccessful);
    }

    if (state.isLoading) {
      this.onWidgetDidBuild(
          () => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
    } else {
      this.onWidgetDidBuild(
          () => this.hideLoaderSnackBar(this._scaffoldKey.currentContext));
    }

    if (state.error != null) {
      this.onWidgetDidBuild(() =>
          this.showErrorDialog(this._scaffoldKey.currentContext, state.error));
    }
  }

  void _launchAddPaymentWidget() {
    final services = ServiceProvider.of(this.context);
    Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => ServiceProvider(
            child: AddPaymentMethodWidget(), services: services)));
  }

  void _launchAddAddressWidget() {
    final services = ServiceProvider.of(this.context);
    Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => ServiceProvider(
            child: BlocProvider(
                bloc: this._addressBloc, child: AddAddressWidget()),
            services: services)));
  }
}
