import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:news/core/service/remote/service_locator.dart';
import 'package:news/core/service/simple_secure_user_data.dart';
import 'package:news/core/service/simple_user_data.dart';
import 'package:news/core/utilities/enums.dart';

import 'interface/i_simple_user_data.dart';



mixin UserDataFactory {
  static ISimpleUserData createUserData(LocalDataType userDataType) {
    final isSecuredData = userDataType == LocalDataType.secured;

    if (isSecuredData) {
      return SimpleSecureData(ServiceLocator.instance<FlutterSecureStorage>());
    } else {
      return const SimpleLocalData();
    }
  }
}
