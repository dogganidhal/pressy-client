import 'package:pressy_client/services/providers/location/user_location_provider.dart';
import 'package:location/location.dart';


class FlutterUserLocationProvider implements IUserLocationProvider {

  final _location = Location();

  @override
  Future<Coordinate> getUserLocation() async {
    final locationData = await this._location.getLocation();
    return Coordinate(latitude: locationData["latitude"], longitude: locationData["longitude"]);
  }

}