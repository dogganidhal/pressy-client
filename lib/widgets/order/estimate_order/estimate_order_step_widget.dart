import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pressy_client/widgets/order/stepper/numeric_stepper.dart';

typedef void OnEstimateOrderFinished(
    OrderType orderType, double estimatedPrice);
typedef void OnOrderPriceChanged(
    double estimatedPrice, OrderType orderType, totalPrice);

class EstimateOrderStepWidget extends StatefulWidget {
  final Article weightedArticle;
  final List<Article> articles;
  final OnEstimateOrderFinished onFinish;
  final OnOrderPriceChanged onChange;

  EstimateOrderStepWidget(
      {Key key,
      this.articles = const [],
      this.onFinish,
      @required this.onChange,
      @required this.weightedArticle})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EstimateOrderStepWidgetState();
}

class _EstimateOrderStepWidgetState extends State<EstimateOrderStepWidget> {
  int _selectedIndex = 0;
  Map<Article, int> _cart = {};
  double _totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return BaseStepWidget(
      title: "Estimer votre commande",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CupertinoSegmentedControl<int>(
              borderColor: ColorPalette.orange,
              selectedColor: ColorPalette.orange,
              unselectedColor: Colors.white,
              groupValue: this._selectedIndex,
              children: {0: Text("Pressing"), 1: Text("Linge au kilo")},
              onValueChanged: (index) =>
                  this.setState(() => this._selectedIndex = index)),
          this._selectedIndex == 0
              ? this._laundryWidget
              : this._weightedServiceWidget
        ],
      ),
    );
  }

  Widget get _weightedServiceWidget => Column(
        children: <Widget>[
          SizedBox(height: 18),
          Text(
            "Prix/kg",
            style: TextStyle(color: ColorPalette.darkGray),
          ),
          SizedBox(height: 18),
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            itemCount: 1,
            crossAxisCount: 1,
            itemBuilder: (context, index) =>
                this._buildArticleWidget(this.widget.weightedArticle),
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            physics: NeverScrollableScrollPhysics(),
          ),
          SizedBox(height: 12),
          //this._priceAndPassButtonWidget
        ],
      );

  Widget get _laundryWidget => Column(
        children: <Widget>[
          SizedBox(height: 18),
          Text(
            "Veuillez sélectionner vos articles afin d'établir un devis/\n celui-ci sera confirmé lors de la collecte.",
            style: TextStyle(color: ColorPalette.darkGray),
          ),
          SizedBox(height: 18),
          StaggeredGridView.countBuilder(
            shrinkWrap: true,
            itemCount: this.widget.articles.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) =>
                this._buildArticleWidget(this.widget.articles[index]),
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            physics: NeverScrollableScrollPhysics(),
          ),
          SizedBox(height: 12),
          //this._priceAndPassButtonWidget
        ],
      );

  Widget get _priceAndPassButtonWidget => Container(
        padding: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: ColorPalette.borderGray, width: 1))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Total :",
                style: TextStyle(color: ColorPalette.darkGray, fontSize: 14)),
            Text("${this._totalPrice.toStringAsFixed(2)} €",
                style: TextStyle(
                    color: ColorPalette.textBlack,
                    fontWeight: FontWeight.bold)),
            Expanded(child: Container()),
            FlatButton(
                onPressed: () => this.widget.onFinish(
                    this._selectedIndex == 0
                        ? OrderType.PRESSING
                        : OrderType.WEIGHT,
                    this._calculateTotalPrice()),
                child: Text("SUIVANT",
                    style: TextStyle(color: ColorPalette.orange))),
          ],
        ),
      );

  Widget _buildArticleWidget(Article article) => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: ColorPalette.borderGray, width: 1),
            borderRadius: BorderRadius.circular(4),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Image.network(article.photoUrl),
            SizedBox(height: 12),
            Text(article.name, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("${article.laundryPrice}€",
                style: TextStyle(
                    color: ColorPalette.darkGray, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            NumericStepper(
              onValueChanged: (value) {
                this._cart[article] = value;
                this.setState(() {
                  this._totalPrice = this._calculateTotalPrice();
                  this.widget.onChange(
                      this._totalPrice,
                      this._selectedIndex == 0
                          ? OrderType.PRESSING
                          : OrderType.WEIGHT,
                      this._calculateTotalPrice());
                });
              },
            )
          ],
        ),
      );

  double _calculateTotalPrice() {
    double priceAccumulator = 0.0;
    this._cart.forEach((article, count) {
      priceAccumulator += article.laundryPrice * count;
    });
    return priceAccumulator;
  }
}
