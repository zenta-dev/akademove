import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            OrderStatusEnum.requested,
            OrderStatusEnum.accepted,
            OrderStatusEnum.inTrip,
          ],
        );
      case 1:
        cubit.getMine(
          statuses: const [
            OrderStatusEnum.completed,
          ],
        );
      case 2:
        cubit.getMine(
          statuses: const [
            OrderStatusEnum.cancelledBySystem,
            OrderStatusEnum.cancelledByUser,
            OrderStatusEnum.cancelledByDriver,
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
                      OrderStatusEnum.requested,
                      OrderStatusEnum.accepted,
                      OrderStatusEnum.inTrip,
                    ],
                  ),
                  _buildTab(
                    statuses: const [
                      OrderStatusEnum.completed,
                    ],
                  ),
                  _buildTab(
                    statuses: const [
                      OrderStatusEnum.cancelledBySystem,
                      OrderStatusEnum.cancelledByUser,
                      OrderStatusEnum.cancelledByDriver,
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
              child: _buildTabButton(
                context,
                i,
                tabs[i],
                _currentIndex == i,
              ),
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
        padding: EdgeInsets.symmetric(vertical: 8.h),
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

  Widget _buildTab({required List<OrderStatusEnum> statuses}) {
    return BlocBuilder<MerchantOrderCubit, MerchantOrderState>(
      builder: (context, state) {
        return state.whenOr(
          success: (orders, selected, message) {
            final filtered = (orders ?? [])
                .where((o) => statuses.contains(o.status))
                .toList();

            if (filtered.isEmpty) {
              return const Center(child: Text('No orders found'));
            }

            return ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => Gap(16.h),
              itemBuilder: (_, index) => MerchantOrderCardWidget(
                order: filtered[index],
                onPressed: () {
                  showToast(
                    context: context,
                    location: ToastLocation.topCenter,
                    builder: (context, overlay) => context.buildToast(
                      title: 'Tap Root',
                      message: 'index => $index',
                    ),
                  );
                },
              ),
            );
          },
          failure: (error, message) => Center(
            child: Alert.destructive(
              title: const Text('Failed to load data'),
              content: Text(message ?? 'An unexpected error occurred'),
              leading: const Icon(LucideIcons.info),
            ),
          ),
          loading: () => ListView.separated(
            itemCount: 5,
            separatorBuilder: (_, __) => Gap(16.h),
            itemBuilder: (_, i) => MerchantOrderCardWidget(
              order: i.dummyOrder,
            ).asSkeleton(),
          ),
          orElse: () => const Text('data'),
        );
      },
    );
  }
}

class _TabItem {
  const _TabItem({required this.label});
  final String label;
}
