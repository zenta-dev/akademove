import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
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
    this.category,
    this.imageFile,
  });

  final String name;
  final int price;
  final int stock;
  final MenuCategory? category;
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
  });

  /// The menu to edit (null for create mode)
  final MerchantMenu? initialMenu;

  /// Whether the form is currently submitting
  final bool isLoading;

  /// Callback when form is submitted with valid data
  final void Function(MenuFormData data) onSubmit;

  /// Text to display on the submit button
  final String submitButtonText;

  @override
  State<MerchantMenuForm> createState() => _MerchantMenuFormState();
}

class _MerchantMenuFormState extends State<MerchantMenuForm> {
  late final FormController _formController;
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;

  MenuCategory? _selectedCategory;
  int _stock = 0;
  File? _imageFile;
  bool _isFirstFrame = true;

  bool get _isEditMode => widget.initialMenu != null;

  @override
  void initState() {
    super.initState();
    _formController = FormController();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _stockController = TextEditingController(text: "0");

    _initializeForm();

    // Allow scroll notifications after first frame to prevent
    // "Build scheduled during frame" error from RefreshTrigger
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _isFirstFrame = false);
      }
    });
  }

  void _initializeForm() {
    final menu = widget.initialMenu;
    if (menu != null) {
      _nameController.text = menu.name;
      _priceController.text = menu.price.toInt().toString();
      _stock = menu.stock;
      _stockController.text = menu.stock.toString();
      _selectedCategory = MenuCategory.fromString(menu.category);
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
        category: _selectedCategory,
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
    return Stack(
      children: [
        SingleChildScrollView(
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
        _buildSubmitButton(),
      ],
    );
  }

  Widget _buildCategoryField() {
    return AuthEnumSelect<MenuCategory>(
      label: context.l10n.label_menu_category,
      placeholder: context.l10n.placeholder_select_category,
      value: _selectedCategory,
      items: MenuCategory.values,
      enabled: !widget.isLoading,
      itemBuilder: (context, item) => Text(item.displayName),
      onChanged: (value) => setState(() => _selectedCategory = value),
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
