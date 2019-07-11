import 'package:equatable/equatable.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/utils/errors/base_error.dart';

@immutable
abstract class AddAddressState extends Equatable {
  final AppError error;
  final bool isLoading;

  AddAddressState(this.isLoading, this.error, [List props])
      : super([isLoading, error]..addAll(props ?? []));
}

@immutable
class AddAddressInputState extends AddAddressState {
  @override
  final bool isLoading;

  @override
  final AppError error;

  final List<Prediction> predictions;

  AddAddressInputState(
      {@required this.predictions, this.isLoading = false, this.error})
      : super(isLoading, error, [predictions]);
}

@immutable
class AddAddressExtraInfoState extends AddAddressState {
  @override
  final AppError error;

  @override
  final bool isLoading;

  final Prediction confirmedPrediction;

  AddAddressExtraInfoState(
      {@required this.confirmedPrediction, this.isLoading = false, this.error})
      : super(isLoading, error, [confirmedPrediction]);
}

@immutable
class AddAddressSuccessState extends AddAddressState {
  AddAddressSuccessState() : super(false, null);
}
