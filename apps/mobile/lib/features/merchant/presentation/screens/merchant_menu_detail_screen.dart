import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantMenuDetailScreen extends StatelessWidget {
  const MerchantMenuDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get menu from route params
    final menu = GoRouterState.of(context).extra as MerchantMenu?;

    if (menu == null) {
      return MyScaffold(
        safeArea: true,
        headers: const [DefaultAppBar(title: 'Menu Detail')],
        body: const Center(child: Text('Menu not found')),
      );
    }

    return MyScaffold(
      safeArea: true,
      headers: const [DefaultAppBar(title: 'Menu Detail')],
      body: BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
        builder: (context, state) {
          // Use selected menu from state if available, otherwise use passed menu
          final displayMenu = state.selected ?? menu;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: displayMenu.image != null
                      ? Image.network(
                          displayMenu.image!,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 200.h,
                              color: material.Colors.grey[300],
                              child: const Icon(LucideIcons.image, size: 64),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: 200.h,
                              color: material.Colors.grey[200],
                              child: const Center(
                                child: material.CircularProgressIndicator(),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: 200.h,
                          color: material.Colors.grey[300],
                          child: const Icon(LucideIcons.image, size: 64),
                        ),
                ),

                // Details Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow(context, 'Name:', displayMenu.name),
                        if (displayMenu.category != null)
                          _buildDetailRow(
                            context,
                            'Category:',
                            displayMenu.category!,
                          ),
                        _buildDetailRow(
                          context,
                          'Price:',
                          'Rp ${NumberFormat('#,###', 'id_ID').format(displayMenu.price)}',
                        ),
                        _buildDetailRow(
                          context,
                          'Stock:',
                          '${displayMenu.stock}',
                          valueColor: displayMenu.stock > 0
                              ? material.Colors.green
                              : material.Colors.red,
                        ),
                        _buildDetailRow(
                          context,
                          'Created:',
                          DateFormat(
                            'dd MMM yyyy, HH:mm',
                          ).format(displayMenu.createdAt),
                        ),
                        _buildDetailRow(
                          context,
                          'Updated:',
                          DateFormat(
                            'dd MMM yyyy, HH:mm',
                          ).format(displayMenu.updatedAt),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                if (state.isLoading)
                  const Center(child: material.CircularProgressIndicator())
                else
                  Row(
                    spacing: 16.w,
                    children: [
                      Expanded(
                        child: Button.primary(
                          onPressed: () {
                            context.pushNamed(
                              Routes.merchantEditMenu.name,
                              extra: displayMenu,
                            );
                          },
                          child: Text(
                            'Edit Menu',
                            style: context.typography.small.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Button.destructive(
                          onPressed: () =>
                              _showDeleteConfirmation(context, displayMenu),
                          child: Text(
                            'Delete Menu',
                            style: context.typography.small.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                // Error Message
                if (state.isFailure && state.error != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.error?.message ?? 'An error occurred',
                        style: TextStyle(color: material.Colors.red),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, MerchantMenu menu) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Menu'),
        content: Text('Are you sure you want to delete "${menu.name}"?'),
        actions: [
          Button.ghost(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          Button.destructive(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _deleteMenu(context, menu);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteMenu(BuildContext context, MerchantMenu menu) async {
    final merchantCubit = context.read<MerchantCubit>();
    final menuCubit = context.read<MerchantMenuCubit>();

    final merchantId = merchantCubit.state.mine?.id;

    if (merchantId == null) {
      logger.e('[MerchantMenuDetailScreen] - No merchant ID found');
      return;
    }

    // Delete menu
    await menuCubit.deleteMenu(merchantId: merchantId, menuId: menu.id);

    // Check if mounted before navigating
    if (!context.mounted) return;

    final state = menuCubit.state;

    if (state.isSuccess) {
      // Show success message
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: 'Success',
          message: state.message ?? 'Menu deleted successfully',
        ),
        location: ToastLocation.topCenter,
      );

      // Navigate back to list
      context.pop();
    } else if (state.isFailure) {
      // Show error message
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: 'Error',
          message: state.error?.message ?? 'Failed to delete menu',
        ),
        location: ToastLocation.topCenter,
      );
    }
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    material.Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
