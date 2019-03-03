import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/data/model/model.dart';


@immutable
abstract class AddressEvent extends Equatable {
  AddressEvent([List props]) : super(props);
}

@immutable
class DeleteAddressEvent extends AddressEvent {

  final int addressId;

  DeleteAddressEvent({@required this.addressId});

}

@immutable
class EditAddressEvent extends AddressEvent {

  final EditMemberAddressRequestModel editRequest;

  EditAddressEvent({@required this.editRequest});

}

@immutable
class CreateAddressEvent extends AddressEvent {

  final CreateMemberAddressDetails createRequest;

  CreateAddressEvent({@required this.createRequest});

}