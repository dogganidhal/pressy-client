import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pressy_client/data/data_source/payment/payment_data_source.dart';
import 'package:pressy_client/data/model/payment/create_credit_card/create_credit_card_request.dart';
import 'package:pressy_client/data/model/payment/credit_card_token/credit_card_token.dart';
import 'package:dio/dio.dart';

class StripePaymentDataSourceImpl implements IPaymentDataSource {

  @override
  Future<CreditCardTokenModel> tokenizeCreditCard(CreateCreditCardRequestModel request) async {
    
    final dio = Dio();
    final response = await dio.post("https://api.stripe.com/v1/tokens", 
      options: Options(
        headers: {
          "Authorization": this._authorizationHeader
        },
        contentType: ContentType.parse("application/x-www-form-urlencoded")
      ),
      data: {
        "card[number]": request.cardNumber,
        "card[exp_month]": request.cardExpiryMonth,
        "card[exp_year]": request.cardExpiryYear,
        "card[cvc]": request.cvc
      }
    );
    final json = response.data;
    final cardAlias = "XXXXXXXXXXXX${request.cardNumber.substring(12, 16)}";
    return CreditCardTokenModel(
      cardAlias: cardAlias,
      cardToken: json["id"],
      cvc: request.cvc,
      holderName: request.cardHolderName,
      expiryMonth: request.cardExpiryMonth,
      expiryYear: request.cardExpiryYear
    );
    
  }

  String get _authorizationHeader => kReleaseMode ? 
    "Basic cmtfbGl2ZV9RSFRyZDZabnZQQmRwUWx6TVhJa09DMk4wMHNONGpEc2xuOg==" :
    "Basic cmtfdGVzdF9BZjdmWWhSa283WVhYa014emlPYVlVVmcwMDJsQ1laTE9HOg==";

}