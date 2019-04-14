import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class panier_vide {

  panier_vide();

  Widget get widget => new Center(
      child : new GestureDetector(
        child : new Container(
          margin: const EdgeInsets.only(top:80.0),
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
}