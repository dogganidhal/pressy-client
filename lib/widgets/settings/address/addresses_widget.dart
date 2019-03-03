import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pressy_client/blocs/settings/address/address_bloc.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/settings/address/add_address_widget.dart';


class AddressesWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _AddressesWidgetState();

}

class _AddressesWidgetState extends State<AddressesWidget> {

  AddressBloc _addressBloc;
  List<MemberAddress> get _addresses => ServiceProvider
    .of(this.context)
    .getService<IMemberSession>()
    .connectedMemberProfile.addresses;

  @override
  void initState() {
    super.initState();
    this._addressBloc = new AddressBloc(
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>(),
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>()
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BlocProvider<AddressBloc>(
      bloc: this._addressBloc,
      child: new Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: new AppBar(
          title: new Text("Mes adresses"),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          actions: <Widget>[
            new FlatButton.icon(
              onPressed: this._launchAddAddressWidget,
              icon: new Icon(Icons.add, color: ColorPalette.orange),
              label: new Container()
            )
          ],
        ),
        body: new Column(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 12),
              child: new Text(
                "Pour modifier ou supprimer une de vos adresses, glisser vers la gauche",
                textAlign: TextAlign.center,
              ),
            ),
            new Expanded(
              child: new ListView.separated(
                padding: new EdgeInsets.only(top: 12, bottom: 12),
                itemBuilder: (context, index) => this._addressRow(this._addresses[index]),
                separatorBuilder: (context, index) => new Divider(height: 1),
                itemCount: this._addresses.length
              )
            )
          ],
        ),
      )
    );
  }

  Widget _addressRow(MemberAddress memberAddress) => new Slidable(
    delegate: new SlidableDrawerDelegate(),
    child: new Container(
      color: Colors.white,
      child: new ListTile(
        title: new Text(memberAddress.name ?? "Mon adresse"),
        subtitle: new Text(memberAddress.formattedAddress),
      ),
    ),
    secondaryActions: <Widget>[
      new IconSlideAction(
        caption: 'Supprimer',
        color: ColorPalette.red,
        icon: Icons.delete,
        onTap: () => print('Supprimer'),
      ),
      new IconSlideAction(
        foregroundColor: Colors.white,
        caption: 'Modifier',
        color: ColorPalette.orange,
        icon: Icons.edit,
        onTap: () => print('Modifier'),
      ),
    ],
  );

  void _launchAddAddressWidget() {
    final services  = ServiceProvider.of(this.context);
    Navigator.of(this.context)
      .push(new MaterialPageRoute(
        builder: (context) => new ServiceProvider(
          child: new BlocProvider(
            bloc: this._addressBloc,
            child: new AddAddressWidget()
          ),
        services: services
        )
      ));
  }

}