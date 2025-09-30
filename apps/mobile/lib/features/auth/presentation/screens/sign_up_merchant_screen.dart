import 'package:akademove/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpMerchantScreen extends StatelessWidget {
  const SignUpMerchantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit()..init(),
      child: const _SignUpMerchantView(),
    );
  }
}

class _SignUpMerchantView extends StatelessWidget {
  const _SignUpMerchantView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('SIGN UP')),
    );
  }
}
