import 'package:dio/dio.dart';
import 'package:pressy_client/data/data_source/payment/payment_data_source.dart';
import 'package:pressy_client/data/model/payment/create_credit_card/create_credit_card_request.dart';
import 'package:pressy_client/data/model/payment/credit_card_token/credit_card_token.dart';


class PaymentDataSourceDioImpl implements IPaymentDataSource {

  static const _HIPAY_TOKENIZE_ENDPOINT_URL = "https://stage-secure2-vault.hipay-tpp.com/rest/v2/token/create";
  
  @override
  Future<CreditCardTokenModel> tokenizeCreditCard(CreateCreditCardRequestModel request) async {
    final formData = FormData.from(request.toJson());
    final dio = new Dio();
    final response = await dio.post<Map<String, dynamic>>(_HIPAY_TOKENIZE_ENDPOINT_URL, data: formData);
    return new CreditCardTokenModel.fromJson(response.data);
  }

}