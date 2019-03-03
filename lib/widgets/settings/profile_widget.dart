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
import 'package:pressy_client/widgets/settings/reset_password_widget.dart';


class MemberInfoWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _MemberInfoWidgetState();

}

class _MemberInfoWidgetState extends State<MemberInfoWidget> with LoaderMixin, WidgetLifeCycleMixin {

  MemberInfoBloc _memberInfoBloc;

  TextEditingController _firstNameFieldController = new TextEditingController();
  TextEditingController _lastNameFieldController = new TextEditingController();
  TextEditingController _emailFieldController = new TextEditingController();
  TextEditingController _phoneNumberFieldController = new TextEditingController();

  GlobalKey _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    this._memberInfoBloc = new MemberInfoBloc(
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
    return new BlocBuilder<MemberInfoEvent, MemberInfoState>(
      bloc: this._memberInfoBloc,
      builder: (context, state) {
        this._handleState(state);
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Mon Profil"),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
            actions: <Widget>[
              this._actionButton(state)
            ],
          ),
          body: new Container(
            key: this._scaffoldKey,
            child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.all(16),
                      child: new Form(
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

  Widget _signUpForm(bool editable) => new Column(
    children: <Widget>[
      this._nameFieldRow(editable),
      this._emailField(editable),
      this._phoneField(editable),
    ],
  );

  Widget _resetPasswordWidget(MemberInfoState state) => state is MemberInfoUneditableState ?
    new FlatButton(
      onPressed: () => Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ResetPasswordWidget()
        )
      ),
      child: new Text(
        "Réinitialiser mon mot de passe",
        style: new TextStyle(
          color: ColorPalette.orange,
          fontWeight: FontWeight.w600
        ),
      )
    ) : new Container();

  Widget _nameFieldRow(bool editable) => new Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      new Flexible(
        child: new Container(
            padding: new EdgeInsets.only(right: 6),
            child: this._lastNameField(editable)
        ),
      ),
      new Flexible(
          child: new Container(
              padding: new EdgeInsets.only(left: 6),
              child: this._firstNameField(editable)
          )
      )
    ],
  );

  Widget _lastNameField(bool editable) => new TextFormField(
    controller: this._firstNameFieldController,
    decoration: new InputDecoration(
        labelText: "Nom",
        helperText: "Votre nom"
    ),
    keyboardType: TextInputType.text,
    validator: Validators.nameValidator,
    textCapitalization: TextCapitalization.words,
    enabled: editable,
  );

  Widget _firstNameField(bool editable) => new TextFormField(
    controller: this._lastNameFieldController,
    decoration: new InputDecoration(
        labelText: "Prénom",
        helperText: "Votre prénom"
    ),
    keyboardType: TextInputType.text,
    validator: Validators.nameValidator,
    textCapitalization: TextCapitalization.words,
    enabled: editable,
  );

  Widget _emailField(bool editable) => new TextFormField(
    controller: this._emailFieldController,
    decoration: new InputDecoration(
      helperText: "Votre email sera utilisé pour vous identifier",
      labelText: "Email",
    ),
    validator: Validators.emailValidator,
    keyboardType: TextInputType.emailAddress,
    enabled: editable,
  );

  Widget _phoneField(bool editable) => new TextFormField(
    controller: this._phoneNumberFieldController,
    decoration: new InputDecoration(
      helperText: "Votre téléphone sera utilisé pour vous contacter",
      labelText: "Numéro de téléphone",
    ),
    validator: Validators.phoneNumberValidator,
    keyboardType: TextInputType.phone,
    enabled: editable,
  );

  Widget _actionButton(MemberInfoState state) {
    if (state is MemberInfoUneditableState) {
      return new FlatButton.icon(
        onPressed: () => this._memberInfoBloc.dispatch(new MemberInfoBeginEditingEvent()),
        icon: new Icon(Icons.edit), 
        label: new Container()
      );
    } else if (state is MemberInfoEditableState) {
      return new FlatButton.icon(
          onPressed: state.isValid ? () => this._memberInfoBloc.dispatch(new MemberInfoConfirmEditingEvent(
            firstName: this._firstNameFieldController.text,
            lastName: this._lastNameFieldController.text,
            email: this._emailFieldController.text,
            phone: this._phoneNumberFieldController.text,
          )) : null,
          icon: new Icon(Icons.check),
          label: new Container()
      );
    } else 
      return new Container();
  }

  void _memberInfoFormChanged() {
    this._memberInfoBloc.dispatch(new MemberInfoSubmitEvent(
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