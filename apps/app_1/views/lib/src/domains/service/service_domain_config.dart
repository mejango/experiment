import 'package:views/src/utils/index.dart';

mixin ServiceDomainConfig implements ViewStoreDomainConfig {
  String get baseUrl => coreStagingBaseUrl;
  String get domain => "auth";
}
