import 'package:key/index.dart' as _key;
import 'package:mappable/index.dart';

class Location with Mappable {
  final String? postalCode;
  final String? countryCode;
  final String? city;
  final String? state;
  final String? street;

  Location(
      {this.postalCode, this.countryCode, this.city, this.state, this.street});

  factory Location.fromMap(Map<String?, Object?> map) {
    return Location(
        postalCode: map[_key.postalCode] as String?,
        countryCode: map[_key.countryCode] as String?,
        city: map[_key.city] as String?,
        state: map[_key.state] as String?,
        street: map[_key.street] as String?);
  }

  @override
  Map<String, Object?> toMap() {
    return {
      _key.postalCode: postalCode,
      _key.countryCode: countryCode,
      _key.city: city,
      _key.state: state,
      _key.street: street
    };
  }
}
