import 'package:akademove/core/widgets/_export.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantProfileScreen extends StatelessWidget {
  const MerchantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      safeArea: true,
      body: Column(
        children: [
          SignOutButtonWidget(),
        ],
      ),
    );
  }
}
