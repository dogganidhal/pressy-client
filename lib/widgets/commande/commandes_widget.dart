import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
//import 'package:pressy_client/widgets/commande/future_widget.dart';



class CommandeWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _CommandeWidgetState();

}

class _CommandeWidgetState extends State<CommandeWidget> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                    style: new TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.orange
                    ),
                  ),
              ),
              new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new Text("EN COURS",
                  style: new TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              ),
              /*new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new ButtonTheme(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: new FlatButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: new Text("FUTURE",
                      maxLines: 1,
                      style: new TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.orange
                      ),
                    ),
                    onPressed: this._futureWidget,
                  ),
                ),
              )*/
              new Container(
                padding: new EdgeInsets.only(bottom: 8, top: 8),
                child: new Text("A VENIR",
                    maxLines: 1,
                  style: new TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.orange
                  ),
                ),
              )
            ],
          ),
        ),
        body: new ListView(
              children: <Widget>[
                //new Center(
                  /*child:*/ new Container(
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
                        new Text('Pressing - VIP',
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        new Row(
                            children : <Widget>[
                              new Text('Collecte prévue : ',
                                  style: new TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                  )
                              ),
                              new Text('Demain, 15h15',
                                  style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                        new Row(
                            children : <Widget>[
                              new Text('Livraison prévue : ',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  )
                              ),
                              new Text('ven 08 avril, 18h15',
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                        new Row(
                            children : <Widget>[
                              new Text('Adresse : ',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  )
                              ),
                              new Text('142 rue monmartre ......',
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                        new Divider(height: 1),
                        new Container(
                          margin: const EdgeInsets.all(10.0),
                          child: new Text("CHANGER L'ADRESSE DE LIVRAISON",
                            maxLines: 1,
                            style: new TextStyle(
                                fontSize: 16,
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
                        new Text('Linge au kilo - Standard',
                            textAlign: TextAlign.left,
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        new Row(
                            children : <Widget>[
                              new Text('Collecte prévue : ',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  )
                              ),
                              new Text('Demain, 15h15',
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                        new Row(
                            children : <Widget>[
                              new Text('Livraison prévue : ',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  )
                              ),
                              new Text('ven 08 avril, 18h15',
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                        new Row(
                            children : <Widget>[
                              new Text('Adresse : ',
                                  style: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  )
                              ),
                              new Text('142 rue monmartre ......',
                                  style: new TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),
                            ]
                        ),
                        new Divider(height: 1),
                        new Container(
                          margin: const EdgeInsets.all(10.0),
                          child: new Text("CHANGER L'ADRESSE DE LIVRAISON",
                            maxLines: 1,
                            style: new TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.orange
                            ),
                          ),
                        )
                      ]
                  ),
                ),
                //)
              ],
            ),
        /*body: new Container(
            child: Center(
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
        ),*/
    );
  }
  /*void _futureWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new FutureWidget()
    ));
  }*/
}