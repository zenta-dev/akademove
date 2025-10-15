import 'package:akademove/app/router.dart';
import 'package:akademove/features/auth/_export.dart';
import 'package:akademove/locator.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantHomeScreen extends StatelessWidget {
  const MerchantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: Column(
          children: [
            const Text(
              'Merchant Home Screen',
            ),
            TextButton(
              child: const Text('sign out'),
              onPressed: () async {
                await sl<AuthRepository>().signOut();
                context.goNamed(Routes.authSignIn.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
