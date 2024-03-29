import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_event.dart';
import 'package:pressy_client/blocs/settings/add_address/add_address_state.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/providers/location/user_location_provider.dart';
import 'package:pressy_client/utils/errors/address/address_not_covered.dart';
import 'package:pressy_client/utils/errors/address/place_not_address.dart';
import 'package:pressy_client/utils/errors/base_error.dart';
import 'package:pressy_client/utils/network/http_client.dart';
import 'package:uuid/uuid.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final IMemberSession memberSession;
  final IMemberDataSource memberDataSource;
  final IUserLocationProvider userLocationProvider;

  static const _kGooglePlacesApiKey = "AIzaSyAfTv8yb7lNverE7jxCk2ZQgMQQRVodIvI";
  final _googlePlacesAutocomplete =
      GoogleMapsPlaces(apiKey: _kGooglePlacesApiKey, httpClient: HttpClient());
  final _googlePlacesGeoCoder = GoogleMapsGeocoding(
      apiKey: _kGooglePlacesApiKey, httpClient: HttpClient());
  String _sessionToken;

  AddAddressBloc(
      {@required this.memberDataSource,
      @required this.memberSession,
      @required this.userLocationProvider});

  @override
  AddAddressState get initialState => AddAddressInputState(predictions: []);

  @override
  Stream<AddAddressState> mapEventToState(
      AddAddressState currentState, AddAddressEvent event) async* {
    if (event is UseDeviceLocationEvent &&
        currentState is AddAddressInputState) {
      yield AddAddressInputState(
          predictions: currentState.predictions, isLoading: true);
      final coordinates = await this.userLocationProvider.getUserLocation();
      final result = await this._googlePlacesGeoCoder.searchByLocation(
          Location(coordinates.latitude, coordinates.longitude));
      final place = result.results.first;
      final prediction = Prediction(
          place.formattedAddress, null, [], place.placeId, null, [], [], null);
      yield AddAddressExtraInfoState(confirmedPrediction: prediction);
    }

    if (event is SubmitAddressQueryEvent &&
        currentState is AddAddressInputState) {
      if (this._sessionToken == null) _sessionToken = Uuid().v4();
      final predictions = await this._googlePlacesAutocomplete.autocomplete(
          event.query,
          sessionToken: _sessionToken,
          strictbounds: true,
          location: Location(48.8639135, 2.3420433),
          radius: 10000,
          language: "FR",
          types: ["address"]);
      yield AddAddressInputState(predictions: predictions.predictions);
    }

    if (event is ConfirmPredictionEvent &&
        currentState is AddAddressInputState) {
      try {
        final details = await this
            ._googlePlacesAutocomplete
            .getDetailsByPlaceId(event.prediction.placeId,
                sessionToken: this._sessionToken);
        this._checkPlaceDetails(details.result);

        this._sessionToken = null;
        yield AddAddressExtraInfoState(confirmedPrediction: event.prediction);
      } on AppError catch (error) {
        yield AddAddressInputState(
            predictions: currentState.predictions, error: error);
      }
    }

    if (event is ConfirmAddAddressEvent &&
        currentState is AddAddressExtraInfoState) {
      yield AddAddressExtraInfoState(
          confirmedPrediction: currentState.confirmedPrediction,
          isLoading: true);
      await this.memberDataSource.createMemberAddress(
          CreateMemberAddressDetails(
              googlePlaceId: event.prediction.placeId,
              name: event.name,
              extraLine: event.extraLine));
      final memberProfile = await this.memberDataSource.getMemberProfile();
      await this.memberSession.persistMemberProfile(memberProfile);
      yield AddAddressSuccessState();
    }
  }

  void _checkPlaceDetails(PlaceDetails placeDetails) {
    final postalCodeComponent = placeDetails.addressComponents.firstWhere(
        (component) => component.types.contains("postal_code"),
        orElse: () => null);

    if (postalCodeComponent == null) throw PlaceIsNotAddressError();

    if (!postalCodeComponent.shortName.startsWith("75"))
      throw AddressNotCoveredError();
  }
}
