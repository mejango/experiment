import 'package:views/src/utils/index.dart';

mixin UserDomainConfig implements ViewStoreDomainConfig {
  String get baseUrl => coreStagingBaseUrl;
  String get domain => "user";
}
