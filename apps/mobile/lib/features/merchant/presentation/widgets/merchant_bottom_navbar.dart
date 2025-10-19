import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantBottomNavbar extends StatefulWidget {
  const MerchantBottomNavbar({required this.shell, super.key});
  final StatefulNavigationShell shell;

  @override
  State<MerchantBottomNavbar> createState() => _MerchantBottomNavbarState();
}

class _MerchantBottomNavbarState extends State<MerchantBottomNavbar> {
  static const _tabs = [
    _TabItem(label: 'Home', icon: LucideIcons.house),
    _TabItem(label: 'Order', icon: LucideIcons.book),
    _TabItem(label: 'Menu', icon: LucideIcons.listOrdered),
    _TabItem(label: 'Profile', icon: BootstrapIcons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.shell.currentIndex;

    return Scaffold(
      footers: [
        SizedBox(
          height: 60.h,
          width: double.infinity,
          child: Card(
            borderRadius: BorderRadius.circular(0),
            padding: EdgeInsets.zero,
            borderWidth: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _tabs.length,
                (i) => Expanded(
                  child: _buildButton(context, i, _tabs[i], currentIndex == i),
                ),
              ),
            ),
          ),
        ),
      ],
      child: widget.shell,
    );
  }

  Widget _buildButton(
    BuildContext context,
    int index,
    _TabItem tab,
    bool selected,
  ) {
    return GestureDetector(
      onTap: () => _onItemTapped(index, selected),
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: selected
                  ? context.colorScheme.primary
                  : Colors.transparent,
              width: 2.h,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tab.icon,
              size: 24.sp,
              color: selected ? context.colorScheme.primary : null,
            ),
            ClipRect(
              child: AnimatedAlign(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                heightFactor: selected ? 1.0 : 0.0,
                child: AnimatedOpacity(
                  opacity: selected ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text(
                      tab.label,
                      style: context.typography.xSmall.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ).withPadding(all: 4.dg),
      ),
    );
  }

  void _onItemTapped(int index, bool selected) {
    if (!selected) {
      widget.shell.goBranch(index);
    }
  }
}

class _TabItem {
  const _TabItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
