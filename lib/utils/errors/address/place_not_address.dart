import 'package:pressy_client/utils/errors/base_error.dart';


class PlaceIsNotAddressError implements AppError {

  @override
  String get message => "Veuillez choisir une adresse exacte.";

  @override
  String get title => "Endroit non précis";

  @override
  int get statusCode => null;

}