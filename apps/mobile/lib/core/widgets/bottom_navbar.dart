import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide TabItem;

class BottomNavBarItem {
  const BottomNavBarItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    required this.shell,
    required this.tabs,
    super.key,
  });
  final StatefulNavigationShell shell;
  final List<BottomNavBarItem> tabs;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
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
                widget.tabs.length,
                (i) => Expanded(
                  child: _buildButton(
                    context,
                    i,
                    widget.tabs[i],
                    currentIndex == i,
                  ),
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
    BottomNavBarItem tab,
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
