import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_event.dart';
import 'package:pressy_client/blocs/settings/add_payment_acount/add_payment_account_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/validators/validators.dart';

class AddPaymentAccountBloc extends Bloc<AddPaymentAccountEvent, AddPaymentAccountState> {

  final IMemberSession memberSession;
  final IMemberDataSource memberDataSource;

  AddPaymentAccountBloc({
    @required this.memberDataSource, @required this.memberSession,
  });

  @override
  AddPaymentAccountState get initialState => new AddPaymentAccountInputState();

  @override
  Stream<AddPaymentAccountState> mapEventToState(AddPaymentAccountState currentState, AddPaymentAccountEvent event) async* {

    if (event is SubmitCreditCardEvent) {

      bool isValid = Validators.creditCardValidator(event.creditCardNumber) == null;
      isValid &= Validators.nameValidator(event.creditCardHolderName) == null;
      isValid &= Validators.expiryDateValidator(event.expiryDateString) == null;
      isValid &= Validators.cvcValidator(event.cvc) == null;

      yield new AddPaymentAccountInputState(isInputValid: isValid);

    }

  }

}