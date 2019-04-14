import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class a_venir_VIP {
  String creneau_col;
  String creneau_liv;
  String adresse;
  a_venir_VIP(this.creneau_col,this.creneau_liv,this.adresse);

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
              margin: const EdgeInsets.only(left: 10.0,bottom: 10.0,top: 10.0),
              child: new Row(
                  children : <Widget>[
                    new Text("Créneau VIP",
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
              child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Container(
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
                    ),
                    new GestureDetector(
                      child: new Container(
                        margin: const EdgeInsets.only(left: 60.0),
                        child: new Text("ANNULER ",
                          maxLines: 1,
                          style: new TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.orange
                          ),
                        ),
                      ),
                    )
                  ]
              )
          )
        ]
    ),
  );
}