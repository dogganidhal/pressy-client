import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_bloc.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_event.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_state.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';

class AddAddressWidget extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => new _AddAddressWidgetState();

}


class _AddAddressWidgetState extends State<AddAddressWidget>
  with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {

  AddAddressBloc _addAddressBloc;
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _addressNameController = new TextEditingController();
  TextEditingController _extraLineController = new TextEditingController();
  GlobalKey _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    this._addAddressBloc = new AddAddressBloc(
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>()
    );
    this._addressController.addListener(() {
      final query = this._addressController.text;
      if (query != null && query.isNotEmpty && query.length > 1)
        this._addAddressBloc.dispatch(new SubmitAddressQueryEvent(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: new IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        title: new Text("Ajouter une adresse"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: new BlocBuilder<AddAddressEvent, AddAddressState>(
        key: this._scaffoldKey,
        bloc: this._addAddressBloc,
        builder: (context, state) {
          this._handleState(state);
          Widget widget;
          if (state is AddAddressInputState)
            widget = this._addressInputWidget(state);
          else if (state is AddAddressExtraInfoState)
            widget = this._addressExtraInfoWidget(state);
          else
            widget = new Container();
          return widget;
        },
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
                  controller: this._addressNameController,
                  decoration: new InputDecoration(
                    labelText: "Alias de l'adresse",
                    helperText: "Ex : Maison, Travail ..."
                  ),
                  keyboardType: TextInputType.text,
                ),
                new TextFormField(
                  controller: this._extraLineController,
                  decoration: new InputDecoration(
                    labelText: "Informations supplémentaires",
                    helperText: "Ex : Etage, Batiment ..."
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
                      onPressed: () => this._addAddressBloc
                        .dispatch(new ConfirmAddAddressEvent(
                          prediction: state.confirmedPrediction,
                          name: this._addressNameController.text.isNotEmpty ? this._addressNameController.text : null,
                          extraLine: this._extraLineController.text.isNotEmpty ? this._extraLineController.text : null
                        )),
                      child: new Text("Valider".toUpperCase()),
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
                borderRadius: new BorderRadius.circular(8),
                border: new Border.all(color: ColorPalette.borderGray, width: 1)
            ),
            child: Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    decoration: new InputDecoration.collapsed(
                      hintText: "Saisissez une adresse, quartier, arrondissement...",
                      hintStyle: new TextStyle(fontWeight: FontWeight.w600)
                    ),
                    controller: this._addressController,
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
        borderRadius: new BorderRadius.circular(8),
        border: new Border.all(color: ColorPalette.borderGray, width: 1)
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

  void _handleState(AddAddressState state) {
    if (state.isLoading) {
      this.onWidgetDidBuild(() => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
    } else {
      this.onWidgetDidBuild(() => this.hideLoaderSnackBar(this._scaffoldKey.currentContext));
    }
    if (state.error != null) {
      this.onWidgetDidBuild(() => this.showErrorDialog(this.context, state.error));
    }
    if (state is AddAddressSuccessState) {
      this.onWidgetDidBuild(() => Navigator.of(this.context).pop(/* TODO: Maybe return something? */));
    }
  }

}