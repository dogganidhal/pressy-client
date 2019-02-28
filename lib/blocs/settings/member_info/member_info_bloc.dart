import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/settings/member_info/member_info_event.dart';
import 'package:pressy_client/blocs/settings/member_info/member_info_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/utils/validators/validators.dart';


class MemberInfoBloc extends Bloc<MemberInfoEvent, MemberInfoState> {

  final IMemberSession memberSession;
  final IMemberDataSource memberDataSource;

  MemberInfoBloc({@required this.memberSession, @required this.memberDataSource});

  @override
  MemberInfoState get initialState => new MemberInfoUneditableState(
    this.memberSession.connectedMemberProfile.email,
    this.memberSession.connectedMemberProfile.firstName,
    this.memberSession.connectedMemberProfile.lastName,
    this.memberSession.connectedMemberProfile.phone
  );

  @override
  Stream<MemberInfoState> mapEventToState(MemberInfoState currentState, MemberInfoEvent event) async* {

    // TODO: Handle errors

    if (event is MemberInfoDiscardEditingEvent && currentState is MemberInfoEditableState) {
      yield this.initialState;
    }

    if (event is MemberInfoBeginEditingEvent && currentState is MemberInfoUneditableState) {

      yield new MemberInfoEditableState(
        currentState.email, currentState.firstName,
        currentState.lastName, currentState.phone, true, false
      );

    }

    if (event is MemberInfoSubmitEvent && currentState is MemberInfoEditableState) {

      bool isValid = Validators.emailValidator(event.email) == null;
      isValid &= Validators.phoneNumberValidator(event.phone) == null;
      isValid &= Validators.nameValidator(event.firstName) == null;
      isValid &= Validators.nameValidator(event.lastName) == null;

      yield new MemberInfoEditableState(
        currentState.email, currentState.firstName, currentState.lastName,
        currentState.phone, isValid, false
      );

    }

    if (event is MemberInfoConfirmEditingEvent && currentState is MemberInfoEditableState) {

      assert(currentState.isValid);

      yield new MemberInfoEditableState(
          currentState.email, currentState.firstName, currentState.lastName,
          currentState.phone, true, true
      );

      var editMemberProfileRequest = new EditMemberProfileRequestModel(
        email: event.email, phone: event.phone, firstName: event.firstName,
        lastName: event.lastName
      );
      await this.memberDataSource.editMemberProfile(editMemberProfileRequest);
      yield new MemberInfoEditingSuccessfulState();

    }

  }

}