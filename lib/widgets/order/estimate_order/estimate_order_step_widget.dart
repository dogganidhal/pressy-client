import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pressy_client/widgets/order/stepper/numeric_stepper.dart';


class EstimateOrderStepWidget extends StatefulWidget {

  final List<Article> articles;

  EstimateOrderStepWidget({Key key, this.articles = const []}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _EstimateOrderStepWidgetState();

}

class _EstimateOrderStepWidgetState extends State<EstimateOrderStepWidget> {

  int _selectedIndex = 0;
  Map<int, int> _cart = {};
  double _totalPrice;

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "Estimer votre commande",
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new CupertinoSegmentedControl<int>(
            borderColor: ColorPalette.orange,
            selectedColor: ColorPalette.orange,
            unselectedColor: Colors.white,
            groupValue: this._selectedIndex,
            children: {
              0: new Text("Pressing"),
              1: new Text("Linge au kilo")
            },
            onValueChanged: (index) => this.setState(() => this._selectedIndex = index)
          ),
          new SizedBox(height: 18),
          new StaggeredGridView.countBuilder(
            shrinkWrap: true,
            itemCount: this.widget.articles.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) => this._buildArticleWidget(this.widget.articles[index]),
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          new SizedBox(height: 12),
          new Container(
            padding: new EdgeInsets.only(top: 12),
            decoration: new BoxDecoration(
              border: new Border(
                top: new BorderSide(color: ColorPalette.borderGray, width: 1)
              )
            ),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text("Total :", style: new TextStyle(
                  color: ColorPalette.darkGray,
                  fontSize: 14
                )),
                new Text("${this._totalPrice}€", style: new TextStyle(
                  color: ColorPalette.textBlack,
                  fontWeight: FontWeight.bold
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildArticleWidget(Article article) => new Container(
    padding: new EdgeInsets.all(12),
    decoration: new BoxDecoration(
      border: new Border.all(color: ColorPalette.borderGray, width: 1),
      borderRadius: new BorderRadius.circular(4),
      color: Colors.white
    ),
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Image.network(article.photoUrl),
        new SizedBox(height: 12),
        new Text(article.name, style: new TextStyle(fontWeight: FontWeight.bold)),
        new SizedBox(height: 4),
        new Text("${article.laundryPrice}€", style: new TextStyle(color: ColorPalette.darkGray, fontWeight: FontWeight.bold)),
        new SizedBox(height: 12),
        new NumericStepper(
          onValueChanged: (value) {

            this._cart[article.id] = value;
            this._cart.removeWhere((_, count) => count == 0);

            var priceAccumulator = 0.0;
            this._cart.forEach((id, count) {
              final article = this.widget.articles.singleWhere((a) => a.id == id);
              priceAccumulator = article.laundryPrice * count;
            });

            this.setState(() {
              this._totalPrice = priceAccumulator;
            });
          },
        )
      ],
    ),
  );

}