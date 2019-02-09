import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/model.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props]) : super (props);
}

class AuthAppStartedEvent extends AuthEvent {

  @override
  String toString() => "App started";

}

class AuthLoggedInEvent extends AuthEvent {

  final AuthCredentials authCredentials;

  AuthLoggedInEvent({@required this.authCredentials}) : super([authCredentials]);

  @override
  String toString() => "Logged in event : ${authCredentials.toJson()}";

}

class AuthLoggedOutEvent extends AuthEvent {

  @override
  String toString() => "Logged out event";

}