import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class MerchantMenuCubit extends BaseCubit<MerchantMenuState> {
  MerchantMenuCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const MerchantMenuState());

  final MerchantRepository _merchantRepository;

  Future<void> init({required String merchantId}) async {
    await taskManager.execute('init', () async {
      try {
        emit(state.toLoading());
        final res = await _merchantRepository.getMenuList(
          merchantId: merchantId,
        );
        emit(state.toSuccess(list: res.data, message: res.message));
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Init error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    });
  }

  Future<void> loadMenuList({
    required String merchantId,
    int? page,
    int? limit,
    String? query,
  }) async {
    await taskManager.execute('loadMenuList', () async {
      try {
        emit(state.toLoading());
        final res = await _merchantRepository.getMenuList(
          merchantId: merchantId,
          page: page,
          limit: limit,
          query: query,
        );
        emit(state.toSuccess(list: res.data, message: res.message));
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Load menu list error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    });
  }

  Future<void> getMenu({
    required String merchantId,
    required String menuId,
  }) async {
    await taskManager.execute('getMenu', () async {
      try {
        emit(state.toLoading());
        final res = await _merchantRepository.getMenu(
          merchantId: merchantId,
          menuId: menuId,
        );
        emit(state.toSuccess(selected: res.data, message: res.message));
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Get menu error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    });
  }

  Future<void> createMenu({
    required String merchantId,
    required String name,
    required num price,
    required int stock,
    String? category,
    MultipartFile? image,
  }) async {
    await taskManager.execute('createMenu', () async {
      try {
        emit(state.toLoading());
        final res = await _merchantRepository.createMenu(
          merchantId: merchantId,
          name: name,
          price: price,
          stock: stock,
          category: category,
          image: image,
        );

        // Add new menu to the list
        final updatedList = [res.data, ...state.list];

        emit(
          state.toSuccess(
            list: updatedList,
            selected: res.data,
            message: res.message,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Create menu error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    });
  }

  Future<void> updateMenu({
    required String merchantId,
    required String menuId,
    String? name,
    num? price,
    int? stock,
    String? category,
    MultipartFile? image,
  }) async {
    await taskManager.execute('updateMenu', () async {
      try {
        emit(state.toLoading());
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
        final updatedList = state.list.map((menu) {
          if (menu.id == menuId) {
            return res.data;
          }
          return menu;
        }).toList();

        emit(
          state.toSuccess(
            list: updatedList,
            selected: res.data,
            message: res.message,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Update menu error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    });
  }

  Future<void> deleteMenu({
    required String merchantId,
    required String menuId,
  }) async {
    await taskManager.execute('deleteMenu', () async {
      try {
        emit(state.toLoading());
        final res = await _merchantRepository.deleteMenu(
          merchantId: merchantId,
          menuId: menuId,
        );

        // Remove the menu from the list
        final updatedList = state.list
            .where((menu) => menu.id != menuId)
            .toList();

        emit(
          state.toSuccess(
            list: updatedList,
            selected: null,
            message: res.message,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[MerchantMenuCubit] - Delete menu error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.toFailure(e));
      }
    });
  }

  /// Select a menu item for viewing details
  void selectMenu(MerchantMenu menu) {
    emit(state.toSuccess(selected: menu));
  }

  /// Clear selected menu
  void clearSelection() {
    emit(state.toSuccess(selected: null));
  }

  /// Search/filter menus locally (client-side)
  void filterMenus(String query) {
    if (query.isEmpty) {
      // If query is empty, show all menus (assuming we have them)
      emit(state.toSuccess(list: state.list));
    } else {
      // Filter menus by name (case-insensitive)
      final filtered = state.list
          .where(
            (menu) => menu.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(state.toSuccess(list: filtered));
    }
  }

  void reset() => emit(const MerchantMenuState());
}
