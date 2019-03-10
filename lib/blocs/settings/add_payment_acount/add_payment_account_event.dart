import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class AddPaymentAccountEvent extends Equatable {
  AddPaymentAccountEvent([List props]) : super(props);
}

@immutable
class SubmitCreditCardEvent extends AddPaymentAccountEvent {

  final String creditCardNumber;
  final String creditCardHolderName;
  final String expiryDateString;
  final String cvc;

  SubmitCreditCardEvent({
    @required this.creditCardNumber, @required this.cvc, @required this.creditCardHolderName,
    @required this.expiryDateString
  }) : super([creditCardNumber, cvc, creditCardHolderName, creditCardNumber]);

}

@immutable
class ConfirmCreditCardEvent extends AddPaymentAccountEvent {

  final String creditCardNumber;
  final String creditCardHolderName;
  final String expiryDateString;
  final String cvc;

  ConfirmCreditCardEvent({
    @required this.creditCardNumber, @required this.cvc, @required this.creditCardHolderName,
    @required this.expiryDateString
  }) : super([creditCardNumber, cvc, creditCardHolderName, creditCardNumber]);

}