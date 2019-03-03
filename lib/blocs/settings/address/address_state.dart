import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
class AddressState extends Equatable {

  final bool isLoading;

  AddressState({this.isLoading = false}) : super([isLoading]);

}