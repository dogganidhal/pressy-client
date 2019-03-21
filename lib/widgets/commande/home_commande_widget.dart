import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/home/home_widget.dart';

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

  Widget get _precedent => new ListView(
    children: <Widget>[
      new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: new Column(
            children : <Widget>[
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0,top: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Créneau VIP',
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new SizedBox(width: 180),
                      new Expanded(
                        child: new Text("24.50€",
                            style: new TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.orange
                            )
                        ),
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Nombre d articles : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('24 articles',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Créneau de collecte : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('ven 08 avr, 18h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Créneau de livraison : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('ven 08 avr, 18h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Adresse : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('142 rue montmartre, 75002, Paris',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Divider(height: 1),
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new Text("VOIR MA FACTURE",
                  maxLines: 1,
                  style: new TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              )
            ]
        ),
      ),
      new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: new Column(
            children : <Widget>[
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0,top: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Créneau Standard',
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new SizedBox(width: 140),
                      new Expanded(
                        child: new Text("12.50€",
                            style: new TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.orange
                            )
                        ),
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Poids total : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('5.75kg',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Créneau de collecte : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('ven 08 avr, 18h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Créneau de livraison : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('ven 08 avr, 18h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 5.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Adresse : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          )
                      ),
                      new Text('142 rue montmartre, 75002, Paris',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Divider(height: 1),
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new Text("VOIR MA FACTURE",
                  maxLines: 1,
                  style: new TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              )
            ]
        ),
      ),
    ],
  );

  Widget get _encours => new Center(
    child : new GestureDetector(
      child : new Container(
        margin: const EdgeInsets.only(top: 80.0),
        child: Center(
          child : new ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: new Column(
                children: <Widget>[
                  new Icon(Icons.move_to_inbox,size: 200, color: Colors.grey),
                  new Text('Nothing is here',style: new TextStyle(color: Colors.grey,fontSize: 16)),
                  new Text('Passer une nouvelle commande!',
                    style: new TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.orange
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
      onTap: () {},
    )
  );


  Widget get _future =>  new ListView(
    children: <Widget>[
      new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        child: new Column(
            children : <Widget>[
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0,top: 10.0),
                child: new Row(
                  children : <Widget>[
                    new Text('Pressing - VIP',
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      )
                    ),
                  ]
                )
             ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Collecte prévue : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text('demain, 15h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Livraison prévue : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text('ven 08 avr, 18h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Adresse : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text('142 rue montmartre, 75002, Paris',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Divider(height: 1),
              new Container(
                margin: const EdgeInsets.all(10.0),
                child: new Text("CHANGER L'ADRESSE ",
                  maxLines: 1,
                  style: new TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              )
            ]
        ),
      ),
      new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: new Column(
            children : <Widget>[
              new Container(
                  margin: const EdgeInsets.only(left: 10.0,bottom: 10.0,top: 10.0),
                  child: new Row(
                      children : <Widget>[
                        new Text('Linge au kilo - Standard',
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ]
                  )
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Collecte prévue : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text('demain, 15h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Livraison prévue : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text('ven 08 avr, 18h15',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 10.0,bottom: 10.0),
                child: new Row(
                    children : <Widget>[
                      new Text('Adresse : ',
                          style: new TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text('142 rue montmartre, 75002, Paris',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Divider(height: 1),
              new Container(
                  /*decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      )
                  ),*/
                  child: new Row(
                    children: <Widget>[
                      new Container(
                        margin: const EdgeInsets.only(left: 20.0,top:10.0,bottom: 10.0),
                        child: new Text("CHANGER L'ADRESSE ",
                          maxLines: 1,
                          style: new TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.orange
                          ),
                        ),
                      ),
                      new SizedBox(width: 10),
                      new Container(
                        margin: const EdgeInsets.only(left: 40.0),
                        child: new Text("ANNULER ",
                          maxLines: 1,
                          style: new TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.orange
                          ),
                        ),
                      ),
                    ]
                )
              )
            ]
        ),
      ),
    ],
  );

/*void _homeWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new HomeWidget()
    ));
  }*//*
  void _encoursWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new EncoursWidget()
    ));
  }
  void _precedentWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new PrecedentWidget()
    ));
  }*/
}