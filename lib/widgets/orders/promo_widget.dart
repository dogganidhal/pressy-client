import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pressy_client/blocs/coupon/coupon_bloc.dart';
import 'package:pressy_client/blocs/coupon/coupon_event.dart';
import 'package:pressy_client/blocs/coupon/coupon_state.dart';
import 'package:pressy_client/blocs/order/order_event.dart';
import 'package:pressy_client/blocs/orders/orders_bloc.dart';
import 'package:pressy_client/data/data_source/coupon/coupon_data_source.dart';
import 'package:pressy_client/data/data_source/order/order_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/model/order/coupon/coupon.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';

class PromoScreen extends StatefulWidget {
  @override
  _PromoScreenState createState() => _PromoScreenState();
}

class _PromoScreenState extends State<PromoScreen>
    with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {
  GlobalKey _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  CouponBloc _couponBloc;
  TextEditingController controller = TextEditingController();
  OrdersBloc _ordersBloc;
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    this._couponBloc = CouponBloc(
      couponDataSource:
          ServiceProvider.of(this.context).getService<ICouponsDataSource>(),
    );
    this._ordersBloc = OrdersBloc(
      orderDataSource:
          ServiceProvider.of(this.context).getService<IOrderDataSource>(),
    );
    _ordersBloc.orderDataSource
        .getMemberOrders()
        .then((orders) => this.orders = orders)
        .catchError((err) => debugPrint(err));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    this._couponBloc.dispose();
    this._ordersBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//            key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Code de reduction",
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.orange,
            ),
            onPressed: () {
//              print("total orders => ${orders.length}");
              this._couponBloc.dispatch(RedeemEvent(id: controller.text));
              //Todo: Promo Validation
              //promoOverlay(context);
//                    if (_formKey.currentState.validate()) {
//                      Navigator.pop(context, 20);
//                      print("Coupon is Valid => ${state.isValid}");
//                      Navigator.push(
//                          this.context,
//                          MaterialPageRoute(
//                              builder: (_) => PromoOverlay(promoValue: 20)));
//                    }
            },
          )
        ],
      ),
      body: BlocBuilder<CouponsEvent, CouponState>(
          key: _scaffoldKey,
          bloc: _couponBloc,
          builder: (context, state) {
            _handleState(state, context);
            return buildBodyWidgets(state);
          }),
    );
  }

  Widget buildBodyWidgets(CouponState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Form(
        key: _formKey,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.gift,
                color: ColorPalette.orange,
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: Colors.greenAccent,
                  width: 30,
                )),
          ),
          validator: (promoCode) {
            if (state is CouponSuccessState) {
              if (state.isValid) {
                if (this.orders.length != 0 &&
                        state.coupon?.name == "FLAT_20€_OFF" ||
                    state.coupon?.name == "WELCOME") {
                  return "Ce coupon ne peut être utilisé qu'à la première commande";
                }
                if (state.coupon.redeemBy != null) {
                  if (DateTime.now().isAfter(state.coupon.redeemBy)) {
                    return "Le coupon est expiré";
                  }
                }
                if (state.coupon.maxRedemptions != null) {
                  if (state.coupon.timesRedeemed <=
                      state.coupon.maxRedemptions) {
                    return "La limite d'utilisation du coupon est atteinte";
                  }
                }
              } else {
                return "Code de reduction non valide";
              }
            }
          },
        ),
      ),
    );
  }

  void _handleState(CouponState state, BuildContext context) {
    if (state is CouponLoadingState) {
      this.onWidgetDidBuild(() => this
          .showLoaderSnackBar(context, loaderText: "Validation du coupon ..."));
    } else {
      this.onWidgetDidBuild(() => this.hideLoaderSnackBar(context));
    }
    if (state is CouponFailureState) {
      this.onWidgetDidBuild(() => this.showErrorDialog(context, state.error));
    }
    if (state is CouponSuccessState) {
      this.onWidgetDidBuild(() {
        if (state.isValid) {
          //TODO: Uncomment Validation after testing
//          if (orders.length != 0 && state.coupon?.name == "FLAT_20€_OFF" ||
//              state.coupon?.name == "WELCOME")
//            return _formKey.currentState.validate();
          if (this._formKey.currentState.validate()) {
            var coupon = state.coupon;
            Navigator.pop(this.context, coupon);
            print("Coupon is Valid => ${state.isValid}");
            Navigator.push(
                this.context,
                MaterialPageRoute(
                    builder: (_) => PromoOverlay(
                        promoValue: state.category == "percent"
                            ? state.coupon.percentOff
                            : state.coupon.amountOff.toDouble())));
          }
        } else {
          print("not valid");
          _formKey.currentState.validate();
        }
      });
    }
  }
}

class PromoOverlay extends StatelessWidget {
  final double promoValue;

  const PromoOverlay({Key key, @required this.promoValue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: ColorPalette.orange.withOpacity(0.8),
        elevation: 0.0,
        actions: <Widget>[
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorPalette.orange.withOpacity(0.8),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                height: 100.0,
                width: 100.0,
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.done,
                  color: ColorPalette.orange,
                  size: 60,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                "Valeur du code de reduction",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              child: Text(
                "${promoValue.toInt().toStringAsFixed(2)} €",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 56.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
