import 'package:flutter/widgets.dart';
import 'package:pressy_client/services/di/service_collection.dart';


class ServiceProvider extends InheritedWidget {

  final IServiceCollection services;
  final Widget child;

  ServiceProvider({Key key, @required this.child, @required this.services})
    : assert(child != null), assert(services != null), super(key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static IServiceCollection of(BuildContext context) {

    final ServiceProvider provider = context?.ancestorInheritedElementForWidgetOfExactType(ServiceProvider)?.widget;

    if (provider == null) {
      throw FlutterError(
        'ServiceProvider.of() called with a context that does not contain a ServiceProvider instance.\n'
        'No ancestor could be found starting from the context that was passed '
        'to ServiceProvider.of(). This can happen '
        'if the context you use comes from a widget above the ServiceProvider.\n'
        'The context used was:\n'
        '$context'
      );
    }

    return provider.services;

  }

}