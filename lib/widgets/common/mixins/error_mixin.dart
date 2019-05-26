import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:pressy_client/utils/errors/base_error.dart';
import 'package:pressy_client/widgets/common/layouts/modal.dart';


mixin ErrorMixin {

  bool _isErrorModalActive = false;

  Widget errorWidget(BuildContext context, AppError error) => Modal(
      title: error.title ?? "Erreur",
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Text(
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
        ModalAction(
          title: "OK",
          callback: () => this._isErrorModalActive = false
        )
      ],
    );

  void showErrorDialog(BuildContext context, AppError error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(width: 12),
          Text(error.message)
        ],
      ),
      duration: Duration(seconds: 10)
    ));
  }

  void hideErrorDialog(BuildContext context) {
    if (this._isErrorModalActive) {
      this._isErrorModalActive = false;
      Navigator.pop(context);
    }
  }

}