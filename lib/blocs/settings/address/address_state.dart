import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class AddressState extends Equatable {
  AddressState([List props]) : super(props);
}

@immutable
class AddressLoadingState extends Equatable {

}