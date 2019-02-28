import 'package:pressy_client/data/model/payment/create_credit_card/create_credit_card_request.dart';
import 'package:pressy_client/data/model/payment/credit_card_token/credit_card_token.dart';


abstract class IPaymentDataSource {

  Future<CreditCardTokenModel> tokenizeCreditCard(CreateCreditCardRequestModel request);

}