import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_event.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/data_source/payment/payment_data_source.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';
import 'package:pressy_client/data/model/payment/create_credit_card/create_credit_card_request.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/errors/payment_account.dart';
import 'package:pressy_client/utils/validators/validators.dart';

class AddPaymentAccountBloc extends Bloc<AddPaymentAccountEvent, AddPaymentAccountState> {

  final IMemberSession memberSession;
  final IMemberDataSource memberDataSource;
  final IPaymentDataSource paymentDataSource;

  AddPaymentAccountBloc({
    @required this.memberDataSource, @required this.memberSession, @required this.paymentDataSource
  });

  @override
  AddPaymentAccountState get initialState => AddPaymentAccountInputState();

  @override
  Stream<AddPaymentAccountState> mapEventToState(AddPaymentAccountState currentState, AddPaymentAccountEvent event) async* {

    if (event is SubmitCreditCardEvent) {

      bool isValid = Validators.creditCardValidator(event.creditCardNumber) == null;
      isValid &= Validators.nameValidator(event.creditCardHolderName) == null;
      isValid &= Validators.expiryDateValidator(event.expiryDateString) == null;
      isValid &= Validators.cvcValidator(event.cvc) == null;

      yield AddPaymentAccountInputState(isInputValid: isValid);

    }

    if (event is ConfirmCreditCardEvent) {
      final cardExpiryComponents = event.expiryDateString.split("/");
      assert(cardExpiryComponents.length == 2);
      final request = CreateCreditCardRequestModel(
        cardExpiryMonth: cardExpiryComponents[0],
        cardExpiryYear: "20${cardExpiryComponents[1]}",
        cardNumber: event.creditCardNumber.split(" ").join(""),
        cardHolderName: event.creditCardHolderName,
        cvc: event.cvc
      );
      try {
        yield AddPaymentAccountLoadingState();
        final cardToken = await this.paymentDataSource.tokenizeCreditCard(request);
        final paymentAccount = await this.memberDataSource.addPaymentAccount(cardToken);
        print(paymentAccount.toJson().toString());
        final memberProfile = await this.memberDataSource.getMemberProfile();
        this.memberSession.persistMemberProfile(memberProfile);
        yield AddPaymentAccountSuccessState();
      } on DioError { // Tokenization failed
        yield AddPaymentAccountErrorState(error: InvalidCreditCardError());
      } on ApiError catch (error) {
        yield AddPaymentAccountErrorState(error: error);
      }
      
    }

  }

}