import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pressy_client/utils/errors/base_error.dart';
import 'package:pressy_client/widgets/common/layouts/modal.dart';


mixin ErrorMixin {

  bool _isErrorModalActive = false;

  Widget errorWidget(BuildContext context, AppError error) => new Modal(
      title: error.title ?? "Erreur",
      child: new Container(
        margin: new EdgeInsets.only(bottom: 16),
        child: new Text(
          error.message,
          style: Theme.of(context)
            .textTheme
            .body1
            .copyWith(
              color: Colors.grey,
              fontSize: 14
            ),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        new ModalAction(
          title: "OK",
          callback: () => this._isErrorModalActive = false
        )
      ],
    );

  void showErrorDialog(BuildContext context, AppError error) {
    if (!this._isErrorModalActive) {
      this._isErrorModalActive = true;
      showDialog(
          context: context,
          builder: (context) => this.errorWidget(context, error)
      );
    }
  }

  void hideErrorDialog(BuildContext context) {
    if (this._isErrorModalActive) {
      this._isErrorModalActive = false;
      Navigator.pop(context);
    }
  }

}