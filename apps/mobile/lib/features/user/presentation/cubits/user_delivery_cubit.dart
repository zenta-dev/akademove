import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserDeliveryCubit extends BaseCubit<UserDeliveryState> {
  UserDeliveryCubit({
    required OrderRepository orderRepository,
    required DriverRepository driverRepository,
    required MapService mapService,
  }) : _orderRepository = orderRepository,
       _driverRepository = driverRepository,
       _mapService = mapService,
       super(const UserDeliveryState());

  final OrderRepository _orderRepository;
  final DriverRepository _driverRepository;
  final MapService _mapService;

  String? _selectedCouponCode;

  String? get selectedCouponCode => _selectedCouponCode;

  void reset() {
    _selectedCouponCode = null;
    emit(const UserDeliveryState());
  }

  void clearSearchPlaces() => emit(
    state.toSuccess(
      searchPlaces: OperationResult.success(
        const PageTokenPaginationResult(data: []),
      ),
    ),
  );

  void setPickupLocation(Place pickup) {
    emit(state.toSuccess(pickup: pickup));
  }

  void setDropoffLocation(Place dropoff) {
    emit(state.toSuccess(dropoff: dropoff));
  }

  void setSelectedCoupon(String? couponCode) {
    _selectedCouponCode = couponCode;
  }

  Future<void> getNearbyPlaces(
    Coordinate coord, {
    bool isRefresh = false,
  }) async => await taskManager.execute('UDC-gNP-${coord.hashCode}', () async {
    try {
      if (isRefresh && state.nearbyPlaces.value?.token == null) {
        emit(state.toLoading());
      }

      final res = await _mapService.nearbyLocation(
        coord,
        nextPageToken: isRefresh ? null : state.nearbyPlaces.value?.token,
      );

      final mergedList = isRefresh
          ? res.data
          : [...state.nearbyPlaces.value?.data ?? <Place>[], ...res.data];

      emit(
        state.toSuccess(
          nearbyPlaces: OperationResult.success(
            PageTokenPaginationResult(data: mergedList, token: res.token),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toSuccess(nearbyPlaces: state.nearbyPlaces));
    }
  });

  String? _searchQuery;
  Future<void> searchPlaces(
    String query, {
    Coordinate? coordinate,
    bool isRefresh = false,
  }) async => await taskManager.execute('UDC-sP-$query', () async {
    try {
      if (isRefresh && state.searchPlaces.value?.token == null) {
        emit(state.toLoading());
      }

      if (isRefresh) _searchQuery = query;

      final res = await _mapService.searchPlace(
        query,
        coordinate: coordinate,
        nextPageToken: isRefresh ? null : state.searchPlaces.value?.token,
      );

      final List<Place> mergedList = (_searchQuery == query && !isRefresh)
          ? [...state.searchPlaces.value?.data ?? [], ...res.data]
          : res.data;

      emit(
        state.toSuccess(
          searchPlaces: OperationResult.success(
            PageTokenPaginationResult<List<Place>>(
              data: mergedList,
              token: res.token,
            ),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toSuccess(searchPlaces: state.searchPlaces));
    }
  });

  void setDeliveryDetails(
    String description,
    double weight, {
    String? specialInstructions,
    List<File>? itemPhotos,
  }) {
    emit(
      state.toSuccess(
        details: DeliveryDetails(
          description: description,
          weight: weight,
          specialInstructions: specialInstructions,
          itemPhotos: itemPhotos ?? [],
        ),
      ),
    );
  }

  void addItemPhoto(File photo) {
    final details = state.details;
    if (details == null) return;

    // Max 3 photos
    if (details.itemPhotos.length >= 3) {
      emit(
        state.toFailure(
          const RepositoryError('Maximum 3 photos allowed'),
          message: 'Maximum 3 photos allowed',
        ),
      );
      return;
    }

    emit(
      state.toSuccess(
        details: DeliveryDetails(
          description: details.description,
          weight: details.weight,
          specialInstructions: details.specialInstructions,
          itemPhotos: [...details.itemPhotos, photo],
        ),
      ),
    );
  }

  void removeItemPhoto(int index) {
    final details = state.details;
    if (details == null) return;

    final updatedPhotos = List<File>.from(details.itemPhotos)..removeAt(index);

    emit(
      state.toSuccess(
        details: DeliveryDetails(
          description: details.description,
          weight: details.weight,
          specialInstructions: details.specialInstructions,
          itemPhotos: updatedPhotos,
        ),
      ),
    );
  }

  Future<void> estimate() async => await taskManager.execute('UDC-e', () async {
    try {
      final pickup = state.pickup;
      final dropoff = state.dropoff;
      final details = state.details;

      if (pickup == null || dropoff == null || details == null) {
        emit(
          state.toFailure(
            const RepositoryError('Missing delivery information'),
          ),
        );
        return;
      }

      emit(state.toLoading());

      final res = await _orderRepository.estimate(
        EstimateOrderQuery(
          type: OrderType.DELIVERY,
          pickupLocation: pickup.toCoordinate(),
          dropoffLocation: dropoff.toCoordinate(),
          weight: details.weight,
        ),
      );

      emit(
        state.toSuccess(
          estimate: OperationResult.success(
            DeliveryEstimateResult(
              summary: res.data,
              pickup: pickup,
              dropoff: dropoff,
              details: details,
            ),
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  Future<PlaceOrderResponse?> placeDeliveryOrder(
    PaymentMethod method, {
    BankProvider? bankProvider,
    String? couponCode,
  }) async => await taskManager.execute('UDC-pDO-${method.hashCode}', () async {
    try {
      final estimate = state.estimate.value;
      if (estimate == null) {
        emit(
          state.toFailure(const RepositoryError('Please get estimate first')),
        );
        return null;
      }

      emit(state.toLoading());

      final res = await _orderRepository.placeOrder(
        PlaceOrder(
          dropoffLocation: estimate.dropoff.toCoordinate(),
          pickupLocation: estimate.pickup.toCoordinate(),
          type: OrderType.DELIVERY,
          note: OrderNote(
            pickup: 'Pickup: ${estimate.details.description}',
            dropoff: 'Weight: ${estimate.details.weight}kg',
            instructions: estimate.details.specialInstructions,
          ),
          couponCode: couponCode,
          payment: PlaceOrderPayment(
            provider: PaymentProvider.MIDTRANS,
            method: method,
            bankProvider: bankProvider,
          ),
        ),
      );

      emit(state.toSuccess(message: res.message));
      return res.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserDeliveryCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
      return null;
    }
  });

  Future<void> getNearbyDrivers(GetDriverNearbyQuery req) async =>
      await taskManager.execute('UDC-gND-${req.hashCode}', () async {
        try {
          emit(state.toLoading());

          final res = await _driverRepository.getDriverNearby(req);

          final mergedList = {
            for (final item in state.nearbyDrivers.value ?? <Driver>[])
              item.id: item,
            for (final item in res.data) item.id: item,
          }.values.toList();

          emit(
            state.toSuccess(
              nearbyDrivers: OperationResult.success(
                mergedList,
                message: res.message,
              ),
              message: res.message,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserRideCubit] - Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toSuccess(nearbyDrivers: state.nearbyDrivers));
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
        '[UserRideCubit] - getRoutes error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      return [];
    }
  }
}
