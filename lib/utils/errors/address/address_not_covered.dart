import 'package:pressy_client/utils/errors/base_error.dart';


class AddressNotCoveredError implements AppError {

  @override
  String get message =>
    "Veuillez choisir une adresse à Paris";

  @override
  String get title => "Addresse non supportée";

  @override
  int get statusCode => null;

}