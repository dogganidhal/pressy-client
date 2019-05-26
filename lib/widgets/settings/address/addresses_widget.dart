import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pressy_client/blocs/settings/address/address_bloc.dart';
import 'package:pressy_client/blocs/settings/address/address_event.dart';
import 'package:pressy_client/blocs/settings/address/address_state.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/settings/address/add_address_widget.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';


class AddressesWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _AddressesWidgetState();

}

class _AddressesWidgetState extends State<AddressesWidget>
  with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {

  AddressBloc _addressBloc;
  GlobalKey _scaffoldKey = GlobalKey();
  List<MemberAddress> get _addresses => ServiceProvider
    .of(this.context)
    .getService<IMemberSession>()
    .connectedMemberProfile.addresses;

  @override
  void initState() {
    super.initState();
    this._addressBloc = AddressBloc(
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>(),
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressEvent, AddressState>(
      bloc: this._addressBloc,
      builder: (context, state) {
        this._handleState(state);
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPalette.orange),
            title: Text("Mes adresses"),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
            actions: <Widget>[
              FlatButton.icon(
                onPressed: this._launchAddAddressWidget,
                icon: Icon(Icons.add, color: ColorPalette.orange),
                label: Container()
              )
            ],
          ),
          body: Column(
            key: this._scaffoldKey,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 24, bottom: 12, left: 12, right: 12),
                child: Text(
                  "Pour modifier ou supprimer une de vos adresses, glisser vers la gauche",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  itemBuilder: (context, index) => this._addressRow(this._addresses[index]),
                  separatorBuilder: (context, index) => Divider(height: 1),
                  itemCount: this._addresses.length,
                )
              )
            ],
          ),
        );
      }
    );
  }

  Widget _addressRow(MemberAddress memberAddress) => Slidable(
    delegate: SlidableDrawerDelegate(),
    child: Container(
      color: Colors.white,
      child: ListTile(
        title: Text(memberAddress.name ?? "Mon adresse"),
        subtitle: Text(memberAddress.formattedAddress),
      ),
    ),
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Supprimer',
        color: ColorPalette.red,
        icon: Icons.delete,
        onTap: () => this._addressBloc.dispatch(DeleteAddressEvent(addressId: memberAddress.id)),
      ),
      IconSlideAction(
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
      .push(MaterialPageRoute(
        builder: (context) => ServiceProvider(
          child: BlocProvider(
            bloc: this._addressBloc,
            child: AddAddressWidget()
          ),
          services: services
        )
      )
    );
  }

  void _handleState(AddressState state) {
    if (state.isLoading) {
      this.onWidgetDidBuild(() => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
    } else {
      this.onWidgetDidBuild(() => this.hideLoaderSnackBar(this._scaffoldKey.currentContext));
    }
  }

}