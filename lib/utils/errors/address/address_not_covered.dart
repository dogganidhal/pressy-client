import 'package:pressy_client/utils/errors/base_error.dart';


class AddressNotCoveredError implements AppError {

  @override
  String get message =>
    "Cette adresse n'est pas dans une région couverte par notre service, "
    "si cette dernière est dans Paris, veuillez prendre contact avec notre "
    "service client";

  @override
  String get title => "Addresse non supportée";

  @override
  int get statusCode => null;

}