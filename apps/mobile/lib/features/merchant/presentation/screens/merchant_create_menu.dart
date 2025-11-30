import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

enum UploadMenuPhotos { menuPhoto }

enum PickMenuCategoryEnum {
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
  static const FormKey<PickMenuCategoryEnum> menuCategory =
      SelectKey<PickMenuCategoryEnum>('menu-category');
  static const FormKey<String> menuName = TextFieldKey('menu-name');
  static const FormKey<String> menuDescription = TextFieldKey(
    'menu-description',
  );
  static const FormKey<String> menuPrice = TextFieldKey('menu-price');
  static const FormKey<String> menuStock = TextFieldKey('menu-stock');
}

class MerchantCreateMenuScreen extends StatefulWidget {
  const MerchantCreateMenuScreen({super.key});

  @override
  State<MerchantCreateMenuScreen> createState() =>
      _MerchantCreateMenuScreenState();
}

class _MerchantCreateMenuScreenState extends State<MerchantCreateMenuScreen> {
  late final FormController _formController;
  late final TextEditingController _stockController;

  PickMenuCategoryEnum? _selectedMenuCategory;
  bool _isLoading = false;
  int _stock = 0;

  final Map<UploadMenuPhotos, File?> _menuPhoto = {
    for (var doc in UploadMenuPhotos.values) doc: null,
  };

  final Map<UploadMenuPhotos, String?> _menuPhotosErrors = {
    for (var doc in UploadMenuPhotos.values) doc: null,
  };

  @override
  void initState() {
    super.initState();
    _formController = FormController();
    _stockController = TextEditingController(text: _stock.toString());
  }

  @override
  void dispose() {
    _formController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveChanges() async {
    final isValid = _formController.errors.isEmpty;

    if (!isValid) {
      _showToast(
        'Validation Error',
        'Please fill all required fields correctly',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        _showToast('Success', 'Menu updated successfully');
      }
    } catch (e) {
      if (mounted) {
        _showToast('Error', 'Failed to update menu');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
    return Stack(
      children: [
        MyScaffold(
          safeArea: true,
          headers: const [DefaultAppBar(title: 'Create Menu')],
          body: Form(
            controller: _formController,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
                  _buildEnumSelect<PickMenuCategoryEnum>(
                    label: 'Menu Category',
                    key: _FormKeys.menuCategory,
                    placeholder: 'Drink',
                    icon: LucideIcons.store,
                    value: _selectedMenuCategory,
                    items: PickMenuCategoryEnum.values,
                    enabled: !_isLoading,
                    onChanged: (value) =>
                        setState(() => _selectedMenuCategory = value),
                  ),

                  _buildImagePicker(
                    "Menu's Photo",
                    UploadMenuPhotos.menuPhoto,
                    _menuPhoto,
                    _menuPhotosErrors,
                    context,
                    isOptional: true,
                  ),

                  _buildTextField(
                    key: _FormKeys.menuName,
                    label: "Menu's Name",
                    placeholder: 'Butterscotch Milk',
                    icon: LucideIcons.coffee,
                    validator: const LengthValidator(min: 3),
                    enabled: !_isLoading,
                    maxLength: 150,
                  ),

                  _buildTextField(
                    key: _FormKeys.menuDescription,
                    label: "Menu's Description",
                    placeholder: 'Combined coffee and brown sugar',
                    icon: LucideIcons.book,
                    validator: const LengthValidator(min: 3),
                    enabled: !_isLoading,
                    maxLength: 250,
                    maxLines: 3,
                  ),

                  _buildTextField(
                    key: _FormKeys.menuPrice,
                    label: "Menu's Price",
                    placeholder: 'Rp 30.000',
                    icon: LucideIcons.dollarSign,
                    validator: const LengthValidator(min: 3),
                    enabled: !_isLoading,
                  ),
                  _buildStockField(),
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
                  onPressed: _isLoading ? null : _handleSaveChanges,
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          'Create',
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
  }

  Widget _buildTextField<T>({
    required FormKey<String> key,
    required String label,
    required String placeholder,
    required IconData icon,
    required Validator<T> validator,
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

  Widget _buildStockField() {
    return Row(
      spacing: 8.w,
      children: [
        Expanded(
          child: FormField(
            key: _FormKeys.menuStock,
            label: Text(
              "Menu's Stock",
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
              placeholder: const Text('0'),
              enabled: !_isLoading,
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
          onPressed: _isLoading ? null : _decrementStock,
          icon: const Icon(LucideIcons.minus, size: 16),
          variance: ButtonVariance.primary,
        ),
        IconButton(
          onPressed: _isLoading ? null : _incrementStock,
          icon: const Icon(LucideIcons.plus, size: 16),
          variance: ButtonVariance.primary,
        ),
      ],
    );
  }

  String _formatEnumName(String enumName) {
    final result = enumName.replaceAllMapped(
      RegExp('([A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    return result.trim().substring(0, 1).toUpperCase() +
        result.trim().substring(1);
  }
}
