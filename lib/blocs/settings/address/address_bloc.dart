import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pressy_client/blocs/settings/address/address_event.dart';
import 'package:pressy_client/blocs/settings/address/address_state.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';


class AddressBloc extends Bloc<AddressEvent, AddressState> {

  final IMemberSession memberSession;
  final IMemberDataSource memberDataSource;

  AddressBloc({@required this.memberSession, @required this.memberDataSource});

  @override
  AddressState get initialState => null;

  @override
  Stream<AddressState> mapEventToState(AddressState currentState, AddressEvent event) async* {

    // TODO: Handle errors

  }

}