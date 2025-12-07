import 'package:akademove/core/_export.dart';
import 'package:akademove/features/merchant/data/repositories/_export.dart';
import 'package:akademove/features/user/presentation/state/_export.dart';
import 'package:api_client/api_client.dart';

class UserMerchantDetailCubit extends BaseCubit<UserMerchantDetailState> {
  UserMerchantDetailCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(UserMerchantDetailState());

  final MerchantRepository _merchantRepository;
  String? _currentMerchantId; // Track current merchant for switching detection

  String? get currentMerchantId => _currentMerchantId;

  /// Fetch merchant details and menu items, group by category
  Future<void> getMerchantDetail(
    String merchantId, {
    required Merchant merchant,
  }) async => await taskManager.execute('UMDC-gMD-$merchantId', () async {
    try {
      emit(state.toLoading());
      _currentMerchantId = merchantId;

      // Fetch menu items for specific merchant
      final menuRes = await _merchantRepository.getMenuList(
        merchantId: merchantId,
        limit: 100,
      );
      final menuItems = menuRes.data;

      // Group items by category
      final groupedMenus = _groupByCategory(menuItems);

      emit(
        state.toSuccess(
          merchant: merchant, // 👈 Use passed merchant instead of fetching
          menuByCategory: groupedMenus,
          message: 'Menu items loaded',
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserMerchantDetailCubit] - getMerchantDetail Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e, message: e.message));
    }
  });

  /// Check if stock decreased during session
  /// Show warning if user's cart quantity exceeds available stock
  Future<void> checkStockChanges(String merchantId) async {
    try {
      // Fetch fresh menu items
      final menuRes = await _merchantRepository.getMenuList(
        merchantId: merchantId,
        limit: 100,
      );
      final freshMenus = menuRes.data;

      // Re-group fresh items
      final freshGrouped = _groupByCategory(freshMenus);

      // Compare with current state and emit warning if stock decreased
      bool hasStockIssue = false;
      for (var freshItem in freshMenus) {
        final oldItem = _getItemFromMenus(freshItem.id);

        if (oldItem != null && oldItem.stock > freshItem.stock) {
          // Stock decreased
          hasStockIssue = true;
          emit(
            state.copyWith(
              warningToast:
                  '${freshItem.name} stock reduced to ${freshItem.stock}',
              menuByCategory: freshGrouped,
            ),
          );
          break;
        }
      }

      if (!hasStockIssue) {
        // Update menu in case of other changes
        emit(state.copyWith(menuByCategory: freshGrouped));
      }
    } catch (e, st) {
      logger.e('Error checking stock changes', error: e, stackTrace: st);
    }
  }

  /// Group menu items by category
  Map<String, List<MerchantMenu>> _groupByCategory(List<MerchantMenu> items) {
    final grouped = <String, List<MerchantMenu>>{};

    for (var item in items) {
      final category = item.category ?? 'Other';
      grouped.putIfAbsent(category, () => []).add(item);
    }

    // Sort categories alphabetically
    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  /// Get item from grouped menus by ID
  MerchantMenu? _getItemFromMenus(String itemId) {
    if (state.menuByCategory == null) return null;

    for (var categoryItems in state.menuByCategory!.values) {
      final found = categoryItems.where((item) => item.id == itemId).toList();
      if (found.isNotEmpty) {
        return found.first;
      }
    }
    return null;
  }

  /// Update warning toast (clear it after display)
  void clearWarning() {
    emit(state.copyWith(warningToast: null));
  }

  /// Reset to initial state
  void reset() {
    _currentMerchantId = null;
    emit(state.reset());
  }
}
