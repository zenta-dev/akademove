import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MerchantMenuScreen extends StatefulWidget {
  const MerchantMenuScreen({super.key});

  @override
  State<MerchantMenuScreen> createState() => _MerchantMenuScreenState();
}

class _MerchantMenuScreenState extends State<MerchantMenuScreen> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menu = List.generate(12, (index) => 'Butterscotch Milk');
    final filteredMenu = menu
        .where((menu) => menu.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    final width = MediaQuery.of(context).size.width;

    return MyScaffold(
      scrollable: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              spacing: 16.w,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    placeholder: const Text('Search menu...'),
                    onChanged: (value) {
                      setState(() => _query = value);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.plus, size: 18),
                  variance: ButtonVariance.primary,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: filteredMenu.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                childAspectRatio: (width / 2) / (120.h + 58.h),
              ),
              itemBuilder: (context, index) {
                final menu = filteredMenu[index];
                return Card(
                  padding: EdgeInsets.zero,
                  child: Button.ghost(
                    onPressed: () =>
                        context.pushNamed(Routes.merchantMenuDetail.name),
                    child: Column(
                      spacing: 8.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            "assets/images/item's_photo.png",
                            width: double.infinity,
                            height: 95.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                menu,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.typography.small.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(LucideIcons.chevronRight, size: 16.sp),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
