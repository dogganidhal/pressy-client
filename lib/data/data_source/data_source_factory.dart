import 'package:http/http.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source.dart';
import 'package:pressy_client/data/data_source/auth/auth_data_source_impl.dart';

abstract class DataSourceFactory {

  static IAuthDataSource createAuthDataSource(BaseClient client) 
    => new AuthDataSourceImpl(client: client);

}