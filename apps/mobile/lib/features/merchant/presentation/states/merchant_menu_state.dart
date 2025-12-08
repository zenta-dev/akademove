import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantMenuState extends Equatable {
  const MerchantMenuState({
    this.menus = const OperationResult.idle(),
    this.menu = const OperationResult.idle(),
  });

  final OperationResult<List<MerchantMenu>> menus;
  final OperationResult<MerchantMenu> menu;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [menus, menu];

  MerchantMenuState copyWith({
    OperationResult<List<MerchantMenu>>? merchantMenus,
    OperationResult<MerchantMenu>? selectedMerchantMenu,
  }) {
    return MerchantMenuState(
      menus: merchantMenus ?? menus,
      menu: selectedMerchantMenu ?? menu,
    );
  }
}
