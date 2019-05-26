import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_event.dart';
import 'package:pressy_client/blocs/auth/sign_up/sign_up_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/validators/validators.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  final AuthBloc authBloc;
  final IMemberDataSource memberDataSource;
  final IMemberSession memberSession;

  SignUpBloc({
    @required this.authBloc, @required this.memberDataSource, 
    @required this.memberSession
  });
  
  @override
  SignUpState get initialState => SignUpInitialState();

  @override
  Stream<SignUpState> mapEventToState(SignUpState currentState, SignUpEvent event) async* {
    
    if (event is SignUpSubmitFormEvent) {

      bool isValid = event.acceptsTerms;

      isValid &= Validators.nameValidator(event.firstName) == null;
      isValid &= Validators.nameValidator(event.lastName) == null;
      isValid &= Validators.emailValidator(event.email) == null;
      isValid &= Validators.phoneNumberValidator(event.phoneNumber) == null;
      isValid &= Validators.newPasswordValidator(event.password) == null;
      isValid &= Validators.passwordConfirmationValidator(event.password, event.passwordConfirmation) == null;

      yield SignUpInitialState(isValid: isValid);
      
    }

    if (event is SignUpButtonPressedEvent) {

      yield SignUpLoadingState();

      try {

        var signUpRequest = SignUpRequestModel(
          email: event.email, password: event.password, firstName: event.firstName,
          lastName: event.lastName, phoneNumber: event.phoneNumber
        );
        var authCredentials = await this.memberDataSource.signUp(signUpRequest);
        this.authBloc.dispatch(AuthLoggedInEvent(
          authCredentials: authCredentials,
        ));
        yield SignUpSuccessState();

      } on ApiError catch (error) {
        yield SignUpFailureState(error: error);
      }

    }


  }
  
}