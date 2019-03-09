import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/utils/errors/base_error.dart';


@immutable
abstract class AddPaymentAccountState extends Equatable {
  AddPaymentAccountState([List props]) : super(props);
}

@immutable
class AddPaymentAccountInputState extends AddPaymentAccountState {

  final bool isInputValid;

  AddPaymentAccountInputState({this.isInputValid = false}) : super([isInputValid]);
}

@immutable
class AddPaymentAccountErrorState extends AddPaymentAccountState {

  final AppError error;

  AddPaymentAccountErrorState({@required this.error}) : super([error]);
}

@immutable
class AddPaymentAccountLoadingState extends AddPaymentAccountState {
  AddPaymentAccountLoadingState() : super([]);
}

@immutable
class AddPaymentAccountSuccessState extends AddPaymentAccountState {
  AddPaymentAccountSuccessState() : super([]);
}