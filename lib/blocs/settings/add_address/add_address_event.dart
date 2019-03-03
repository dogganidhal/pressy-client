import 'package:equatable/equatable.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';


@immutable
abstract class AddAddressEvent extends Equatable {
  AddAddressEvent([List props]) : super(props);
}

@immutable
class UseDeviceLocationEvent extends AddAddressEvent {
  UseDeviceLocationEvent() : super([]);
}

@immutable
class SubmitAddressQueryEvent extends AddAddressEvent {

  final String query;

  SubmitAddressQueryEvent({@required this.query}) : super([query]);

}

@immutable
class ConfirmPredictionEvent extends AddAddressEvent {

  final Prediction prediction;

  ConfirmPredictionEvent({@required this.prediction}) : super([prediction]);

}

@immutable
class ConfirmAddAddressEvent extends AddAddressEvent {

  final Prediction prediction;
  final String name;
  final String extraLine;

  ConfirmAddAddressEvent({@required this.prediction, @required this.name, this.extraLine})
    : super([prediction, name, extraLine]);

}