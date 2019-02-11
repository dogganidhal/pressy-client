import 'package:flutter/material.dart';
import 'package:pressy_client/widgets/common/layouts/loader_widget.dart';

mixin LoaderMixin {

  bool isLoaderActive = false;

  void showLoader(BuildContext context) {
    this.isLoaderActive = true;
    showDialog(
      context: context,
      builder: (context) => new LoaderWidget()
    );
  }

  void hideLoader(BuildContext context) {
    if (this.isLoaderActive) {
      Navigator.of(context).pop();
      this.isLoaderActive = false;
    }
  }

}