import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class EncoursWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new ListView(
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
      ],
    );
  }
}