import 'package:akademove/core/_export.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ListPlacesWidget extends StatelessWidget {
  const ListPlacesWidget({
    required this.places,
    required this.hasMore,
    required this.isLoading,
    this.scrollController,
    this.onItemTap,
    super.key,
  });

  final List<Place> places;
  final bool hasMore;
  final bool isLoading;
  final ScrollController? scrollController;
  final void Function(Place val)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => Gap(8.h),
      controller: scrollController,
      itemCount: hasMore ? places.length + 1 : places.length,
      itemBuilder: (context, index) {
        if (index >= places.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return _buildCard(context, places[index]);
      },
    );
  }

  Widget _buildCard(BuildContext context, Place place) => Button(
    style: const ButtonStyle.ghost(density: ButtonDensity.compact),
    onPressed: onItemTap != null ? () => onItemTap!(place) : null,
    child: Card(
      padding: EdgeInsets.all(8.dg),
      child: Row(
        spacing: 8.w,
        children: [
          Column(
            spacing: 4.h,
            children: [
              CachedNetworkImage(
                imageUrl: place.icon,
                imageBuilder: (context, imageProvider) => Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                  ),
                ).asSkeleton(),
                errorWidget: (context, url, error) => Icon(
                  LucideIcons.info,
                  size: 24.sp,
                ),
              ),
              DefaultText(
                place.distance.toString(),
                fontSize: 12.sp,
              ).asSkeleton(enabled: place.distance == null),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                DefaultText(place.name),
                DefaultText(
                  place.vicinity,
                  fontSize: 14.sp,
                  color: context.colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
