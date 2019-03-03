import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/settings/address/addresses_widget.dart';
import 'package:pressy_client/widgets/settings/contact_widget.dart';
import 'package:pressy_client/widgets/settings/faq_widget.dart';
import 'package:pressy_client/widgets/settings/payment_methods_widget.dart';
import 'package:pressy_client/widgets/settings/profile_widget.dart';
import 'package:pressy_client/widgets/settings/terms_of_use_widget.dart';


class SettingsWidget extends StatefulWidget {

  final IMemberSession memberSession;

  SettingsWidget({@required this.memberSession});

  @override
  State<StatefulWidget> createState() => new _SettingsWidgetState();

}

class _SettingsWidgetState extends State<SettingsWidget> {

  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    this._authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final widgets = this._buildWidgets();
    return new Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        backgroundColor: Colors.white,
        title: new Text("Paramètres"),
        centerTitle: true,
      ),
      body: new ListView.separated(
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
        padding: new EdgeInsets.only(top: 12, bottom: 12),
        separatorBuilder: (context, index) => new Container(height: 12),
      ),
    );
  }

  List<Widget> _buildWidgets() => [
    this._userInfoWidget(this.widget.memberSession.connectedMemberProfile),
    this._pressyServiceWidget,
    this._logoutButton
  ];

  Widget _userInfoWidget(MemberProfile profile) => new Container(
    color: Colors.white,
    child: new Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(12),
          child: new Row(
            children: <Widget>[
              new Text("Bonjour", style: new TextStyle(fontSize: 16)),
              new SizedBox(width: 4),
              new Text(
                profile.firstName,
                style: new TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.orange
                ),
              )
            ],
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(bottom: 12, top: 12),
          child: new ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: new FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.person),
                  new SizedBox(width: 12),
                  new Expanded(
                    child: new Text("Mon profil"),
                  ),
                  new Icon(Icons.chevron_right)
                ],
              ),
              onPressed: this._launchProfileWidget,
            ),
          ),
        ),
        new Divider(height: 1),
        new Container(
          padding: new EdgeInsets.only(bottom: 12, top: 12),
          child: new ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: new FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.credit_card),
                  new SizedBox(width: 12),
                  new Expanded(
                    child: new Text("Mes moyens de paiement"),
                  ),
                  new Icon(Icons.chevron_right)
                ],
              ),
              onPressed: this._launchPaymentAccountsWidget,
            ),
          ),
        ),
        new Divider(height: 1),
        new Container(
          padding: new EdgeInsets.only(bottom: 12, top: 12),
          child: new ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: new FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.location_city),
                  new SizedBox(width: 12),
                  new Expanded(
                    child: new Text("Mes adresses"),
                  ),
                  new Icon(Icons.chevron_right)
                ],
              ),
              onPressed: this._launchAddressesWidget,
            ),
          ),
        )
      ],
    ),
  );


  Widget get _pressyServiceWidget => new Container(
    color: Colors.white,
    child: new Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.only(bottom: 12, top: 12),
          child: new ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: new FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.info),
                  new SizedBox(width: 12),
                  new Expanded(
                    child: new Text("Comment ça marche ?"),
                  ),
                  new Icon(Icons.chevron_right)
                ],
              ),
              onPressed: this._launchFaqWidget,
            ),
          ),
        ),
        new Divider(height: 1),
        new Container(
          padding: new EdgeInsets.only(bottom: 12, top: 12),
          child: new ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: new FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.mail),
                  new SizedBox(width: 12),
                  new Expanded(
                    child: new Text("Nous contacter"),
                  ),
                  new Icon(Icons.chevron_right)
                ],
              ),
              onPressed: this._launchContactWidget,
            ),
          ),
        ),
        new Divider(height: 1),
        new Container(
          padding: new EdgeInsets.only(bottom: 12, top: 12),
          child: new ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: new FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: new Row(
                children: <Widget>[
                  new Icon(Icons.lock),
                  new SizedBox(width: 12),
                  new Expanded(
                    child: new Text("Conditions générales d'utilisation"),
                  ),
                  new Icon(Icons.chevron_right)
                ],
              ),
              onPressed: this._launchTermsOfUseWidget,
            ),
          ),
        )
      ],
    ),
  );

  Widget get _logoutButton => new Container(
    height: 48,
    margin: EdgeInsets.only(left: 4),
    child: new FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(8)
      ),
      onPressed: () => this._authBloc.dispatch(new AuthLoggedOutEvent()),
      textColor: ColorPalette.lightGray,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "DECONNEXION",
            style: new TextStyle(
              color: ColorPalette.orange,
              fontWeight: FontWeight.w600
            )
          ),
        ],
      )
    )
  );

  void _launchProfileWidget() {
    final services = ServiceProvider.of(this.context);
    Navigator.push(this.context, new MaterialPageRoute(
      builder: (_) => new ServiceProvider(
        child: new MemberInfoWidget(),
        services: services
      )
    ));
  }

  void _launchPaymentAccountsWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new PaymentMethodsWidget()
    ));
  }

  void _launchAddressesWidget() {
    final services = ServiceProvider.of(this.context);
    Navigator.push(this.context, new MaterialPageRoute(
      builder: (_) => new ServiceProvider(
        child: new AddressesWidget(),
        services: services)
    ));
  }

  void _launchFaqWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new FaqWidget()
    ));
  }

  void _launchContactWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new ContactWidget()
    ));
  }

  void _launchTermsOfUseWidget() {
    Navigator.push(this.context, new MaterialPageRoute(
        builder: (_) => new TermsOfUseWidget()
    ));
  }

}