import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';

@immutable
abstract class SignUpState extends Equatable {
  SignUpState([List props]) : super(props);
}

@immutable
class SignUpSuccessState extends SignUpState {

  @override
  String toString() => "Sign Up Succeeded";

}

@immutable
class SignUpFailureState extends SignUpState {

  final ApiError error;

  SignUpFailureState({this.error}) : super([error]);

  @override
  String toString() => "Sign Up failed state: $error";

}

@immutable
class SignUpInitialState extends SignUpState {

  final bool isValid;

  SignUpInitialState({this.isValid = false}) : super([isValid]);

  @override
  String toString() => "Sign Up initial state, isValid : $isValid";

}

@immutable
class SignUpLoadingState extends SignUpState {

  @override
  String toString() => "Sign Up loading state";

}