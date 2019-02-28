import 'package:meta/meta.dart';
import 'package:pressy_client/data/data_source/payment/payment_data_source.dart';
import 'package:pressy_client/data/model/payment/create_credit_card/create_credit_card_request.dart';
import 'package:pressy_client/data/model/payment/credit_card_token/credit_card_token.dart';
import 'package:pressy_client/utils/network/base_client.dart';


class PaymentDataSourceImpl implements IPaymentDataSource {

  static const _HIPAY_TOKENIZE_ENDPOINT_URL = "https://stage-secure2-vault.hipay-tpp.com/rest/v2/token/create";

  final IClient client;

  PaymentDataSourceImpl({@required this.client});

  @override
  Future<CreditCardTokenModel> tokenizeCreditCard(CreateCreditCardRequestModel request) {
    return null;
  }

}