import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/base_step_widget.dart';


class EstimateOrderStepWidget extends StatefulWidget {

  final List<Article> articles;

  EstimateOrderStepWidget({Key key, this.articles = const []}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _EstimateOrderStepWidgetState();

}

class _EstimateOrderStepWidgetState extends State<EstimateOrderStepWidget> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new BaseStepWidget(
      title: "Estimer votre commande",
      child: new Column(
        mainAxisSize: MainAxisSize.min,
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
          this._buildArticleWidget(this.widget.articles[0])
//          new GridView.count(
//            crossAxisCount: 2,
//            children: this.widget.articles
//              .map((article) => this._buildArticleWidget(article))
//              .toList(),
//          )
        ],
      ),
    );
  }

  Widget _buildArticleWidget(Article article) => new Container(
    padding: new EdgeInsets.all(12),
    child: new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Image.network(article.photoUrl),
        new Text(article.name),
        new Text("${article.laundryPrice}€"),
        new Container(color: ColorPalette.orange, height: 32, width: 96,)
      ],
    ),
  );

}