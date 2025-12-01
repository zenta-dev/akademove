import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantOrderScreen extends StatefulWidget {
  const MerchantOrderScreen({super.key});

  @override
  State<MerchantOrderScreen> createState() => _MerchantOrderScreenState();
}

class _MerchantOrderScreenState extends State<MerchantOrderScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchOrdersForTab(0);
  }

  void _fetchOrdersForTab(int index) {
    final cubit = context.read<MerchantOrderCubit>();
    switch (index) {
      case 0:
        cubit.getMine(
          statuses: const [
            OrderStatus.REQUESTED,
            OrderStatus.ACCEPTED,
            OrderStatus.IN_TRIP,
          ],
        );
      case 1:
        cubit.getMine(statuses: const [OrderStatus.COMPLETED]);
      case 2:
        cubit.getMine(
          statuses: const [
            OrderStatus.CANCELLED_BY_SYSTEM,
            OrderStatus.CANCELLED_BY_USER,
            OrderStatus.CANCELLED_BY_DRIVER,
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const _TabItem(label: 'On process'),
      const _TabItem(label: 'Completed'),
      const _TabItem(label: 'Canceled'),
    ];

    return MyScaffold(
      padding: EdgeInsets.zero,
      scrollable: false,
      body: Column(
        children: [
          _buildTabBar(context, tabs),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.dg),
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  _buildTab(
                    statuses: const [
                      OrderStatus.REQUESTED,
                      OrderStatus.ACCEPTED,
                      OrderStatus.IN_TRIP,
                    ],
                  ),
                  _buildTab(statuses: const [OrderStatus.COMPLETED]),
                  _buildTab(
                    statuses: const [
                      OrderStatus.CANCELLED_BY_SYSTEM,
                      OrderStatus.CANCELLED_BY_USER,
                      OrderStatus.CANCELLED_BY_DRIVER,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, List<_TabItem> tabs) {
    return Card(
      borderRadius: BorderRadius.zero,
      padding: EdgeInsets.zero,
      borderWidth: 0,
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, bottom: 4.h),
        child: Row(
          children: List.generate(
            tabs.length,
            (i) => Expanded(
              child: _buildTabButton(context, i, tabs[i], _currentIndex == i),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(
    BuildContext context,
    int index,
    _TabItem tab,
    bool selected,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        _fetchOrdersForTab(index);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected
                  ? context.colorScheme.primary
                  : Colors.transparent,
              width: 2.h,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          tab.label,
          style: context.typography.xSmall.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: selected
                ? context.colorScheme.primary
                : context.colorScheme.mutedForeground,
          ),
        ),
      ),
    );
  }

  Widget _buildFail({
    required String message,
    required List<OrderStatus> statuses,
  }) => Container(
    width: double.infinity,
    padding: EdgeInsets.only(top: 16.dg),
    child: OopsAlertWidget(
      message: message,
      onRefresh: () =>
          context.read<MerchantOrderCubit>().getMine(statuses: statuses),
    ),
  );

  Widget _buildTab({required List<OrderStatus> statuses}) {
    return BlocBuilder<MerchantOrderCubit, MerchantOrderState>(
      builder: (context, state) {
        return material.RefreshIndicator(
          onRefresh: () async {
            await context.read<MerchantOrderCubit>().getMine(
              statuses: statuses,
            );
          },
          child: state.whenOr(
            success: (orders, selected, message) {
              final filtered = (orders ?? [])
                  .where((o) => statuses.contains(o.status))
                  .toList();

              if (filtered.isEmpty) {
                return ListView(
                  children: [
                    _buildFail(message: 'No orders found', statuses: statuses),
                  ],
                );
              }

              return ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => Gap(16.h),
                itemBuilder: (_, index) {
                  final order = filtered[index];
                  return MerchantOrderCardWidget(
                    order: order,
                    onPressed: () {
                      context.pushNamed(
                        Routes.merchantOrderDetail.name,
                        extra: order,
                      );
                    },
                  );
                },
              );
            },
            failure: (error) => ListView(
              children: [
                _buildFail(
                  message: error.message ?? 'An unexpected error occurred',
                  statuses: statuses,
                ),
              ],
            ),
            orElse: () => ListView.separated(
              itemCount: 5,
              separatorBuilder: (_, __) => Gap(16.h),
              itemBuilder: (_, _) =>
                  const MerchantOrderCardWidget(order: dummyOrder).asSkeleton(),
            ),
          ),
        );
      },
    );
  }
}

class _TabItem {
  const _TabItem({required this.label});
  final String label;
}
