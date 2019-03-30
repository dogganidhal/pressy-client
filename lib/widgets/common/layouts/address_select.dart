import 'package:flutter/material.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/utils/style/app_theme.dart';


class AddressSelect extends StatefulWidget {

  final ValueChanged<MemberAddress> onAddressSelected;
  final List<MemberAddress> addresses;

  AddressSelect({Key key, @required this.addresses, this.onAddressSelected}) :
    super(key: key);

  @override
  State<StatefulWidget> createState() => new _AddressSelectState();

}

class _AddressSelectState extends State<AddressSelect> {
  
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return new ListView.separated(
      shrinkWrap: true,
      itemCount: this.widget.addresses.length,
      separatorBuilder: (context, index) => new SizedBox(height: 12),
      physics: new NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => new _AddressRowWidget(
        address: this.widget.addresses[index],
        onTapped: () => this.setState(() {
          this.widget.onAddressSelected(this.widget.addresses[index]);
          this.setState(() => this._selectedIndex = index);
        }),
        isSelected: this._selectedIndex == index,
      )
    );
  }

}

class _AddressRowWidget extends StatelessWidget {

  final MemberAddress address;
  final VoidCallback onTapped;
  final bool isSelected;

  _AddressRowWidget({Key key, this.onTapped, this.address, this.isSelected = false}) :
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: this.onTapped,
      child: new Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(4),
          border: new Border.all(color: this.isSelected ? ColorPalette.orange : ColorPalette.borderGray),
          color: this.isSelected ? ColorPalette.orange.withOpacity(0.33) : Colors.transparent
        ),
        child: new ListTile(
          title: new Text(this.address.name),
          subtitle: new Text(this.address.formattedAddress),
          trailing: this.isSelected ? 
            new Icon(Icons.check_circle, color: ColorPalette.orange) : 
            new Icon(Icons.radio_button_unchecked, color: ColorPalette.borderGray)
        ),
      ),
    );
  }

}