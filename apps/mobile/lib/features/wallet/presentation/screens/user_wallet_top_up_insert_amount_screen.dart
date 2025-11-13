import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserWalletTopUpInsertAmountScreen extends StatefulWidget {
  const UserWalletTopUpInsertAmountScreen({
    required this.method,
    super.key,
  });

  final TopUpRequestMethodEnum method;

  @override
  State<UserWalletTopUpInsertAmountScreen> createState() =>
      _UserWalletTopUpInsertAmountScreenState();
}

class _UserWalletTopUpInsertAmountScreenState
    extends State<UserWalletTopUpInsertAmountScreen> {
  late TextEditingController amountController;
  int amount = 0;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: const [
        DefaultAppBar(title: 'Top Up QRIS'),
      ],
      body: Column(
        spacing: 16.h,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            spacing: 16.w,
            children: [
              _buildTemplate(10_000),
              _buildTemplate(20_000),
            ],
          ),
          Row(
            spacing: 16.w,
            children: [
              _buildTemplate(50_000),
              _buildTemplate(100_000),
            ],
          ),
          Row(
            spacing: 16.w,
            children: [
              _buildTemplate(500_000),
              _buildTemplate(1_000_000),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Label(
                child: DefaultText(
                  'Amount',
                  fontSize: 14.sp,
                ),
              ),
              TextField(
                controller: amountController,
                onChanged: (value) {
                  final parsed = int.tryParse(value, radix: 10);
                  amountController.text = '$parsed';
                  setState(() {
                    if (parsed != null) {
                      amount = parsed;
                    } else {
                      amount = 0;
                    }
                  });
                },
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                ),
                textInputAction: TextInputAction.done,
                features: [
                  InputFeature.clear(
                    icon: IconButton(
                      density: ButtonDensity.compact,
                      onPressed: amountController.text.isEmpty
                          ? null
                          : () {
                              amountController.text = '';
                              setState(() {
                                amount = 0;
                              });
                            },
                      icon: const Icon(LucideIcons.x),
                      variance: amountController.text.isEmpty
                          ? const ButtonStyle.ghost()
                          : const ButtonStyle.textIcon(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          BlocBuilder<UserWalletTopUpCubit, UserWalletTopUpState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: Button.primary(
                  enabled: !state.isLoading,
                  onPressed: amount <= 0 || state.isLoading
                      ? null
                      : () async {
                          final parsed = int.tryParse(
                            amountController.text,
                            radix: 10,
                          );
                          setState(() {
                            if (parsed != null) {
                              amount = parsed;
                            } else {
                              amount = 0;
                            }
                          });
                          if (parsed == null) {
                            showToast(
                              context: context,
                              builder: (context, overlay) => context.buildToast(
                                title: 'Invalid amount',
                                message: 'Top up amount atleast Rp 10,000',
                              ),
                            );
                            return;
                          }
                          if (amount < 10_000) {
                            showToast(
                              context: context,
                              builder: (context, overlay) => context.buildToast(
                                title: 'Invalid amount',
                                message: 'Top up amount atleast Rp 10,000',
                              ),
                            );
                            return;
                          }

                          context.read<UserWalletTopUpCubit>().reset();
                          await context.read<UserWalletTopUpCubit>().topUp(
                            parsed,
                            widget.method,
                          );

                          if (mounted && context.mounted) {
                            switch (widget.method) {
                              case TopUpRequestMethodEnum.QRIS:
                                await context.pushNamed(
                                  Routes.userWalletTopUpQRIS.name,
                                );
                              default:
                                break;
                            }
                          }
                        },
                  child: state.isLoading
                      ? const Submiting()
                      : const DefaultText('Next'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String formatPrice(int amount) {
    if (amount >= 1_000_000) {
      final juta = amount / 1_000_000;
      return 'Rp ${juta.toStringAsFixed(juta % 1 == 0 ? 0 : 1)} juta';
    } else if (amount >= 1_000) {
      final ribu = amount / 1_000;
      return 'Rp ${ribu.toStringAsFixed(ribu % 1 == 0 ? 0 : 1)} ribu';
    } else {
      return 'Rp $amount';
    }
  }

  Widget _buildTemplate(int val) {
    return Expanded(
      child: Button(
        style: const ButtonStyle.secondary(density: ButtonDensity.comfortable),
        onPressed: () {
          amountController.text = '$val';
          setState(() {
            amount = val;
          });
        },
        child: DefaultText(formatPrice(val)),
      ),
    );
  }
}
