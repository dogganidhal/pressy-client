import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props]) : super (props);
}

class SignUpSubmitFormEvent extends SignUpEvent {

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final String passwordConfirmation;
  final bool acceptsTerms;

  SignUpSubmitFormEvent({
    @required this.firstName, @required this.email, @required this.password,
    @required this.phoneNumber, @required this.passwordConfirmation,
    @required this.acceptsTerms, @required this.lastName
  }) : super([firstName, email, phoneNumber, password, passwordConfirmation, lastName, acceptsTerms]);

  @override
  String toString() => "Sign Up form submitted";

}

class SignUpButtonPressedEvent extends SignUpEvent {

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String passwordConfirmation;

  SignUpButtonPressedEvent({
    @required this.email, @required this.password,
    @required this.firstName, @required this.phoneNumber,
    @required this.passwordConfirmation, @required this.lastName
  }) : super([email, password, phoneNumber, firstName, passwordConfirmation, lastName]);

  @override
  String toString() => "Sign up button pressed";

}