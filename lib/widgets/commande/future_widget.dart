//import 'package:flutter/material.dart';
//import 'package:pressy_client/utils/style/app_theme.dart';
//import 'package:pressy_client/widgets/commande/commandes_widget.dart';


/*class FutureWidget extends StatelessWidget {
  TabController _tabController;

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
              child: new Text("PASSEES",
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
                child: new Text("FUTURE",
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
      body: new Container(
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
      ),
    );
  }
}*/