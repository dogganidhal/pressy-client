
typedef TService ServiceFactory<TService>(IServiceCollection services);

abstract class IServiceCollection {

  void addSingleton<IService>(ServiceFactory<IService> factory, {String key});
  void addScoped<IService>(ServiceFactory<IService> factory, {String key});
  void addInstance<IService>(IService instance, {String key});
  IService getService<IService>({String key});

}