import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class MemberInfoEvent extends Equatable {
  MemberInfoEvent([List props]) : super(props);
}

class MemberInfoBeginEditingEvent extends MemberInfoEvent { }

class MemberInfoDiscardEditingEvent extends MemberInfoEvent { }

class MemberInfoSubmitEvent extends MemberInfoEvent {

  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  MemberInfoSubmitEvent({this.firstName, this.lastName, this.email, this.phone});

}

class MemberInfoConfirmEditingEvent extends MemberInfoEvent {

  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  MemberInfoConfirmEditingEvent({this.firstName, this.lastName, this.email, this.phone});

}