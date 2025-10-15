import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SignUpDriverScreen extends StatelessWidget {
  const SignUpDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit()..init(),
      child: const _SignUpDriverView(),
    );
  }
}

class _SignUpDriverView extends StatelessWidget {
  const _SignUpDriverView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      child: Center(child: Text('SIGN UP')),
    );
  }
}
