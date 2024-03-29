import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_bloc.dart';
import 'package:pressy_client/blocs/auth/auth_event.dart';
import 'package:pressy_client/blocs/auth/auth_state.dart';
import 'package:pressy_client/data/session/member/member_session.dart';
import 'package:pressy_client/services/di/service_collection.dart';
import 'package:pressy_client/services/di/service_provider.dart';
import 'package:pressy_client/utils/style/app_theme.dart';
import 'package:pressy_client/widgets/auth/auth_widget.dart';
import 'package:pressy_client/widgets/home/home_widget.dart';

class Application extends StatelessWidget with AppThemeMixin {

  final AuthBloc authBloc;
  final IServiceCollection services;

  Application({@required this.services}) :
      assert(services != null),
      authBloc = AuthBloc(services: services) {
    this.authBloc.dispatch(AuthAppStartedEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale("fr-FR"),
      title: 'Pressy',
      theme: this.appThemeData,
      debugShowCheckedModeBanner: false,
      home: ServiceProvider(
        services: this.services,
        child: BlocProvider<AuthBloc>(
          bloc: this.authBloc,
          child: BlocBuilder<AuthEvent, AuthState>(
            bloc: this.authBloc,
            builder: (BuildContext context, AuthState state) {
              if (state is AuthLoadingState) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return state is AuthAuthenticated ? HomeWidget() : AuthWidget(
                authBloc: this.authBloc,
                memberSession: this.services.getService<IMemberSession>(),
              );
            },

          ),
        ),
      ),
    );
  }

}