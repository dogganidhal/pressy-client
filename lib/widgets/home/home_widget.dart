import 'package:flutter/material.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/order/order_widget.dart';
import 'package:pressy_client/widgets/orders/orders_widget.dart';
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
  IMemberSession _memberSession;

  @override
  void initState() {
    super.initState();
    this._memberSession = ServiceProvider.of(this.context).getService<IMemberSession>();
    this._currentIndex = this.widget.initialSelectedTab;
    this._widgets = [
      OrderWidget(
        onOrderSuccessful: () => this.setState(() => this._currentIndex = 1),
      ),
      OrdersWidget(),
      SettingsWidget(
        memberSession: this._memberSession,
      ),
    ];
  }

  void _onTap(int index) {
    this.setState(() => this._currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: this._widgets[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: ColorPalette.orange,
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Commander', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Mes commandes', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Paramètres', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12))
          ),
        ],
        onTap: this._onTap,
      ),
    );
  }
}