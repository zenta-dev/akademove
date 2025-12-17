import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Unified cubit for order location-related operations.
/// Replaces UserRideCubit and UserDeliveryCubit by merging common functionality:
/// - Fetching nearby drivers
/// - Fetching and searching places
/// - Getting routes between coordinates
/// - Managing map controller
/// - Uploading delivery item photo
class OrderLocationCubit extends BaseCubit<OrderLocationState> {
  OrderLocationCubit({
    required DriverRepository driverRepository,
    required MapService mapService,
    required OrderRepository orderRepository,
  }) : _driverRepository = driverRepository,
       _mapService = mapService,
       _orderRepository = orderRepository,
       super(const OrderLocationState());

  final DriverRepository _driverRepository;
  final MapService _mapService;
  final OrderRepository _orderRepository;

  String? _searchQuery;
  String? _selectedCouponCode;
  OrderNote? _deliveryNote;
  DeliveryItemType? _deliveryItemType;
  String? _deliveryItemPhotoUrl;

  /// Get the currently selected coupon code (used in delivery flow)
  String? get selectedCouponCode => _selectedCouponCode;

  /// Get the delivery note (used in delivery flow)
  OrderNote? get deliveryNote => _deliveryNote;

  /// Get the delivery item type (used in delivery flow)
  DeliveryItemType? get deliveryItemType => _deliveryItemType;

  /// Get the delivery item photo URL (required for DELIVERY orders)
  String? get deliveryItemPhotoUrl => _deliveryItemPhotoUrl;

  /// Set the selected coupon code for order placement
  void setSelectedCoupon(String? couponCode) {
    _selectedCouponCode = couponCode;
  }

  /// Set the delivery note for order placement
  void setDeliveryNote(OrderNote? note) {
    _deliveryNote = note;
  }

  /// Set the delivery item type for order placement
  void setDeliveryItemType(DeliveryItemType? itemType) {
    _deliveryItemType = itemType;
  }

  /// Set the delivery item photo URL for order placement
  void setDeliveryItemPhotoUrl(String? url) {
    _deliveryItemPhotoUrl = url;
  }

  void reset() {
    _searchQuery = null;
    _selectedCouponCode = null;
    _deliveryNote = null;
    _deliveryItemType = null;
    _deliveryItemPhotoUrl = null;
    emit(const OrderLocationState());
  }

  void clearSearchPlaces() => emit(
    state.copyWith(
      searchPlaces: OperationResult.success(
        const PageTokenPaginationResult(data: []),
      ),
    ),
  );

  void setMapController(GoogleMapController controller) {
    emit(state.copyWith(mapController: controller));
  }

  Future<void> getNearbyDrivers(GetDriverNearbyQuery req) async =>
      await taskManager.execute("OLC-gND-${req.hashCode}", () async {
        try {
          emit(state.copyWith(nearbyDrivers: const OperationResult.loading()));

          final res = await _driverRepository.getDriverNearby(req);

          final currentList = state.nearbyDrivers.value ?? [];
          final mergedList = {
            for (final item in currentList) item.id: item,
            for (final item in res.data) item.id: item,
          }.values.toList();

          emit(
            state.copyWith(
              nearbyDrivers: OperationResult.success(
                mergedList,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            "[OrderLocationCubit] - getNearbyDrivers error: ${e.message}",
            error: e,
            stackTrace: st,
          );
          // Keep previous data on error if available, or emit failure
          if (state.nearbyDrivers.value != null) {
            emit(
              state.copyWith(
                nearbyDrivers: OperationResult.success(
                  state.nearbyDrivers.value!,
                ),
              ),
            );
          } else {
            emit(state.copyWith(nearbyDrivers: OperationResult.failed(e)));
          }
        }
      });

  Future<void> getNearbyPlaces(
    Coordinate coord, {
    bool isRefresh = false,
  }) async => await taskManager.execute(
    "OLC-gNP-${coord.hashCode}-$isRefresh",
    () async {
      try {
        final currentToken = state.nearbyPlaces.value?.token;
        if (isRefresh && currentToken == null) {
          emit(state.copyWith(nearbyPlaces: const OperationResult.loading()));
        }

        final res = await _mapService.nearbyLocation(
          coord,
          nextPageToken: isRefresh ? null : currentToken,
        );

        final currentData = state.nearbyPlaces.value?.data ?? [];
        final mergedList = isRefresh ? res.data : [...currentData, ...res.data];

        emit(
          state.copyWith(
            nearbyPlaces: OperationResult.success(
              PageTokenPaginationResult(data: mergedList, token: res.token),
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          "[OrderLocationCubit] - getNearbyPlaces error: ${e.message}",
          error: e,
          stackTrace: st,
        );
        if (state.nearbyPlaces.value != null) {
          emit(
            state.copyWith(
              nearbyPlaces: OperationResult.success(state.nearbyPlaces.value!),
            ),
          );
        } else {
          emit(state.copyWith(nearbyPlaces: OperationResult.failed(e)));
        }
      }
    },
  );

  Future<void> searchPlaces(
    String query, {
    Coordinate? coordinate,
    bool isRefresh = false,
  }) async => await taskManager.execute("OLC-sP-$query", () async {
    try {
      final isNewQuery = _searchQuery != query;
      final currentToken = state.searchPlaces.value?.token;

      if (isNewQuery || (isRefresh && currentToken == null)) {
        emit(state.copyWith(searchPlaces: const OperationResult.loading()));
      }

      final res = await _mapService.searchPlace(
        query,
        coordinate: coordinate,
        nextPageToken: (isRefresh || isNewQuery) ? null : currentToken,
      );

      final currentData = state.searchPlaces.value?.data ?? [];
      final mergedList = (isRefresh || isNewQuery)
          ? res.data
          : [...currentData, ...res.data];

      _searchQuery = query;

      emit(
        state.copyWith(
          searchPlaces: OperationResult.success(
            PageTokenPaginationResult(data: mergedList, token: res.token),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        "[OrderLocationCubit] - searchPlaces error: ${e.message}",
        error: e,
        stackTrace: st,
      );
      if (state.searchPlaces.value != null) {
        emit(
          state.copyWith(
            searchPlaces: OperationResult.success(state.searchPlaces.value!),
          ),
        );
      } else {
        emit(state.copyWith(searchPlaces: OperationResult.failed(e)));
      }
    }
  });

  Future<List<Coordinate>> getRoutes(
    Coordinate origin,
    Coordinate destination,
  ) async {
    try {
      return await _mapService.getRoutes(origin, destination);
    } on BaseError catch (e, st) {
      logger.e(
        "[OrderLocationCubit] - getRoutes error: ${e.message}",
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }

  /// Upload delivery item photo for DELIVERY orders
  /// User must upload a photo of the item before placing a delivery order
  /// Returns the URL of the uploaded photo
  Future<String?> uploadDeliveryItemPhoto(String filePath) async {
    return await taskManager.execute("OLC-uDIP", () async {
      try {
        emit(
          state.copyWith(
            uploadDeliveryItemPhoto: const OperationResult.loading(),
          ),
        );

        final res = await _orderRepository.uploadUserDeliveryItemPhoto(
          filePath,
        );

        _deliveryItemPhotoUrl = res.data;

        emit(
          state.copyWith(
            uploadDeliveryItemPhoto: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );

        return res.data;
      } on BaseError catch (e, st) {
        logger.e(
          "[OrderLocationCubit] - uploadDeliveryItemPhoto error: ${e.message}",
          error: e,
          stackTrace: st,
        );
        emit(
          state.copyWith(uploadDeliveryItemPhoto: OperationResult.failed(e)),
        );
        return null;
      }
    });
  }

  /// Clear the uploaded delivery item photo
  void clearDeliveryItemPhoto() {
    _deliveryItemPhotoUrl = null;
    emit(state.copyWith(uploadDeliveryItemPhoto: const OperationResult.idle()));
  }
}
