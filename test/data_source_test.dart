import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:pressy_client/data/data_source/data_source.dart';
import 'package:pressy_client/data/model/model.dart';
import 'package:pressy_client/data/resources/resources.dart';
import 'package:pressy_client/utils/network/mock_client.dart';

void main() {

  // Data source factory initialization
  DataSourceFactory.setClient(new MockClient(
    (String path) => new File("assets/mocks$path").readAsString(),
    delayInMilliSeconds: 0
  ));
  DataSourceFactory.setApiEndpointProvider(new ApiEndpointProvider());

  group("Authentication data source test cases", () {

    test("Authentication data source returns credentials", () async {

      var authDataSource = DataSourceFactory.createAuthDataSource();
      var authCredentials = await authDataSource.login(new LoginRequestModel(
        email: "dummy@email.com",
        password: "qwerty2018"
      ));

      expect(authCredentials, isNot(null));
      expect(authCredentials.accessToken, isNot(null));
      expect(authCredentials.refreshToken, isNot(null));
      expect(authCredentials.tokenType, "Bearer");
      expect(authCredentials.expiresIn, 3600);

    });

    test("Authentication data source does not crash when with body", () async {

      var authDataSource = DataSourceFactory.createAuthDataSource();
      var _ = await authDataSource.login(null);

    });

  });

}
