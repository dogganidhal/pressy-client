import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class precedent_VIP {
  int prix;
  int nb_articles;
  String creneau_col;
  String creneau_liv;
  String adresse;

  precedent_VIP(this.prix,this.nb_articles,this.creneau_col,this.creneau_liv,this.adresse);

  Widget get widget => new Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: ColorPalette.borderGray,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0)
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
                      new SizedBox(width: 195),
                      new Expanded(
                        child: new Text("$prix"+"€",
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
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text("$nb_articles"+' articles',
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
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text(this.creneau_col,
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
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text(this.creneau_liv,
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
                              fontWeight: FontWeight.bold
                          )
                      ),
                      new Text(this.adresse,
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )
                      ),
                    ]
                ),
              ),
              new Divider(height: 1,indent: 10.0),
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
  );
}