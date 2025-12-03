import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class UserDeliveryDetailsScreen extends StatefulWidget {
  const UserDeliveryDetailsScreen({super.key});

  @override
  State<UserDeliveryDetailsScreen> createState() =>
      _UserDeliveryDetailsScreenState();
}

class _UserDeliveryDetailsScreenState extends State<UserDeliveryDetailsScreen> {
  late TextEditingController descriptionController;
  late TextEditingController weightController;
  late TextEditingController instructionsController;
  double weight = 1.0;

  @override
  void initState() {
    super.initState();
    descriptionController = TextEditingController();
    weightController = TextEditingController(text: '1.0');
    instructionsController = TextEditingController();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    weightController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [
        AppBar(
          padding: EdgeInsets.all(4.dg),
          title: Text(
            context.l10n.title_delivery_details,
            style: context.typography.h4.copyWith(fontSize: 18.sp),
          ),
          leading: [
            IconButton(
              onPressed: () => context.pop(),
              icon: Icon(LucideIcons.chevronLeft, size: 20.sp),
              variance: const ButtonStyle.ghost(),
            ),
          ],
        ),
      ],
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          spacing: 24.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                DefaultText(
                  context.l10n.label_item_description,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                TextField(
                  controller: descriptionController,
                  placeholder: Text(context.l10n.placeholder_item_description),
                  maxLines: 3,
                  minLines: 3,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                DefaultText(
                  context.l10n.label_weight_kg,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                TextField(
                  controller: weightController,
                  placeholder: Text(context.l10n.placeholder_weight_kg),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  onChanged: (value) {
                    final parsed = double.tryParse(value);
                    if (parsed != null) {
                      setState(() {
                        weight = parsed;
                      });
                    }
                  },
                ),
                Text(
                  context.l10n.text_maximum_weight,
                  style: context.typography.small.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                DefaultText(
                  context.l10n.special_instructions,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                TextField(
                  controller: instructionsController,
                  placeholder: Text(context.l10n.special_instructions_hint),
                  maxLines: 2,
                  minLines: 2,
                ),
                Text(
                  context.l10n.text_special_handling_instructions,
                  style: context.typography.small.copyWith(
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            BlocBuilder<UserDeliveryCubit, UserDeliveryState>(
              builder: (context, state) {
                final photos = state.details?.itemPhotos ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    DefaultText(
                      context.l10n.label_item_photos_optional,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 12.h,
                      children: [
                        ...List.generate(photos.length, (index) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 100.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: FileImage(photos[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -8,
                                top: -8,
                                child: GestureDetector(
                                  onTap: () => context
                                      .read<UserDeliveryCubit>()
                                      .removeItemPhoto(index),
                                  child: Container(
                                    padding: EdgeInsets.all(4.dg),
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.destructive,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      LucideIcons.x,
                                      size: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        if (photos.length < 3)
                          ImagePickerWidget(
                            size: Size(100.w, 100.h),
                            onValueChanged: (file) {
                              if (file.existsSync()) {
                                context.read<UserDeliveryCubit>().addItemPhoto(
                                  file,
                                );
                              }
                            },
                          ),
                      ],
                    ),
                    Text(
                      context.l10n.text_add_up_to_3_photos,
                      style: context.typography.small.copyWith(
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Button.primary(
                onPressed: () {
                  final description = descriptionController.text.trim();
                  if (description.isEmpty) {
                    context.showMyToast(
                      context.l10n.toast_provide_item_description,
                      type: ToastType.failed,
                    );
                    return;
                  }
                  if (weight <= 0 || weight > 20) {
                    context.showMyToast(
                      context.l10n.toast_weight_must_be_valid,
                      type: ToastType.failed,
                    );
                    return;
                  }

                  final instructions = instructionsController.text.trim();
                  final cubit = context.read<UserDeliveryCubit>();
                  final photos = cubit.state.details?.itemPhotos ?? [];

                  cubit.setDeliveryDetails(
                    descriptionController.text,
                    weight,
                    specialInstructions: instructions.isEmpty
                        ? null
                        : instructions,
                    itemPhotos: photos,
                  );
                  context.read<UserDeliveryCubit>().estimate();
                  context.push(Routes.userDeliverySummary.path);
                },
                child: Text(context.l10n.button_continue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
