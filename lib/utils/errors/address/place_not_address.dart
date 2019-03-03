import 'package:pressy_client/utils/errors/base_error.dart';


class PlaceIsNotAddressError implements AppError {

  @override
  String get message => "L'endroit que vous avez choisi n'est pas une adresse, veuillez choisir une adresse exacte poir éviter tout dérangement.";

  @override
  String get title => "Endroit non précis";

  @override
  int get statusCode => null;

}