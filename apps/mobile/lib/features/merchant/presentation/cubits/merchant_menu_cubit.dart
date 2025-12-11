import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class MerchantMenuCubit extends BaseCubit<MerchantMenuState> {
  MerchantMenuCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const MerchantMenuState());

  final MerchantRepository _merchantRepository;

  void reset() => emit(const MerchantMenuState());

  Future<void> init({required String merchantId}) async {
    await Future.wait([getMenus(merchantId: merchantId)]);
  }

  Future<void> getMenus({
    required String merchantId,
    int? page,
    int? limit,
    String? query,
  }) async => await taskManager.execute('getMenus-$merchantId', () async {
    try {
      emit(state.copyWith(merchantMenus: const OperationResult.loading()));
      final res = await _merchantRepository.getMenuList(
        merchantId: merchantId,
        page: page,
        limit: limit,
        query: query,
      );
      emit(
        state.copyWith(
          merchantMenus: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantMenuCubit] - Get menus error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(merchantMenus: OperationResult.failed(e)));
    }
  });

  Future<void> getMenu({
    required String merchantId,
    required String menuId,
  }) async => await taskManager.execute(
    'getMenu-$merchantId-$menuId',
    () async {
      try {
        emit(
          state.copyWith(selectedMerchantMenu: const OperationResult.loading()),
        );
        final res = await _merchantRepository.getMenu(
          merchantId: merchantId,
          menuId: menuId,
        );
        emit(
          state.copyWith(
            selectedMerchantMenu: OperationResult.success(
              res.data,
              message: res.message,
            ),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Get menu error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(selectedMerchantMenu: OperationResult.failed(e)));
      }
    },
  );

  Future<void> createMenu({
    required String merchantId,
    required String name,
    required num price,
    required int stock,
    String? category,
    MultipartFile? image,
  }) async => await taskManager.execute('createMenu-$merchantId', () async {
    try {
      // PERBAIKAN: Simpan data lama, JANGAN emit loading
      final currentList = state.menus.data?.value ?? [];

      final res = await _merchantRepository.createMenu(
        merchantId: merchantId,
        name: name,
        price: price,
        stock: stock,
        category: category,
        image: image,
      );

      // Add new menu to the list
      final updatedList = [res.data, ...currentList];

      emit(
        state.copyWith(
          merchantMenus: OperationResult.success(
            updatedList,
            message: res.message,
          ),
          selectedMerchantMenu: OperationResult.success(
            res.data,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantMenuCubit] - Create menu error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(merchantMenus: OperationResult.failed(e)));
    }
  });

  Future<void> updateMenu({
    required String merchantId,
    required String menuId,
    String? name,
    num? price,
    int? stock,
    String? category,
    MultipartFile? image,
  }) async =>
      await taskManager.execute('updateMenu-$merchantId-$menuId', () async {
        try {
          // PERBAIKAN: Simpan data lama, JANGAN emit loading
          final currentList = state.menus.data?.value ?? [];

          final res = await _merchantRepository.updateMenu(
            merchantId: merchantId,
            menuId: menuId,
            name: name,
            price: price,
            stock: stock,
            category: category,
            image: image,
          );

          // Update the menu in the list
          final updatedList = currentList.map((menu) {
            if (menu.id == menuId) {
              return res.data;
            }
            return menu;
          }).toList();

          emit(
            state.copyWith(
              merchantMenus: OperationResult.success(
                updatedList,
                message: res.message,
              ),
              selectedMerchantMenu: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantMenuCubit] - Update menu error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(merchantMenus: OperationResult.failed(e)));
        }
      });

  Future<void> deleteMenu({
    required String merchantId,
    required String menuId,
  }) async =>
      await taskManager.execute('deleteMenu-$merchantId-$menuId', () async {
        try {
          // PERBAIKAN: Simpan data lama, JANGAN emit loading
          final currentList = state.menus.data?.value ?? [];

          final res = await _merchantRepository.deleteMenu(
            merchantId: merchantId,
            menuId: menuId,
          );

          // Remove the menu from the list
          final updatedList = currentList
              .where((menu) => menu.id != menuId)
              .toList();

          emit(
            state.copyWith(
              merchantMenus: OperationResult.success(
                updatedList,
                message: res.message,
              ),
              selectedMerchantMenu: OperationResult.idle(),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[MerchantMenuCubit] - Delete menu error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(merchantMenus: OperationResult.failed(e)));
        }
      });

  void selectMenu(MerchantMenu menu) {
    emit(state.copyWith(selectedMerchantMenu: OperationResult.success(menu)));
  }

  void clearSelection() {
    emit(state.copyWith(selectedMerchantMenu: OperationResult.idle()));
  }

  void filterMenus(String query) {
    final currentList = state.menus.data?.value ?? [];
    if (query.isEmpty) {
      // If query is empty, show all menus (assuming we have them)
      emit(state.copyWith(merchantMenus: OperationResult.success(currentList)));
    } else {
      // Filter menus by name (case-insensitive)
      final filtered = currentList
          .where(
            (menu) => menu.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(state.copyWith(merchantMenus: OperationResult.success(filtered)));
    }
  }
}
