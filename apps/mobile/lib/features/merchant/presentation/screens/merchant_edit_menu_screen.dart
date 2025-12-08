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
  static const FormKey<MenuCategoryEnumEdit> menuCategory =
      SelectKey<MenuCategoryEnumEdit>('menu-category');
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

  final Map<MenuPhotosEdit, String?> _menuPhotosErrors = {
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
        final categoryLower = menu.category?.toLowerCase() ?? '';
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

  Future<void> _handleSaveChanges() async {
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

    // Check if mounted before navigating
    if (!mounted) return;

    // Update menu
    final menuCubit = context.read<MerchantMenuCubit>();
    await menuCubit.updateMenu(
      merchantId: merchantId,
      menuId: menu.id,
      name: name,
      price: price,
      stock: _stock,
      category: category?.name,
      image: image,
    );

    // Check if mounted before navigating
    if (!mounted) return;

    final state = menuCubit.state;

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
      return MyScaffold(
        safeArea: true,
        headers: [DefaultAppBar(title: context.l10n.title_edit_menu)],
        body: Center(child: Text(context.l10n.error_menu_info_not_found)),
      );
    }

    return BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
      builder: (context, state) {
        final isLoading = state.menu.isLoading;

        return Stack(
          children: [
            MyScaffold(
              safeArea: true,
              headers: [DefaultAppBar(title: context.l10n.title_edit_menu)],
              body: Form(
                controller: _formController,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16.h,
                    children: [
                      _buildEnumSelect<MenuCategoryEnumEdit>(
                        label: context.l10n.label_menu_category,
                        key: _FormKeys.menuCategory,
                        placeholder: context.l10n.placeholder_select_category,
                        icon: LucideIcons.store,
                        value: _selectedMenuCategory,
                        items: MenuCategoryEnumEdit.values,
                        enabled: !isLoading,
                        onChanged: (value) =>
                            setState(() => _selectedMenuCategory = value),
                      ),
                      _buildImagePicker(
                        context.l10n.label_menu_photo,
                        MenuPhotosEdit.menuPhoto,
                        _menuPhoto,
                        _menuPhotosErrors,
                        context,
                        isOptional: true,
                        previewUrl: menu.image,
                      ),
                      _buildTextField(
                        key: _FormKeys.menuName,
                        controller: _nameController,
                        label: context.l10n.label_menu_name,
                        placeholder: context.l10n.placeholder_menu_name,
                        icon: LucideIcons.coffee,
                        validator: const LengthValidator(min: 3),
                        enabled: !isLoading,
                        maxLength: 150,
                      ),
                      _buildTextField(
                        key: _FormKeys.menuPrice,
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

  Widget _buildTextField({
    required FormKey<String> key,
    required TextEditingController controller,
    required String label,
    required String placeholder,
    required IconData icon,
    required Validator validator,
    required bool enabled,
    TextInputType? keyboardType,
    int? maxLength,
    int maxLines = 1,
  }) {
    return FormField(
      key: key,
      label: Text(
        label,
        style: context.typography.p.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      validator: validator,
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: TextField(
        controller: controller,
        placeholder: Text(
          placeholder,
          style: context.typography.small.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        features: [InputFeature.leading(Icon(icon))],
      ),
    );
  }

  Widget _buildImagePicker<T>(
    String label,
    T key,
    Map<T, File?> docs,
    Map<T, String?> errors,
    BuildContext context, {
    bool isOptional = false,
    String? previewUrl,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          label,
          style: context.theme.typography.small.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        ImagePickerWidget(
          size: Size(double.infinity, 64.h),
          previewUrl: previewUrl,
          value: docs[key],
          onValueChanged: (file) => setState(() => docs[key] = file),
        ),
        if (!isOptional && errors[key] != null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text(errors[key]!).xSmall().medium(),
          ),
      ],
    );
  }

  Widget _buildEnumSelect<T extends Enum>({
    required String label,
    required FormKey key,
    required String placeholder,
    required IconData icon,
    required T? value,
    required List<T> items,
    required bool enabled,
    required void Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          label,
          style: context.typography.semiBold.copyWith(fontSize: 14.sp),
        ),
        SizedBox(
          width: double.infinity,
          child: Select<T>(
            enabled: enabled,
            itemBuilder: (context, item) => Text(_formatEnumName(item.name)),
            value: value,
            placeholder: Text(placeholder),
            onChanged: onChanged,
            popup: SelectPopup<T>(
              items: SelectItemList(
                children: items
                    .map(
                      (e) => SelectItemButton(
                        value: e,
                        child: Text(_formatEnumName(e.name)),
                      ),
                    )
                    .toList(),
              ),
            ).call,
          ),
        ),
      ],
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
