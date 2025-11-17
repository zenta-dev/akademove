import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantEditMenuScreen extends StatefulWidget {
  const MerchantEditMenuScreen({super.key});

  @override
  State<MerchantEditMenuScreen> createState() => _MerchantEditMenuScreenState();
}

class _MerchantEditMenuScreenState extends State<MerchantEditMenuScreen> {
  String _category = 'Drink';
  int _stock = 50;

  final _nameController = TextEditingController(text: 'Butterscotch Milk');
  final _descController = TextEditingController(
    text: 'Combined coffee and brown sugar',
  );
  final _priceController = TextEditingController(text: 'Rp 30.000');

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          safeArea: true,
          headers: const [
            DefaultAppBar(
              title: 'Edit Menu',
            ),
          ],
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16.h,
              children: [
                _buildLabel('Category'),
                SizedBox(
                  width: double.infinity,
                  child: Select<String>(
                    value: _category,
                    itemBuilder: (context, item) => Text(item),
                    placeholder: const Text('Select category'),
                    onChanged: (value) {
                      if (value != null) setState(() => _category = value);
                    },
                    popup: (context) {
                      return const SelectPopup<String>();
                    },
                  ),
                ),

                _buildLabel('Menu’s Photo'),
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(
                          'assets/images/item_photo.png',
                          width: 150.w,
                          height: 150.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: IconButton(
                          onPressed: () {},
                          variance: ButtonVariance.secondary,
                          icon: const Icon(LucideIcons.penLine, size: 14),
                        ),
                      ),
                    ],
                  ),
                ),

                _buildLabel('Menu’s Name'),
                TextField(
                  controller: _nameController,
                  placeholder: Text(
                    'Butterscotch Milk',
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  maxLength: 150,
                ),

                _buildLabel('Menu’s Description'),
                TextField(
                  controller: _descController,
                  placeholder: Text(
                    'Combined coffee and brown sugar',
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  maxLength: 250,
                  maxLines: 3,
                ),

                _buildLabel('Menu’s Price'),
                TextField(
                  controller: _priceController,
                  placeholder: Text(
                    'Rp 30.000',
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                _buildLabel('Menu’s Stock'),
                Row(
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: _stock.toString(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          setState(() => _stock = (_stock - 1).clamp(0, 999)),
                      icon: const Icon(LucideIcons.minus, size: 16),
                      variance: ButtonVariance.primary,
                    ),
                    IconButton(
                      onPressed: () =>
                          setState(() => _stock = (_stock + 1).clamp(0, 999)),
                      icon: const Icon(LucideIcons.plus, size: 16),
                      variance: ButtonVariance.primary,
                    ),
                  ],
                ),
              ],
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
                  onPressed: () {},
                  child: Text(
                    'Save changes',
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: context.typography.small.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
