import 'package:akademove/core/_export.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
