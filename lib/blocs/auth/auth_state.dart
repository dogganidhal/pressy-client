import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/model.dart';

abstract class AuthState extends Equatable {
  AuthState([List props]) : super(props);
}

class AuthUninitializedState extends AuthState {

  @override
  String toString() => "Auth uninitialized";

}

class AuthUnauthenticatedState extends AuthState {

  @override
  String toString() => "Unauthenticated";

}

class AuthLoadingState extends AuthState {

  @override
  String toString() => "Auth loading";

}

class AuthAuthenticated extends AuthState {

  final AuthCredentials authCredentials;

  AuthAuthenticated({@required this.authCredentials}) : super([authCredentials]);

  @override
  String toString() => "Authenticated : ${authCredentials.toJson()}";

}
