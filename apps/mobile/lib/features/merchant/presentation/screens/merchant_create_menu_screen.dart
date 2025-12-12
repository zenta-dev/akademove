import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantCreateMenuScreen extends StatelessWidget {
  const MerchantCreateMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [DefaultAppBar(title: context.l10n.title_create_menu)],
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
                    context.l10n.toast_menu_created_success,
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
                    context.l10n.toast_failed_create_menu,
              ),
              location: ToastLocation.topCenter,
            );
          }
        },
        builder: (context, state) {
          return _MerchantCreateMenuForm(isLoading: state.menu.isLoading);
        },
      ),
    );
  }
}

class _MerchantCreateMenuForm extends StatelessWidget {
  const _MerchantCreateMenuForm({required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MerchantMenuForm(
      isLoading: isLoading,
      submitButtonText: context.l10n.button_create_menu,
      onSubmit: (data) => _handleCreateMenu(context, data),
    );
  }

  Future<void> _handleCreateMenu(
    BuildContext context,
    MenuFormData data,
  ) async {
    final merchantCubit = context.read<MerchantCubit>();
    final merchantId = merchantCubit.state.mine.value?.id;

    if (merchantId == null) {
      showToast(
        context: context,
        builder: (context, overlay) => context.buildToast(
          title: context.l10n.error,
          message: context.l10n.error_merchant_info_not_found,
        ),
        location: ToastLocation.topCenter,
      );
      return;
    }

    final image = data.imageFile != null && data.imageFile!.existsSync()
        ? await MultipartFile.fromFile(data.imageFile!.path)
        : null;

    if (!context.mounted) return;

    context.read<MerchantMenuCubit>().createMenu(
      merchantId: merchantId,
      name: data.name,
      price: data.price,
      stock: data.stock,
      category: data.category?.name,
      image: image,
    );
  }
}
