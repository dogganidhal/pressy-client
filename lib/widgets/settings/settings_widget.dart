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
import 'package:pressy_client/widgets/settings/contact/contact_widget.dart';
import 'package:pressy_client/widgets/settings/faq/faq_widget.dart';
import 'package:pressy_client/widgets/settings/payment/payment_methods_widget.dart';
import 'package:pressy_client/widgets/settings/profile/profile_widget.dart';
import 'package:pressy_client/widgets/settings/terms_of_use/terms_of_use_widget.dart';


class SettingsWidget extends StatefulWidget {

  final IMemberSession memberSession;

  SettingsWidget({@required this.memberSession});

  @override
  State<StatefulWidget> createState() => _SettingsWidgetState();

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Paramètres"),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: widgets.length,
        itemBuilder: (context, index) => widgets[index],
        padding: EdgeInsets.only(top: 12, bottom: 12),
        separatorBuilder: (context, index) => Container(height: 12),
      ),
    );
  }

  List<Widget> _buildWidgets() => [
    this._userInfoWidget(this.widget.memberSession.connectedMemberProfile),
    this._pressyServiceWidget,
    this._logoutButton
  ];

  Widget _userInfoWidget(MemberProfile profile) => Container(
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: <Widget>[
              Text("Bonjour", style: TextStyle(fontSize: 16)),
              SizedBox(width: 4),
              Text(
                profile.firstName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.orange
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 12, top: 12),
          child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Mon profil"),
                  ),
                  Icon(Icons.chevron_right, color: ColorPalette.orange)
                ],
              ),
              onPressed: this._launchProfileWidget,
            ),
          ),
        ),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.only(bottom: 12, top: 12),
          child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(Icons.credit_card),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Mes moyens de paiement"),
                  ),
                  Icon(Icons.chevron_right, color: ColorPalette.orange)
                ],
              ),
              onPressed: this._launchPaymentAccountsWidget,
            ),
          ),
        ),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.only(bottom: 12, top: 12),
          child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_city),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Mes adresses"),
                  ),
                  Icon(Icons.chevron_right, color: ColorPalette.orange)
                ],
              ),
              onPressed: this._launchAddressesWidget,
            ),
          ),
        )
      ],
    ),
  );


  Widget get _pressyServiceWidget => Container(
    color: Colors.white,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 12, top: 12),
          child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(Icons.info),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Comment ça marche ?"),
                  ),
                  Icon(Icons.chevron_right, color: ColorPalette.orange)
                ],
              ),
              onPressed: this._launchFaqWidget,
            ),
          ),
        ),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.only(bottom: 12, top: 12),
          child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(Icons.mail),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Nous contacter"),
                  ),
                  Icon(Icons.chevron_right, color: ColorPalette.orange)
                ],
              ),
              onPressed: this._launchContactWidget,
            ),
          ),
        ),
        Divider(height: 1),
        Container(
          padding: EdgeInsets.only(bottom: 12, top: 12),
          child: ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: FlatButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Icon(Icons.lock),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Conditions générales d'utilisation"),
                  ),
                  Icon(Icons.chevron_right, color: ColorPalette.orange)
                ],
              ),
              onPressed: this._launchTermsOfUseWidget,
            ),
          ),
        )
      ],
    ),
  );

  Widget get _logoutButton => Container(
    height: 48,
    margin: EdgeInsets.only(left: 4),
    child: FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      onPressed: () => this._authBloc.dispatch(AuthLoggedOutEvent()),
      textColor: ColorPalette.lightGray,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "DECONNEXION",
            style: TextStyle(
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
    Navigator.push(this.context, MaterialPageRoute(
      builder: (_) => ServiceProvider(
        child: MemberInfoWidget(),
        services: services
      )
    ));
  }

  void _launchPaymentAccountsWidget() {
    final services = ServiceProvider.of(this.context);
    Navigator.push(this.context, MaterialPageRoute(
      builder: (_) => ServiceProvider(
        child: PaymentMethodsWidget(),
        services: services
      )
    ));
  }

  void _launchAddressesWidget() {
    final services = ServiceProvider.of(this.context);
    Navigator.push(this.context, MaterialPageRoute(
      builder: (_) => ServiceProvider(
        child: AddressesWidget(),
        services: services)
    ));
  }

  void _launchFaqWidget() {
    Navigator.push(this.context, MaterialPageRoute(
        builder: (_) => FaqWidget()
    ));
  }

  void _launchContactWidget() {
    Navigator.push(this.context, MaterialPageRoute(
        builder: (_) => ContactWidget()
    ));
  }

  void _launchTermsOfUseWidget() {
    Navigator.push(this.context, MaterialPageRoute(
        builder: (_) => TermsOfUseWidget()
    ));
  }

}