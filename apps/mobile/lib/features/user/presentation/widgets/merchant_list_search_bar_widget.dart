import 'package:akademove/core/_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Search bar widget for filtering merchants by name
/// Includes search input field and filter options
class MerchantListSearchBarWidget extends StatefulWidget {
  const MerchantListSearchBarWidget({
    super.key,
    required this.onSearch,
    required this.onClear,
    this.initialValue = '',
  });

  final Function(String) onSearch;
  final VoidCallback onClear;
  final String initialValue;

  @override
  State<MerchantListSearchBarWidget> createState() =>
      _MerchantListSearchBarWidgetState();
}

class _MerchantListSearchBarWidgetState
    extends State<MerchantListSearchBarWidget> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          // Search input field
          Row(
            children: [
              Icon(
                LucideIcons.search,
                color: context.colorScheme.mutedForeground,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    widget.onSearch(value);
                    setState(() {});
                  },
                  placeholder: const Text('Search merchants...'),
                ),
              ),
              if (_searchController.text.isNotEmpty) ...[
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    widget.onClear();
                    setState(() {});
                  },
                  child: Icon(
                    LucideIcons.x,
                    color: context.colorScheme.mutedForeground,
                    size: 20.sp,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
