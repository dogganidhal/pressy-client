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
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';

class AddressSelect extends StatefulWidget {
  final ValueChanged<MemberAddress> onAddressSelected;
  final List<MemberAddress> addresses;

  AddressSelect({Key key, @required this.addresses, this.onAddressSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddressSelectState();
}

class _AddressSelectState extends State<AddressSelect>
    with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {
  int _selectedIndex = -1;
  List<MemberAddress> get _addresses => ServiceProvider.of(this.context)
      .getService<IMemberSession>()
      .connectedMemberProfile
      .addresses;

  @override
  Widget build(BuildContext context) {
    return this._addresses.length > 0
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: this._addresses.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                this._addressRow(this._addresses[index], index))
        : new Center(
            child: new Text(
                "Vous n'avez pas encore renseigné votre adresse, veuillez la renseigner dans l'onglet paramètres > Mes adresses"));
  }

  Widget _addressRow(MemberAddress memberAddress, int index) => GestureDetector(
        onTap: () {
          this.setState(() {
            this.widget.onAddressSelected(memberAddress);
            this.setState(() {
              this._selectedIndex = index;
            });
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: this._selectedIndex == index
                      ? ColorPalette.orange
                      : ColorPalette.borderGray),
              color: this._selectedIndex == index
                  ? ColorPalette.orange.withOpacity(0.33)
                  : Colors.transparent),
          child: ListTile(
              title: Text(memberAddress.name),
              subtitle: Text(memberAddress.formattedAddress),
              trailing: this._selectedIndex == index
                  ? Icon(Icons.check_circle, color: ColorPalette.orange)
                  : Icon(Icons.radio_button_unchecked,
                      color: ColorPalette.borderGray)),
        ),
      );
}

class _AddressRowWidget extends StatefulWidget {
  final MemberAddress address;
  final VoidCallback onTapped;
  final bool isSelected;

  _AddressRowWidget(
      {Key key, this.onTapped, this.address, this.isSelected = false})
      : super(key: key);

  @override
  __AddressRowWidgetState createState() => __AddressRowWidgetState();
}

class __AddressRowWidgetState extends State<_AddressRowWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.widget.onTapped,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: this.widget.isSelected
                    ? ColorPalette.orange
                    : ColorPalette.borderGray),
            color: this.widget.isSelected
                ? ColorPalette.orange.withOpacity(0.33)
                : Colors.transparent),
        child: ListTile(
            title: Text(this.widget.address.name),
            subtitle: Text(this.widget.address.formattedAddress),
            trailing: this.widget.isSelected
                ? Icon(Icons.check_circle, color: ColorPalette.orange)
                : Icon(Icons.radio_button_unchecked,
                    color: ColorPalette.borderGray)),
      ),
    );
  }
}
