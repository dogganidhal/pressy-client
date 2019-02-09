import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';


@immutable
abstract class LoginState extends Equatable {
  LoginState([List props]) : super(props);
}

@immutable
class LoginSuccessState extends LoginState {

  @override
  String toString() => "Login Success";

}

@immutable
class LoginLoadingState extends LoginState {

  @override
  String toString() => "Login loading";

}

@immutable
class LoginInitialState extends LoginState {

  final bool isValid;

  LoginInitialState({this.isValid = false}) : super([isValid]);

  @override
  String toString() => "Login initial state : is valid : $isValid";

}

@immutable
class LoginFailureState extends LoginState {

  final ApiError error;

  LoginFailureState({@required this.error}) : super([error]);

  @override
  String toString() => "Login error state: $error";

}