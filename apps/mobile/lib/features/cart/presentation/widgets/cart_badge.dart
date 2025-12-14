import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/presentation/cubits/user_cart_cubit.dart';
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Badge widget that displays cart item count in AppBar
/// Shows red badge with count when cart has items
class CartBadge extends StatelessWidget {
  const CartBadge({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCartCubit, UserCartState>(
      builder: (context, state) {
        final itemCount = state.totalItems;

        return IconButton(
          onPressed: onTap,
          variance: const ButtonStyle.ghost(),
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(LucideIcons.shoppingCart, size: 20.sp),
              if (itemCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.destructive,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.h,
                    ),
                    child: Text(
                      itemCount > 99 ? '99+' : itemCount.toString(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
