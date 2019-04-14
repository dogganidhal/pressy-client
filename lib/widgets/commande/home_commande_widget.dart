import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/commande/precedent_standard.dart';
import 'package:pressy_client/widgets/commande/precedent_VIP.dart';
import 'package:pressy_client/widgets/commande/a_venir_standard.dart';
import 'package:pressy_client/widgets/commande/a_venir_VIP.dart';
import 'package:pressy_client/widgets/commande/encours_standard.dart';
import 'package:pressy_client/widgets/commande/encours_VIP.dart';
import 'package:pressy_client/widgets/commande/panier_vide.dart';

class HomeCommandeWidget extends StatefulWidget {

  @override
  _HomeCommandeWidgetState createState() => _HomeCommandeWidgetState();

}

class _HomeCommandeWidgetState extends State<HomeCommandeWidget> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new TabBarView(
          controller: this._tabController,
          children: [
            this._precedent,
            this._encours,
            this._future
          ]
      ),
      appBar: new AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: new Text("Mes commandes"),
        centerTitle: true,
        bottom: new TabBar(
          controller: this._tabController,
          tabs: <Widget>[
              new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new Text("PRECEDENTES",
                  maxLines: 1,
                  style: new TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new Text("EN COURS",
                  maxLines: 1,
                  style: new TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              ),
              new Container(
                  padding: new EdgeInsets.only(bottom: 8, top: 8),
                  child: new Text("A VENIR",
                    maxLines: 1,
                    style: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.orange
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }

  var test1 = new a_venir_standard("10 nov","20 novembre à 10h30","champs élysée");
  var test2 = new a_venir_VIP("10 nov","20 novembre à 10h30","champs élysée");
  var test3 = new encours_standard("10 nov","20 novembre à 10h30","champs élysée");
  var test4 = new encours_VIP("10 nov","20 novembre à 10h30","champs élysée");
  var test5 = new precedent_standard(50,22,"10 nov","20 novembre à 10h30","champs élysée");
  var test6 = new precedent_VIP(40,23,"10 nov","20 novembre à 10h30","champs élysée");
  var test7 = new panier_vide();

  Widget get _future => new ListView(
    children: <Widget>[
      test1.widget,
      test2.widget,
      test1.widget,
      test2.widget
      ]
  );

  Widget get _encours => new ListView(
      children: <Widget>[
        test3.widget,
        test3.widget,
        test4.widget,
      ]
  );


  //Widget get _precedent =>  test7.widget;

  Widget get _precedent => new ListView(
      children: <Widget>[
        test5.widget,
        test6.widget
      ]
  );

}