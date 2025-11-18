import 'package:api_client/api_client.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

extension PhoneExt on Phone {
  PhoneNumber toPhoneNumber() {
    final val = this;

    Country country;

    switch (val.countryCode) {
      case CountryCode.ID:
        country = Country.indonesia;
    }

    return PhoneNumber(country, val.number.toString());
  }
}

extension PhoneNullableExt on Phone? {
  PhoneNumber? toPhoneNumber() {
    final val = this;
    if (val == null) return null;

    Country country;

    switch (val.countryCode) {
      case CountryCode.ID:
        country = Country.indonesia;
    }

    return PhoneNumber(country, val.number.toString());
  }
}
