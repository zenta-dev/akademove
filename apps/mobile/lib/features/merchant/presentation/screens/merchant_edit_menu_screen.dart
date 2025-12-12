import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum MenuPhotosEdit { menuPhoto }

enum MenuCategoryEnumEdit {
  appetizer,
  mainCourse,
  dessert,
  beverage,
  snack,
  breakfast,
  lunch,
  dinner,
  salad,
  soup,
  seafood,
  vegetarian,
  vegan,
  pasta,
  pizza,
  burger,
  sandwich,
  rice,
  noodle,
  grill,
}

abstract class _FormKeys {
  static const FormKey<String> menuName = TextFieldKey('menu-name');
  static const FormKey<String> menuPrice = TextFieldKey('menu-price');
  static const FormKey<String> menuStock = TextFieldKey('menu-stock');
}

class MerchantEditMenuScreen extends StatefulWidget {
  const MerchantEditMenuScreen({super.key});

  @override
  State<MerchantEditMenuScreen> createState() => _MerchantEditMenuScreenState();
}

class _MerchantEditMenuScreenState extends State<MerchantEditMenuScreen> {
  late final FormController _formController;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;

  MenuCategoryEnumEdit? _selectedMenuCategory;
  int _stock = 0;
  MerchantMenu? _menu;

  final Map<MenuPhotosEdit, File?> _menuPhoto = {
    for (final doc in MenuPhotosEdit.values) doc: null,
  };

  @override
  void initState() {
    super.initState();
    _formController = FormController();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get menu from route params
    if (_menu == null) {
      _menu = GoRouterState.of(context).extra as MerchantMenu?;
      if (_menu != null) {
        _initializeFormWithMenu(_menu!);
      }
    }
  }

  void _initializeFormWithMenu(MerchantMenu menu) {
    _nameController.text = menu.name;
    _priceController.text = menu.price.toString();
    _stock = menu.stock;
    _stockController.text = menu.stock.toString();

    // Try to match category
    if (menu.category != null) {
      try {
        final categoryLower = menu.category?.toLowerCase();
        _selectedMenuCategory = MenuCategoryEnumEdit.values.firstWhere(
          (e) => e.name.toLowerCase() == categoryLower,
        );
      } catch (e) {
        _selectedMenuCategory = null;
      }
    }
  }

  @override
  void dispose() {
    _formController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _handleSaveChanges() async {
    final menu = _menu;
    if (menu == null) {
      _showToast(context.l10n.error, context.l10n.error_menu_info_not_found);
      return;
    }

    final isValid = _formController.errors.isEmpty;

    if (!isValid) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_fill_all_required_fields,
      );
      return;
    }

    // Get form values
    final name = _nameController.text.trim();
    final priceStr = _priceController.text.trim();
    final category = _selectedMenuCategory;

    if (name.isEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_menu_name_required,
      );
      return;
    }

    if (priceStr.isEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_menu_price_required,
      );
      return;
    }

    final price = int.tryParse(priceStr.replaceAll(RegExp('[^0-9]'), ''));
    if (price == null || price <= 0) {
      _showToast(context.l10n.error_validation, context.l10n.error_valid_price);
      return;
    }

    // Get merchant ID
    final merchantCubit = context.read<AuthCubit>();
    final merchantId = merchantCubit.state.merchant.data?.value?.id;

    if (merchantId == null) {
      _showToast(
        context.l10n.error,
        context.l10n.error_merchant_info_not_found,
      );
      return;
    }

    // Get image file and convert to MultipartFile
    final imageFile = _menuPhoto[MenuPhotosEdit.menuPhoto];
    final image = imageFile != null && imageFile.existsSync()
        ? await MultipartFile.fromFile(imageFile.path)
        : null;

    // Check if mounted before calling cubit
    if (!mounted) return;

    // Update menu - BlocConsumer listener handles state changes
    context.read<MerchantMenuCubit>().updateMenu(
      merchantId: merchantId,
      menuId: menu.id,
      name: name,
      price: price,
      stock: _stock,
      category: category?.name,
      image: image,
    );
  }

  void _showToast(String title, String message) {
    if (!mounted) return;

    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: title, message: message),
      location: ToastLocation.topCenter,
    );
  }

  void _incrementStock() {
    setState(() {
      _stock = (_stock + 1).clamp(0, 999);
      _stockController.text = _stock.toString();
    });
  }

  void _decrementStock() {
    setState(() {
      _stock = (_stock - 1).clamp(0, 999);
      _stockController.text = _stock.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menu = _menu;

    if (menu == null) {
      return Scaffold(
        headers: [DefaultAppBar(title: context.l10n.title_edit_menu)],
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.dg),
            child: Center(child: Text(context.l10n.error_menu_info_not_found)),
          ),
        ),
      );
    }

    return BlocConsumer<MerchantMenuCubit, MerchantMenuState>(
      listenWhen: (previous, current) => previous.menu != current.menu,
      listener: (context, state) {
        if (state.menu.isSuccess) {
          // Show success message
          showToast(
            context: context,
            builder: (context, overlay) => context.buildToast(
              title: context.l10n.success,
              message:
                  state.menu.message ?? context.l10n.toast_menu_updated_success,
            ),
            location: ToastLocation.topCenter,
          );
          // Navigate back
          context.pop();
        } else if (state.menu.isFailure) {
          // Show error message
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
        final isLoading = state.menu.isLoading;

        return Stack(
          children: [
            Scaffold(
              headers: [DefaultAppBar(title: context.l10n.title_edit_menu)],
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.dg),
                  child: Form(
                    controller: _formController,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 100.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16.h,
                        children: [
                          AuthEnumSelect<MenuCategoryEnumEdit>(
                            label: context.l10n.label_menu_category,
                            placeholder:
                                context.l10n.placeholder_select_category,
                            value: _selectedMenuCategory,
                            items: MenuCategoryEnumEdit.values,
                            enabled: !isLoading,
                            itemBuilder: (context, item) =>
                                Text(_formatEnumName(item.name)),
                            onChanged: (value) =>
                                setState(() => _selectedMenuCategory = value),
                          ),
                          AuthImagePicker(
                            label: context.l10n.label_menu_photo,
                            previewUrl: menu.image,
                            value: _menuPhoto[MenuPhotosEdit.menuPhoto],
                            onChanged: (file) => setState(
                              () => _menuPhoto[MenuPhotosEdit.menuPhoto] = file,
                            ),
                          ),
                          AuthTextField(
                            formKey: _FormKeys.menuName,
                            controller: _nameController,
                            label: context.l10n.label_menu_name,
                            placeholder: context.l10n.placeholder_menu_name,
                            icon: LucideIcons.coffee,
                            validator: const LengthValidator(min: 3),
                            enabled: !isLoading,
                            maxLength: 150,
                          ),
                          AuthTextField(
                            formKey: _FormKeys.menuPrice,
                            controller: _priceController,
                            label: context.l10n.label_menu_price,
                            placeholder: context.l10n.placeholder_menu_price,
                            icon: LucideIcons.dollarSign,
                            validator: const LengthValidator(min: 1),
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                          ),
                          _buildStockField(isLoading),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Button.primary(
                      onPressed: isLoading ? null : _handleSaveChanges,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              context.l10n.save_changes,
                              style: context.typography.small.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStockField(bool isLoading) {
    return Row(
      spacing: 8.w,
      children: [
        Expanded(
          child: FormField(
            key: _FormKeys.menuStock,
            label: Text(
              context.l10n.label_menu_stock,
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            validator: const LengthValidator(min: 1),
            showErrors: const {
              FormValidationMode.changed,
              FormValidationMode.submitted,
            },
            child: TextField(
              controller: _stockController,
              placeholder: Text(context.l10n.placeholder_stock),
              enabled: !isLoading,
              keyboardType: TextInputType.number,
              features: const [InputFeature.leading(Icon(LucideIcons.package))],
              onChanged: (value) {
                final intValue = int.tryParse(value) ?? 0;
                final clampedValue = intValue.clamp(0, 999);
                setState(() {
                  _stock = clampedValue;
                });
                if (clampedValue != intValue) {
                  _stockController.text = clampedValue.toString();
                  _stockController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _stockController.text.length),
                  );
                }
              },
            ),
          ),
        ),
        IconButton(
          onPressed: isLoading ? null : _decrementStock,
          icon: const Icon(LucideIcons.minus, size: 16),
          variance: ButtonVariance.primary,
        ),
        IconButton(
          onPressed: isLoading ? null : _incrementStock,
          icon: const Icon(LucideIcons.plus, size: 16),
          variance: ButtonVariance.primary,
        ),
      ],
    );
  }

  String _formatEnumName(String enumName) {
    // Convert camelCase to Title Case with spaces
    final result = enumName.replaceAllMapped(
      RegExp('([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    // Capitalize first letter and trim
    return result.trim().substring(0, 1).toUpperCase() +
        result.trim().substring(1);
  }
}
