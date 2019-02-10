import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pressy_client/data/model/errors/api_error.dart';
import 'package:pressy_client/widgets/common/layouts/modal.dart';


mixin ErrorMixin {

  bool isErrorModalActive = false;

  Widget errorWidget(ApiError error) => new Modal(
      title: "Erreur",
      child: new Container(
        margin: new EdgeInsets.only(bottom: 16),
        child: new Text(
          error.message,
          style: new TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        new ModalAction(
          title: "OK",
          callback: null
        )
      ],
    );

  void showErrorDialog(BuildContext context, ApiError error) {
    this.isErrorModalActive = true;
    showDialog(
      context: context,
      builder: (context) => this.errorWidget(error)
    );
  }

  void hideErrorDialog(BuildContext context) {
    if (this.isErrorModalActive) {
      Navigator.of(context, rootNavigator: true).pop();
      this.isErrorModalActive = false;
    }
  }

}