import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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
        headers: [DefaultAppBar(title: context.l10n.title_menu_detail)],
        body: Center(child: Text(context.l10n.error_menu_not_found)),
      );
    }

    return MyScaffold(
      safeArea: true,
      headers: [DefaultAppBar(title: context.l10n.title_menu_detail)],
      body: BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
        builder: (context, state) {
          // Use selected menu from state if available, otherwise use passed menu
          final displayMenu = state.menu.data?.value ?? menu;

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
                              color: const Color(0xFFE0E0E0),
                              child: const Icon(LucideIcons.image, size: 64),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: 200.h,
                              color: const Color(0xFFEEEEEE),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        )
                      : Container(
                          width: double.infinity,
                          height: 200.h,
                          color: const Color(0xFFE0E0E0),
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
                        _buildDetailRow(
                          context,
                          '${context.l10n.label_name}:',
                          displayMenu.name,
                        ),
                        if (displayMenu.category != null)
                          _buildDetailRow(
                            context,
                            '${context.l10n.label_category}:',
                            displayMenu.category!,
                          ),
                        _buildDetailRow(
                          context,
                          '${context.l10n.label_price}:',
                          'Rp ${NumberFormat('#,###', 'id_ID').format(displayMenu.price)}',
                        ),
                        _buildDetailRow(
                          context,
                          '${context.l10n.label_stock}:',
                          '${displayMenu.stock}',
                          valueColor: displayMenu.stock > 0
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFF44336),
                        ),
                        _buildDetailRow(
                          context,
                          '${context.l10n.label_created}:',
                          DateFormat(
                            'dd MMM yyyy, HH:mm',
                          ).format(displayMenu.createdAt),
                        ),
                        _buildDetailRow(
                          context,
                          '${context.l10n.label_updated}:',
                          DateFormat(
                            'dd MMM yyyy, HH:mm',
                          ).format(displayMenu.updatedAt),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                if (state.menus.isLoading)
                  const Center(child: CircularProgressIndicator())
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
                            context.l10n.edit_menu,
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
                            context.l10n.delete_menu,
                            style: context.typography.small.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                // Error Message
                if (state.menus.isFailure && state.menus.error != null)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        state.menus.error?.message ??
                            context.l10n.an_error_occurred,
                        style: const TextStyle(color: Color(0xFFF44336)),
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
    final merchantCubit = context.read<MerchantCubit>();
    final menuCubit = context.read<MerchantMenuCubit>();
    final merchantId = merchantCubit.state.mine.value?.id;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.delete_menu),
        content: Text(context.l10n.dialog_delete_menu_confirm(menu.name)),
        actions: [
          Button.ghost(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.l10n.cancel),
          ),
          Button.destructive(
            onPressed: () async {
              if (merchantId == null) {
                logger.e('[MerchantMenuDetailScreen] - No merchant ID found');
                return;
              }

              await menuCubit.deleteMenu(
                merchantId: merchantId,
                menuId: menu.id,
              );

              if (!context.mounted) return;

              context.showMyToast(
                context.l10n.success_menu_deleted,
                type: ToastType.success,
              );

              await Future.delayed(const Duration(milliseconds: 500));

              if (!dialogContext.mounted || !context.mounted) return;

              Navigator.of(dialogContext).pop();
              context.pop();
            },
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
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
