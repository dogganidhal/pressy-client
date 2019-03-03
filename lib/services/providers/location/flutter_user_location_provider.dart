import 'package:pressy_client/services/providers/location/user_location_provider.dart';
import 'package:location/location.dart';


class FlutterUserLocationProvider implements IUserLocationProvider {

  final _location = new Location();

  @override
  Future<Coordinate> getUserLocation() async {
    final locationData = await this._location.getLocation();
    return new Coordinate(latitude: locationData["latitude"], longitude: locationData["longitude"]);
  }

}