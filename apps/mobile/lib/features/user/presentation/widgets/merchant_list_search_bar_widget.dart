import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                widget.onSearch(value);
              },
              decoration: InputDecoration(
                hintText: 'Search merchants...',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14.sp),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[600]),
                suffixIcon: _searchController.text.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          widget.onClear();
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.grey[600],
                          size: 20.sp,
                        ),
                      )
                    : null,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
