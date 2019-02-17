import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:pressy_client/services/di/service_collection.dart';


class ServiceCollectionImpl implements IServiceCollection {

  static const String _INJECTOR_NAME = "@pressy/injector";

  Injector _injector = Injector.getInjector(_INJECTOR_NAME);

  @override
  void addSingleton<IService>(ServiceFactory<IService> factory, {String key})
  => _injector.map<IService>((_) => factory(this), isSingleton: true, key: key);

  @override
  void addScoped<IService>(ServiceFactory<IService> factory, {String key})
  => _injector.map<IService>((_) => factory(this), key: key);

  @override
  void addInstance<IService>(IService instance, {String key}) {
    _injector.map<IService>((_) => instance, isSingleton: true, key: key);
  }

  @override
  IService getService<IService>({String key}) => _injector.get<IService>(key: key);

}