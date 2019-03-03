import 'package:equatable/equatable.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';


@immutable
abstract class AddAddressState extends Equatable {
  AddAddressState([List props]) : super(props);
}

@immutable
class AddAddressInputState extends AddAddressState {

  final List<Prediction> predictions;

  AddAddressInputState({@required this.predictions}) : super([predictions]);

}

@immutable
class AddAddressExtraInfoState extends AddAddressState {

  final Prediction confirmedPrediction;

  AddAddressExtraInfoState({@required this.confirmedPrediction}) : super([confirmedPrediction]);

}

@immutable
class AddAddressSuccessState extends AddAddressState {
  AddAddressSuccessState() : super([]);
}