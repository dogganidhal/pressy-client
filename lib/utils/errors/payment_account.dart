import 'package:pressy_client/utils/errors/base_error.dart';


class InvalidCreditCardError implements AppError {
  
  @override
  String get message => "Le numéro de la carte bancaire que vous avez introduit n'est pas valide, veuillez vérifier";

  @override
  int get statusCode => null;

  @override
  String get title => "Carte bancaire invalide";

}