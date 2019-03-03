import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_bloc.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_event.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_state.dart';
import 'package:pressy_client/blocs/settings/address/address_bloc.dart';
import 'package:pressy_client/blocs/settings/address/address_event.dart';
import 'package:pressy_client/blocs/settings/address/address_state.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';

class AddAddressWidget extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => new _AddAddressWidgetState();

}


class _AddAddressWidgetState extends State<AddAddressWidget> {

  AddAddressBloc _addAddressBloc;

  @override
  void initState() {
    super.initState();
    AddressBloc _bloc = BlocProvider.of<AddressBloc>(this.context);
    this._addAddressBloc = new AddAddressBloc(
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
      addressBloc: _bloc
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        elevation: 2,
        title: new Text("Ajouter une adresse"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: new BlocBuilder<AddAddressEvent, AddAddressState>(
        bloc: this._addAddressBloc,
        builder: (context, state) => state is AddAddressInputState ?
          this._addressInputWidget(state) :
          this._addressExtraInfoWidget(state as AddAddressExtraInfoState),
      ),
    );
  }

  Widget _addressExtraInfoWidget(AddAddressExtraInfoState state) => new Container(
    padding: new EdgeInsets.all(12),
    child: new Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Expanded(
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Adresse",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: state.confirmedPrediction.description,
                  enabled: false,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Alias de l'adresse",
                  ),
                  keyboardType: TextInputType.text,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Informations supplémentaires",
                  ),
                  keyboardType: TextInputType.text,
                )
              ],
            ),
          )
        ),
        new Row(
          children: <Widget>[
            new Expanded(
                child: new Container(
                  margin: new EdgeInsets.only(top: 12),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(8),
                      color: ColorPalette.orange
                  ),
                  height: 48,
                  child: new ButtonTheme(
                    height: double.infinity,
                    child: new FlatButton(
                      textColor: Colors.white,
                      disabledTextColor: Colors.white,
                      onPressed: () => print("Validate adresse"),
                      child: new Text("Valider"),
                    ),
                  ),
                )
            )
          ],
        )
      ],
    ),
  );

  Widget _addressInputWidget(AddAddressInputState state) => new Container(
    child: new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(16),
            margin: new EdgeInsets.all(8),
            decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: [new BoxShadow(color: Colors.grey[100], blurRadius: 1)],
                borderRadius: new BorderRadius.circular(8),
                border: new Border.all(color: ColorPalette.borderGray, width: 1)
            ),
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                      decoration: new InputDecoration.collapsed(
                          hintText: "Saisissez une adresse, quartier, arrondissement...",
                          hintStyle: new TextStyle(
                              fontWeight: FontWeight.w600
                          )
                      ),
                      onChanged: (input) => this._addAddressBloc.dispatch(new SubmitAddressQueryEvent(query: input))
                  ),
                ),
                new GestureDetector(
                  child: new Icon(Icons.location_on, color: ColorPalette.orange),
                  onTap: () => print("set to user location"),
                )
              ],
            ),
          ),
          this._placesListView(state.predictions)
        ],
      ),
    ),
  );

  Widget _placesListView(List<Prediction> predictions) => predictions.length > 0 ?
  new Container(
    padding: new EdgeInsets.all(8),
    margin: new EdgeInsets.only(left: 8, right: 8, bottom: 8),
    decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [new BoxShadow(color: ColorPalette.lightGray, blurRadius: 1)],
        borderRadius: new BorderRadius.circular(8)
    ),
    child: new ListView.separated(
      physics: new NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) =>  new Divider(),
      itemBuilder: (BuildContext context, int index) {
        return index == predictions.length ? new PoweredByGoogleImage() : new FlatButton(
          onPressed: () => this._addAddressBloc
            .dispatch(new ConfirmPredictionEvent(prediction: predictions[index])),
          child: new Container(
            padding: new EdgeInsets.only(top: 8, bottom: 8),
            child: new SizedBox(
              width: double.infinity,
              child: new Text(
                predictions[index].description,
                textAlign: TextAlign.start
              )
            )
          ),
        );
      },
      itemCount: predictions.length + 1,
    )
  ) : new Container();

}