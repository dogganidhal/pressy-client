import 'package:pressy_client/utils/errors/base_error.dart';

class InvalidCouponError implements AppError {
  @override
  String get message =>
      "Le code de coupon que vous avez entré n'est pas valide, s'il vous plaît vérifier";

  @override
  int get statusCode => null;

  @override
  String get title => "Code de Coupon Invalide";
}
