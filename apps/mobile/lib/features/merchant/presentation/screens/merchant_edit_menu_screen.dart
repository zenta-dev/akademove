import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantEditMenuScreen extends StatelessWidget {
  const MerchantEditMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menu = GoRouterState.of(context).extra as MerchantMenu?;

    if (menu == null) {
      return Scaffold(
        headers: [DefaultAppBar(title: context.l10n.title_edit_menu)],
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: Center(child: Text(context.l10n.error_menu_info_not_found)),
        ),
      );
    }

    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_edit_menu)],
      child: BlocConsumer<MerchantMenuCubit, MerchantMenuState>(
        listenWhen: (previous, current) => previous.menu != current.menu,
        listener: (context, state) {
          if (state.menu.isSuccess) {
            showToast(
              context: context,
              builder: (context, overlay) => context.buildToast(
                title: context.l10n.success,
                message:
                    state.menu.message ??
                    context.l10n.toast_menu_updated_success,
              ),
              location: ToastLocation.topCenter,
            );
            context.pop();
          } else if (state.menu.isFailure) {
            showToast(
              context: context,
              builder: (context, overlay) => context.buildToast(
                title: context.l10n.error,
                message:
                    state.menu.error?.message ??
                    context.l10n.toast_failed_update_menu,
              ),
              location: ToastLocation.topCenter,
            );
          }
        },
        builder: (context, state) {
          final merchantId = context.read<MerchantCubit>().state.mine.value?.id;

          if (merchantId == null) {
            return Center(
              child: Text(context.l10n.error_merchant_info_not_found),
            );
          }

          return _MerchantEditMenuForm(
            menu: menu,
            merchantId: merchantId,
            isLoading: state.menu.isLoading,
          );
        },
      ),
    );
  }
}

class _MerchantEditMenuForm extends StatelessWidget {
  const _MerchantEditMenuForm({
    required this.menu,
    required this.merchantId,
    required this.isLoading,
  });

  final MerchantMenu menu;
  final String merchantId;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MerchantMenuCategoryCubit>(),
      child: MerchantMenuForm(
        initialMenu: menu,
        merchantId: merchantId,
        isLoading: isLoading,
        submitButtonText: context.l10n.save_changes,
        onSubmit: (data) => _handleSaveChanges(context, data),
      ),
    );
  }

  Future<void> _handleSaveChanges(
    BuildContext context,
    MenuFormData data,
  ) async {
    final image = data.imageFile != null && data.imageFile!.existsSync()
        ? await MultipartFile.fromFile(data.imageFile!.path)
        : null;

    if (!context.mounted) return;

    context.read<MerchantMenuCubit>().updateMenu(
      merchantId: merchantId,
      menuId: menu.id,
      name: data.name,
      price: data.price,
      stock: data.stock,
      category: data.categoryId,
      image: image,
    );
  }
}
