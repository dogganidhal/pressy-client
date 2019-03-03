import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_event.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_state.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pressy_client/blocs/settings/address/address_bloc.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/utils/network/http_client.dart';
import 'package:uuid/uuid.dart';


class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {

  final IMemberDataSource memberDataSource;
  final AddressBloc addressBloc;

  static const _kGooglePlacesApiKey = "AIzaSyAfTv8yb7lNverE7jxCk2ZQgMQQRVodIvI";
  final _googlePlacesAutocomplete = new GoogleMapsPlaces(apiKey: _kGooglePlacesApiKey, httpClient: new HttpClient());
  String _sessionToken;

  AddAddressBloc({@required this.memberDataSource, @required this.addressBloc});

  @override
  AddAddressState get initialState => new AddAddressInputState(predictions: []);

  @override
  Stream<AddAddressState> mapEventToState(AddAddressState currentState, AddAddressEvent event) async* {

    if (event is SubmitAddressQueryEvent) {
      if (this._sessionToken == null)
        _sessionToken = Uuid().v4();
      final predictions = await this._googlePlacesAutocomplete.autocomplete(
        event.query,
        sessionToken: _sessionToken,
        strictbounds: true,
        location: new Location(48.8639135, 2.3420433),
        radius: 30000,
      );
      yield new AddAddressInputState(predictions: predictions.predictions);
    }

    if (event is ConfirmPredictionEvent) {
      final details = await this._googlePlacesAutocomplete.getDetailsByPlaceId(event.prediction.placeId, sessionToken: this._sessionToken);
      final postalCodeComponent = details.result.addressComponents.singleWhere((component) => component.types.contains("postal_code"));
      this._sessionToken = null;
      if (!postalCodeComponent.longName.startsWith("75")) {
        throw new Exception();
      }
      yield new AddAddressExtraInfoState(confirmedPrediction: event.prediction);
    }

  }

}