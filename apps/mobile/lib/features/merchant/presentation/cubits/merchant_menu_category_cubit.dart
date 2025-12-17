import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class MerchantMenuCategoryCubit extends BaseCubit<MerchantMenuCategoryState> {
  MerchantMenuCategoryCubit({
    required MerchantMenuCategoryRepository menuCategoryRepository,
  }) : _menuCategoryRepository = menuCategoryRepository,
       super(const MerchantMenuCategoryState());

  final MerchantMenuCategoryRepository _menuCategoryRepository;

  void reset() => emit(const MerchantMenuCategoryState());

  /// Initialize cubit by fetching categories for a merchant
  Future<void> init({required String merchantId}) async {
    await getCategories(merchantId: merchantId);
  }

  /// Get list of menu categories for a merchant
  Future<void> getCategories({
    required String merchantId,
    int? page,
    int? limit,
    String? query,
  }) async => await taskManager.execute('getCategories-$merchantId', () async {
    try {
      emit(state.copyWith(categories: const OperationResult.loading()));
      final res = await _menuCategoryRepository.list(
        merchantId: merchantId,
        page: page,
        limit: limit,
        query: query,
      );
      emit(
        state.copyWith(
          categories: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantMenuCategoryCubit] - Get categories error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(categories: OperationResult.failed(e)));
    }
  });

  /// Get a single menu category by ID
  Future<void> getCategory({
    required String merchantId,
    required String categoryId,
  }) async => await taskManager.execute(
    'getCategory-$merchantId-$categoryId',
    () async {
      try {
        emit(state.copyWith(category: const OperationResult.loading()));
        final res = await _menuCategoryRepository.get(
          merchantId: merchantId,
          categoryId: categoryId,
        );
        emit(
          state.copyWith(
            category: OperationResult.success(res.data, message: res.message),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCategoryCubit] - Get category error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(category: OperationResult.failed(e)));
      }
    },
  );

  /// Create a new menu category
  Future<void> createCategory({
    required String merchantId,
    required String name,
    String? description,
    int? sortOrder,
  }) async => await taskManager.execute('createCategory-$merchantId', () async {
    try {
      // Preserve current list, emit loading for category
      final currentList = state.categories.data?.value ?? [];
      emit(state.copyWith(category: const OperationResult.loading()));

      final res = await _menuCategoryRepository.create(
        merchantId: merchantId,
        name: name,
        description: description,
        sortOrder: sortOrder,
      );

      // Add new category to the list
      final updatedList = [res.data, ...currentList];

      emit(
        state.copyWith(
          categories: OperationResult.success(
            updatedList,
            message: res.message,
          ),
          category: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantMenuCategoryCubit] - Create category error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(category: OperationResult.failed(e)));
    }
  });

  /// Update an existing menu category
  Future<void> updateCategory({
    required String merchantId,
    required String categoryId,
    String? name,
    String? description,
    int? sortOrder,
  }) async => await taskManager.execute(
    'updateCategory-$merchantId-$categoryId',
    () async {
      try {
        // Preserve current list, emit loading for category
        final currentList = state.categories.data?.value ?? [];
        emit(state.copyWith(category: const OperationResult.loading()));

        final res = await _menuCategoryRepository.update(
          merchantId: merchantId,
          categoryId: categoryId,
          name: name,
          description: description,
          sortOrder: sortOrder,
        );

        // Update the category in the list
        final updatedList = currentList.map((cat) {
          if (cat.id == categoryId) {
            return res.data;
          }
          return cat;
        }).toList();

        emit(
          state.copyWith(
            categories: OperationResult.success(
              updatedList,
              message: res.message,
            ),
            category: OperationResult.success(res.data, message: res.message),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCategoryCubit] - Update category error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(category: OperationResult.failed(e)));
      }
    },
  );

  /// Delete a menu category
  Future<void> deleteCategory({
    required String merchantId,
    required String categoryId,
  }) async => await taskManager.execute(
    'deleteCategory-$merchantId-$categoryId',
    () async {
      try {
        // Preserve current list
        final currentList = state.categories.data?.value ?? [];

        final res = await _menuCategoryRepository.remove(
          merchantId: merchantId,
          categoryId: categoryId,
        );

        // Remove the category from the list
        final updatedList = currentList
            .where((cat) => cat.id != categoryId)
            .toList();

        emit(
          state.copyWith(
            categories: OperationResult.success(
              updatedList,
              message: res.message,
            ),
            category: const OperationResult.idle(),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCategoryCubit] - Delete category error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(categories: OperationResult.failed(e)));
      }
    },
  );

  /// Select a category (for editing)
  void selectCategory(MerchantMenuCategory category) {
    emit(state.copyWith(category: OperationResult.success(category)));
  }

  /// Clear selected category
  void clearSelection() {
    emit(state.copyWith(category: const OperationResult.idle()));
  }
}
