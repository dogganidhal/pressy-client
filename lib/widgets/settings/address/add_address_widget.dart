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
import 'package:pressy_client/services/providers/location/user_location_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/error_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';

class AddAddressWidget extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _AddAddressWidgetState();

}


class _AddAddressWidgetState extends State<AddAddressWidget>
  with LoaderMixin, WidgetLifeCycleMixin, ErrorMixin {

  AddAddressBloc _addAddressBloc;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _addressNameController = TextEditingController();
  TextEditingController _extraLineController = TextEditingController();
  GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    this._addAddressBloc = AddAddressBloc(
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>(),
      userLocationProvider: ServiceProvider.of(this.context).getService<IUserLocationProvider>()
    );
    this._addressController.addListener(() {
      final query = this._addressController.text;
      if (query != null && query.isNotEmpty && query.length > 1)
        this._addAddressBloc.dispatch(SubmitAddressQueryEvent(query: query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.orange),
        elevation: 1,
        title: Text("Ajouter une adresse"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AddAddressEvent, AddAddressState>(
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
              widget = Container();
            return widget;
          },
        )
      ),
    );
  }

  Widget _addressExtraInfoWidget(AddAddressExtraInfoState state) => Container(
    padding: EdgeInsets.all(12),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Adresse",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: state.confirmedPrediction.description,
                  enabled: false,
                ),
                TextFormField(
                  controller: this._addressNameController,
                  decoration: InputDecoration(
                    labelText: "Alias de l'adresse",
                    helperText: "Ex : Maison, Travail ..."
                  ),
                  keyboardType: TextInputType.text,
                ),
                TextFormField(
                  controller: this._extraLineController,
                  decoration: InputDecoration(
                    labelText: "Informations supplémentaires",
                    helperText: "Ex : Etage, Batiment ..."
                  ),
                  keyboardType: TextInputType.text,
                )
              ],
            ),
          )
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorPalette.orange
                  ),
                  height: 48,
                  child: ButtonTheme(
                    height: double.infinity,
                    child: FlatButton(
                      textColor: Colors.white,
                      disabledTextColor: Colors.white,
                      onPressed: () => this._addAddressBloc
                        .dispatch(ConfirmAddAddressEvent(
                          prediction: state.confirmedPrediction,
                          name: this._addressNameController.text.isNotEmpty ? this._addressNameController.text : null,
                          extraLine: this._extraLineController.text.isNotEmpty ? this._extraLineController.text : null
                        )),
                      child: Text("Valider".toUpperCase()),
                    ),
                  ),
                )
            )
          ],
        )
      ],
    ),
  );

  Widget _addressInputWidget(AddAddressInputState state) => Container(
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: ColorPalette.borderGray, width: 1)
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Saisissez une adresse, quartier, arrondissement...",
                      hintStyle: TextStyle(fontWeight: FontWeight.w600)
                    ),
                    controller: this._addressController,
                  ),
                ),
                GestureDetector(
                  child: Icon(Icons.location_on, color: ColorPalette.orange),
                  onTap: () => this._addAddressBloc.dispatch(UseDeviceLocationEvent()),
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
  Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorPalette.borderGray, width: 1)
    ),
    child: ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) =>  Divider(),
      itemBuilder: (BuildContext context, int index) {
        return index == predictions.length ? PoweredByGoogleImage() : FlatButton(
          onPressed: () => this._addAddressBloc
            .dispatch(ConfirmPredictionEvent(prediction: predictions[index])),
          child: Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                predictions[index].description,
                textAlign: TextAlign.start
              )
            )
          ),
        );
      },
      itemCount: predictions.length + 1,
    )
  ) : Container();

  void _handleState(AddAddressState state) {
    if (state.isLoading) {
      this.onWidgetDidBuild(() => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
    } else {
      this.onWidgetDidBuild(() => this.hideLoaderSnackBar(this._scaffoldKey.currentContext));
    }
    if (state.error != null) {
      this.onWidgetDidBuild(() => this.showErrorDialog(this._scaffoldKey.currentContext, state.error));
    }
    if (state is AddAddressSuccessState) {
      this.onWidgetDidBuild(() => Navigator.of(this.context).pop(/* TODO: Maybe return something? */));
    }
  }

}