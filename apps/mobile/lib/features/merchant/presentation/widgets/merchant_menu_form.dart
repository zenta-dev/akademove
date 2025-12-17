import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Form keys for menu form fields
abstract class MenuFormKeys {
  static const FormKey<String> name = TextFieldKey("menu-name");
  static const FormKey<String> price = TextFieldKey("menu-price");
  static const FormKey<String> stock = TextFieldKey("menu-stock");
}

/// Data class representing menu form values
class MenuFormData {
  const MenuFormData({
    required this.name,
    required this.price,
    required this.stock,
    this.categoryId,
    this.imageFile,
  });

  final String name;
  final int price;
  final int stock;
  final String? categoryId;
  final File? imageFile;
}

/// Reusable form widget for creating and editing merchant menus
class MerchantMenuForm extends StatefulWidget {
  const MerchantMenuForm({
    super.key,
    this.initialMenu,
    required this.isLoading,
    required this.onSubmit,
    required this.submitButtonText,
    required this.merchantId,
  });

  /// The menu to edit (null for create mode)
  final MerchantMenu? initialMenu;

  /// Whether the form is currently submitting
  final bool isLoading;

  /// Callback when form is submitted with valid data
  final void Function(MenuFormData data) onSubmit;

  /// Text to display on the submit button
  final String submitButtonText;

  /// The merchant ID for fetching categories
  final String merchantId;

  @override
  State<MerchantMenuForm> createState() => _MerchantMenuFormState();
}

class _MerchantMenuFormState extends State<MerchantMenuForm> {
  late final FormController _formController;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  late final TextEditingController _newCategoryController;

  MerchantMenuCategory? _selectedCategory;
  int _stock = 0;
  File? _imageFile;
  bool _isProgrammaticUpdate = false;
  bool _showNewCategoryField = false;

  bool get _isEditMode => widget.initialMenu != null;

  @override
  void initState() {
    super.initState();
    _formController = FormController();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController(text: "0");
    _newCategoryController = TextEditingController();

    _initializeForm();

    // Fetch categories
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MerchantMenuCategoryCubit>().getCategories(
        merchantId: widget.merchantId,
      );
    });
  }

  void _initializeForm() {
    final menu = widget.initialMenu;
    if (menu != null) {
      _nameController.text = menu.name;
      _priceController.text = menu.price.toInt().toString();
      _stock = menu.stock;
      _stockController.text = menu.stock.toString();
      // Category will be set after categories are loaded
    }
  }

  @override
  void dispose() {
    _formController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _newCategoryController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final isValid = _formController.errors.isEmpty;

    if (!isValid) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_fill_all_required_fields,
      );
      return;
    }

    final name = _nameController.text.trim();
    final priceStr = _priceController.text.trim();

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

    final price = int.tryParse(priceStr.replaceAll(RegExp("[^0-9]"), ""));
    if (price == null || price <= 0) {
      _showToast(context.l10n.error_validation, context.l10n.error_valid_price);
      return;
    }

    widget.onSubmit(
      MenuFormData(
        name: name,
        price: price,
        stock: _stock,
        categoryId: _selectedCategory?.id,
        imageFile: _imageFile,
      ),
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
      _isProgrammaticUpdate = true;
      _stockController.text = _stock.toString();
      _isProgrammaticUpdate = false;
    });
  }

  void _decrementStock() {
    setState(() {
      _stock = (_stock - 1).clamp(0, 999);
      _isProgrammaticUpdate = true;
      _stockController.text = _stock.toString();
      _isProgrammaticUpdate = false;
    });
  }

  Future<void> _handleCreateCategory() async {
    final categoryName = _newCategoryController.text.trim();
    if (categoryName.isEmpty) {
      _showToast(
        context.l10n.error_validation,
        context.l10n.error_category_name_required,
      );
      return;
    }

    final cubit = context.read<MerchantMenuCategoryCubit>();
    await cubit.createCategory(
      merchantId: widget.merchantId,
      name: categoryName,
    );

    if (!mounted) return;

    // Check if creation was successful
    final state = cubit.state;
    if (state.category.isSuccess) {
      setState(() {
        _selectedCategory = state.category.data?.value;
        _showNewCategoryField = false;
        _newCategoryController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeScrollWrapper(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100.h),
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: Form(
                controller: _formController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.h,
                  children: [
                    _buildCategoryField(),
                    _buildImagePicker(),
                    _buildNameField(),
                    _buildPriceField(),
                    _buildStockField(),
                  ],
                ),
              ),
            ),
          ),
        ),
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildCategoryField() {
    return BlocConsumer<MerchantMenuCategoryCubit, MerchantMenuCategoryState>(
      listener: (context, state) {
        // Set the selected category when categories are loaded (for edit mode)
        if (state.categories.isSuccess &&
            _isEditMode &&
            _selectedCategory == null) {
          final menu = widget.initialMenu;
          if (menu?.categoryId != null) {
            final categories = state.categories.data?.value ?? [];
            final match = categories
                .where((c) => c.id == menu!.categoryId)
                .firstOrNull;
            if (match != null) {
              setState(() => _selectedCategory = match);
            }
          }
        }
      },
      builder: (context, state) {
        final categories = state.categories.data?.value ?? [];
        final isLoading = state.categories.isLoading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.h,
          children: [
            Text(
              context.l10n.label_menu_category,
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_showNewCategoryField) ...[
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _newCategoryController,
                      placeholder: Text(context.l10n.placeholder_category_name),
                      enabled: !state.category.isLoading,
                    ),
                  ),
                  IconButton(
                    onPressed: state.category.isLoading
                        ? null
                        : _handleCreateCategory,
                    icon: state.category.isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(LucideIcons.check, size: 16),
                    variance: ButtonVariance.primary,
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      _showNewCategoryField = false;
                      _newCategoryController.clear();
                    }),
                    icon: const Icon(LucideIcons.x, size: 16),
                    variance: ButtonVariance.outline,
                  ),
                ],
              ),
            ] else ...[
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : Select<MerchantMenuCategory>(
                              enabled:
                                  !widget.isLoading && categories.isNotEmpty,
                              itemBuilder: (context, item) => Text(item.name),
                              value: _selectedCategory,
                              placeholder: Text(
                                categories.isEmpty
                                    ? context.l10n.placeholder_no_categories
                                    : context.l10n.placeholder_select_category,
                              ),
                              onChanged: (value) =>
                                  setState(() => _selectedCategory = value),
                              popup: SelectPopup<MerchantMenuCategory>(
                                items: SelectItemList(
                                  children: categories
                                      .map(
                                        (e) => SelectItemButton(
                                          value: e,
                                          child: Text(e.name),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ).call,
                            ),
                    ),
                  ),
                  IconButton(
                    onPressed: widget.isLoading
                        ? null
                        : () => setState(() => _showNewCategoryField = true),
                    icon: const Icon(LucideIcons.plus, size: 16),
                    variance: ButtonVariance.outline,
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildImagePicker() {
    return AuthImagePicker(
      label: context.l10n.label_menu_photo,
      previewUrl: _isEditMode ? widget.initialMenu?.image : null,
      value: _imageFile,
      onChanged: (file) => setState(() => _imageFile = file),
    );
  }

  Widget _buildNameField() {
    return AuthTextField(
      formKey: MenuFormKeys.name,
      controller: _nameController,
      label: context.l10n.label_menu_name,
      placeholder: context.l10n.placeholder_menu_name,
      icon: LucideIcons.coffee,
      validator: const LengthValidator(min: 3),
      enabled: !widget.isLoading,
      maxLength: 150,
    );
  }

  Widget _buildPriceField() {
    return AuthTextField(
      formKey: MenuFormKeys.price,
      controller: _priceController,
      label: context.l10n.label_menu_price,
      placeholder: context.l10n.placeholder_menu_price,
      icon: LucideIcons.dollarSign,
      validator: const LengthValidator(min: 1),
      enabled: !widget.isLoading,
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildStockField() {
    return Row(
      spacing: 8.w,
      children: [
        Expanded(
          child: FormField(
            key: MenuFormKeys.stock,
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
              enabled: !widget.isLoading,
              keyboardType: TextInputType.number,
              features: const [InputFeature.leading(Icon(LucideIcons.package))],
              onChanged: (value) {
                // Skip if this is a programmatic update from increment/decrement buttons
                if (_isProgrammaticUpdate) return;

                final intValue = int.tryParse(value) ?? 0;
                final clampedValue = intValue.clamp(0, 999);
                setState(() {
                  _stock = clampedValue;
                });
                if (clampedValue != intValue) {
                  _isProgrammaticUpdate = true;
                  _stockController.text = clampedValue.toString();
                  _stockController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _stockController.text.length),
                  );
                  _isProgrammaticUpdate = false;
                }
              },
            ),
          ),
        ),
        IconButton(
          onPressed: widget.isLoading ? null : _decrementStock,
          icon: const Icon(LucideIcons.minus, size: 16),
          variance: ButtonVariance.primary,
        ),
        IconButton(
          onPressed: widget.isLoading ? null : _incrementStock,
          icon: const Icon(LucideIcons.plus, size: 16),
          variance: ButtonVariance.primary,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Positioned(
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
              onPressed: widget.isLoading ? null : _handleSubmit,
              child: widget.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      widget.submitButtonText,
                      style: context.typography.small.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
