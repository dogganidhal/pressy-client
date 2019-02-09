import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props]) : super (props);
}

class LoginButtonPressedEvent extends LoginEvent {

  final String email;
  final String password;

  LoginButtonPressedEvent({@required this.email, @required this.password}) 
    : assert(email != null && password != null), super([email, password]);

  @override
  String toString() => "Login button pressed, email : $email, password : $password";

}

class LoginSubmitFormEvent extends LoginEvent {

  final String email;
  final String password;

  LoginSubmitFormEvent({@required this.email, @required this.password}) : super([email, password]);

  @override
  String toString() => "Login submit form with email : $email and password : $password";

}