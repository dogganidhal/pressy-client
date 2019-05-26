import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/settings/member_info/member_info_bloc.dart';
import 'package:pressy_client/blocs/settings/member_info/member_info_event.dart';
import 'package:pressy_client/blocs/settings/member_info/member_info_state.dart';
import 'package:pressy_client/data/data_source/member/member_data_source.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/utils/validators/validators.dart';
import 'package:pressy_client/widgets/common/mixins/loader_mixin.dart';
import 'package:pressy_client/widgets/common/mixins/lifecycle_mixin.dart';
import 'package:pressy_client/widgets/settings/profile/reset_password_widget.dart';


class MemberInfoWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MemberInfoWidgetState();

}

class _MemberInfoWidgetState extends State<MemberInfoWidget> with LoaderMixin, WidgetLifeCycleMixin {

  MemberInfoBloc _memberInfoBloc;

  TextEditingController _firstNameFieldController = TextEditingController();
  TextEditingController _lastNameFieldController = TextEditingController();
  TextEditingController _emailFieldController = TextEditingController();
  TextEditingController _phoneNumberFieldController = TextEditingController();

  GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    this._memberInfoBloc = MemberInfoBloc(
      memberSession: ServiceProvider.of(this.context).getService<IMemberSession>(),
      memberDataSource: ServiceProvider.of(this.context).getService<IMemberDataSource>(),
    );
    this._firstNameFieldController.text = this._memberInfoBloc.currentState.firstName;
    this._lastNameFieldController.text = this._memberInfoBloc.currentState.lastName;
    this._emailFieldController.text = this._memberInfoBloc.currentState.email;
    this._phoneNumberFieldController.text = this._memberInfoBloc.currentState.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberInfoEvent, MemberInfoState>(
      bloc: this._memberInfoBloc,
      builder: (context, state) {
        this._handleState(state);
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: ColorPalette.orange),
            title: Text("Mon Profil"),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
            actions: <Widget>[
              this._actionButton(state)
            ],
          ),
          body: Container(
            key: this._scaffoldKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(16),
                      child: Form(
                          child: this._signUpForm(state is MemberInfoEditableState),
                          autovalidate: true,
                          onChanged: this._memberInfoFormChanged
                      )
                  ),
                  this._resetPasswordWidget(state)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _signUpForm(bool editable) => Column(
    children: <Widget>[
      this._nameFieldRow(editable),
      this._emailField(editable),
      this._phoneField(editable),
    ],
  );

  Widget _resetPasswordWidget(MemberInfoState state) => state is MemberInfoUneditableState ?
    FlatButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordWidget()
        )
      ),
      child: Text(
        "Réinitialiser mon mot de passe",
        style: TextStyle(
          color: ColorPalette.orange,
          fontWeight: FontWeight.w600
        ),
      )
    ) : Container();

  Widget _nameFieldRow(bool editable) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Flexible(
        child: Container(
            padding: EdgeInsets.only(right: 6),
            child: this._lastNameField(editable)
        ),
      ),
      Flexible(
          child: Container(
              padding: EdgeInsets.only(left: 6),
              child: this._firstNameField(editable)
          )
      )
    ],
  );

  Widget _lastNameField(bool editable) => TextFormField(
    controller: this._firstNameFieldController,
    decoration: InputDecoration(
        labelText: "Nom",
        helperText: "Votre nom"
    ),
    keyboardType: TextInputType.text,
    validator: Validators.nameValidator,
    textCapitalization: TextCapitalization.words,
    enabled: editable,
  );

  Widget _firstNameField(bool editable) => TextFormField(
    controller: this._lastNameFieldController,
    decoration: InputDecoration(
        labelText: "Prénom",
        helperText: "Votre prénom"
    ),
    keyboardType: TextInputType.text,
    validator: Validators.nameValidator,
    textCapitalization: TextCapitalization.words,
    enabled: editable,
  );

  Widget _emailField(bool editable) => TextFormField(
    controller: this._emailFieldController,
    decoration: InputDecoration(
      helperText: "Votre email sera utilisé pour vous identifier",
      labelText: "Email",
    ),
    validator: Validators.emailValidator,
    keyboardType: TextInputType.emailAddress,
    enabled: editable,
  );

  Widget _phoneField(bool editable) => TextFormField(
    controller: this._phoneNumberFieldController,
    decoration: InputDecoration(
      helperText: "Votre téléphone sera utilisé pour vous contacter",
      labelText: "Numéro de téléphone",
    ),
    validator: Validators.phoneNumberValidator,
    keyboardType: TextInputType.phone,
    enabled: editable,
  );

  Widget _actionButton(MemberInfoState state) {
    if (state is MemberInfoUneditableState) {
      return FlatButton.icon(
        onPressed: () => this._memberInfoBloc.dispatch(MemberInfoBeginEditingEvent()),
        icon: Icon(Icons.edit, color: ColorPalette.orange),
        label: Container()
      );
    } else if (state is MemberInfoEditableState) {
      return FlatButton.icon(
          onPressed: state.isValid ? () => this._memberInfoBloc.dispatch(MemberInfoConfirmEditingEvent(
            firstName: this._firstNameFieldController.text,
            lastName: this._lastNameFieldController.text,
            email: this._emailFieldController.text,
            phone: this._phoneNumberFieldController.text,
          )) : null,
          icon: Icon(Icons.check),
          label: Container()
      );
    } else 
      return Container();
  }

  void _memberInfoFormChanged() {
    this._memberInfoBloc.dispatch(MemberInfoSubmitEvent(
      email: this._emailFieldController.text,
      firstName: this._firstNameFieldController.text,
      lastName: this._lastNameFieldController.text,
      phone: this._phoneNumberFieldController.text
    ));
  }

  void _handleState(MemberInfoState state) {
    if (state is MemberInfoEditableState) {
      if (state.isLoading)
        this.onWidgetDidBuild(() => this.showLoaderSnackBar(this._scaffoldKey.currentContext));
      else
        this.onWidgetDidBuild(() => this.hideLoaderSnackBar(this._scaffoldKey.currentContext));
    }
    if (state is MemberInfoEditingSuccessfulState) {
      Navigator.pop(this.context);
    }
  }

}