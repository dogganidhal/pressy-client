import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class FutureWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
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
    );
  }
}