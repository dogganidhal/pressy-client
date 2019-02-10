import 'package:flutter/widgets.dart';


mixin WidgetLifeCycleMixin {

  void onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

}