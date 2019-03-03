import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class MemberInfoState extends Equatable {

  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  MemberInfoState(this.email, this.firstName, this.lastName, this.phone, [List props])
    : super([email, firstName, lastName, phone]..addAll(props ?? []));

}

class MemberInfoUneditableState extends MemberInfoState {

  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final String email;

  @override
  final String phone;

  MemberInfoUneditableState(this.email, this.firstName, this.lastName, this.phone)
    : super(email, firstName, lastName, phone);

}

class MemberInfoEditableState extends MemberInfoState {

  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final String email;

  @override
  final String phone;

  final bool isValid;

  final bool isLoading;

  MemberInfoEditableState(this.email, this.firstName, this.lastName, this.phone, this.isValid, this.isLoading)
    : super(email, firstName, lastName, phone, [isValid, isLoading]);

}

class MemberInfoEditingSuccessfulState extends MemberInfoState {

  @override
  final String firstName;

  @override
  final String lastName;

  @override
  final String email;

  @override
  final String phone;

  MemberInfoEditingSuccessfulState()
    : firstName = null, lastName = null, email = null, phone = null,
      super(null, null, null, null);
}