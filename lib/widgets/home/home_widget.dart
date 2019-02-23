import 'package:flutter/material.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/settings/settings_widget.dart';

class HomeWidget extends StatefulWidget {

  final String title;
  final int initialSelectedTab;
  
  HomeWidget({Key key, this.title, this.initialSelectedTab = 0}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();

}

class _HomeWidgetState extends State<HomeWidget> 
  with AutomaticKeepAliveClientMixin<HomeWidget> {

  @override
  bool get wantKeepAlive => true;  

  int _currentIndex;
  List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    this._currentIndex = this.widget.initialSelectedTab;
    this._widgets = [
      new Center(
        child: new Icon(Icons.search),
      ),
      new Center(
        child: new Icon(Icons.calendar_today),
      ),
      new SettingsWidget(),
    ];
  }

  void _onTap(int index) {
    this.setState(() => this._currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: this._widgets[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: ColorPalette.orange,
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Commander', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            title: new Text('Mes commandes', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text('Paramètres', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))
          ),
        ],
        onTap: this._onTap,
      ),
    );
  }
}