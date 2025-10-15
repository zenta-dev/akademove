import 'package:akademove/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SignUpUserScreen extends StatelessWidget {
  const SignUpUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit()..init(),
      child: const _SignUpUserView(),
    );
  }
}

class _SignUpUserView extends StatelessWidget {
  const _SignUpUserView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      child: Center(child: Text('SIGN UP')),
    );
  }
}
