import 'package:meta/meta.dart';


class Coordinate {

  final double latitude;
  final double longitude;

  Coordinate({@required this.latitude, @required this.longitude});

}

abstract class IUserLocationProvider {
  Future<Coordinate> getUserLocation();
}