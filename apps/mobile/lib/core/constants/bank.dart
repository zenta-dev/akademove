import 'package:akademove/gen/assets.gen.dart';
import 'package:api_client/api_client.dart';

final List<({SvgGenImage icon, BankProvider provider})> bankProviderDicts = [
  (
    provider: BankProvider.BCA,
    icon: Assets.icons.bca,
  ),
  (
    provider: BankProvider.BNI,
    icon: Assets.icons.bni,
  ),
  (
    provider: BankProvider.BRI,
    icon: Assets.icons.bri,
  ),
  // (
  //   provider: BankProvider.mandiri,
  //   icon: Assets.icons.mandiri,
  // ),
  (
    provider: BankProvider.PERMATA,
    icon: Assets.icons.permata,
  ),
];
