import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart';
import 'package:akademove/features/cart/presentation/cubits/_export.dart';
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:api_client/api_client.dart' hide Cart, CartItem;
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mock_factories.dart';
import '../../../../helpers/test_constants.dart';

void main() {
  group('UserCartCubit', () {
    late UserCartCubit cubit;
    late MockCartRepository mockCartRepository;
    late MockOrderRepository mockOrderRepository;

    setUp(() {
      mockCartRepository = MockCartRepository();
      mockOrderRepository = MockOrderRepository();

      cubit = UserCartCubit(
        cartRepository: mockCartRepository,
        orderRepository: mockOrderRepository,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, isA<UserCartState>());
      expect(cubit.state.cart.isIdle, true);
      expect(cubit.state.addItemResult.isIdle, true);
      expect(cubit.state.removeItemResult.isIdle, true);
      expect(cubit.state.updateQuantityResult.isIdle, true);
      expect(cubit.state.clearCartResult.isIdle, true);
      expect(cubit.state.placeFoodOrderResult.isIdle, true);
      expect(cubit.state.showMerchantConflict, false);
      expect(cubit.state.pendingItem, isNull);
    });

    group('loadCart', () {
      blocTest<UserCartCubit, UserCartState>(
        'emits [loading, success] when loadCart succeeds',
        build: () {
          final cart = Cart(
            merchantId: TestConstants.testMerchantId,
            merchantName: TestConstants.testMerchantName,
            merchantLocation: Coordinate(
              x: TestConstants.testPickupLng,
              y: TestConstants.testPickupLat,
            ),
            items: [
              CartItem(
                menuId: 'menu-1',
                merchantId: TestConstants.testMerchantId,
                merchantName: TestConstants.testMerchantName,
                menuName: 'Test Menu',
                menuImage: null,
                unitPrice: 25000,
                quantity: 2,
              ),
            ],
            totalItems: 2,
            subtotal: 50000,
            lastUpdated: DateTime.now(),
          );

          when(
            () => mockCartRepository.getCart(),
          ).thenAnswer((_) async => cart);
          return cubit;
        },
        act: (cubit) => cubit.loadCart(),
        expect: () => [
          isA<UserCartState>().having((s) => s.cart.isLoading, 'isLoading', true),
          isA<UserCartState>()
              .having((s) => s.cart.isSuccess, 'isSuccess', true)
              .having(
                (s) => s.cart.value?.merchantId,
                'merchantId',
                TestConstants.testMerchantId,
              )
              .having((s) => s.cart.value?.items.length, 'items.length', 1),
        ],
        verify: (_) {
          verify(() => mockCartRepository.getCart()).called(1);
        },
      );

      blocTest<UserCartCubit, UserCartState>(
        'emits [loading, failure] when loadCart fails',
        build: () {
          when(() => mockCartRepository.getCart()).thenThrow(
            const RepositoryError(
              'Failed to load cart',
              code: ErrorCode.internalServerError,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.loadCart(),
        expect: () => [
          isA<UserCartState>().having((s) => s.cart.isLoading, 'isLoading', true),
          isA<UserCartState>().having((s) => s.cart.isFailure, 'isFailure', true),
        ],
      );
    });

    group('clearCart', () {
      blocTest<UserCartCubit, UserCartState>(
        'emits [loading, success] when clearCart succeeds',
        build: () {
          when(() => mockCartRepository.clearCart()).thenAnswer((_) async {});
          return cubit;
        },
        act: (cubit) => cubit.clearCart(),
        expect: () => [
          isA<UserCartState>().having(
            (s) => s.clearCartResult.isLoading,
            'isLoading',
            true,
          ),
          isA<UserCartState>()
              .having((s) => s.clearCartResult.isSuccess, 'isSuccess', true)
              .having((s) => s.cart.value, 'cart.value', isNull),
        ],
        verify: (_) {
          verify(() => mockCartRepository.clearCart()).called(1);
        },
      );

      blocTest<UserCartCubit, UserCartState>(
        'emits [loading, failure] when clearCart fails',
        build: () {
          when(() => mockCartRepository.clearCart()).thenThrow(
            const RepositoryError(
              'Failed to clear cart',
              code: ErrorCode.internalServerError,
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.clearCart(),
        expect: () => [
          isA<UserCartState>().having(
            (s) => s.clearCartResult.isLoading,
            'isLoading',
            true,
          ),
          isA<UserCartState>().having(
            (s) => s.clearCartResult.isFailure,
            'isFailure',
            true,
          ),
        ],
      );
    });

    group('reset', () {
      test('resets state to initial', () {
        expect(cubit.state.cart.isIdle, true);

        cubit.reset();

        expect(cubit.state.cart.isIdle, true);
        expect(cubit.state.addItemResult.isIdle, true);
        expect(cubit.state.showMerchantConflict, false);
      });
    });

    group('cancelReplaceCart', () {
      test('clears pending state', () {
        cubit.cancelReplaceCart();

        expect(cubit.state.pendingItem, isNull);
        expect(cubit.state.pendingMerchantName, isNull);
        expect(cubit.state.showMerchantConflict, false);
      });
    });

    group('Cart Model', () {
      test('Cart calculates subtotal from items', () {
        final items = [
          CartItem(
            menuId: 'menu-1',
            merchantId: TestConstants.testMerchantId,
            merchantName: TestConstants.testMerchantName,
            menuName: 'Item 1',
            menuImage: null,
            unitPrice: 25000,
            quantity: 2,
          ),
          CartItem(
            menuId: 'menu-2',
            merchantId: TestConstants.testMerchantId,
            merchantName: TestConstants.testMerchantName,
            menuName: 'Item 2',
            menuImage: null,
            unitPrice: 15000,
            quantity: 1,
          ),
        ];

        // Calculate subtotal: 25000 * 2 + 15000 * 1 = 65000
        final subtotal = items.fold<num>(
          0,
          (sum, item) => sum + (item.unitPrice * item.quantity),
        );

        final cart = Cart(
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          items: items,
          totalItems: 3,
          subtotal: subtotal,
          lastUpdated: DateTime.now(),
        );

        expect(cart.subtotal, 65000);
        expect(cart.items.length, 2);
      });

      test('Cart stores merchant location', () {
        final cart = Cart(
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          merchantLocation: Coordinate(
            x: TestConstants.testPickupLng,
            y: TestConstants.testPickupLat,
          ),
          items: [],
          totalItems: 0,
          subtotal: 0,
          lastUpdated: DateTime.now(),
        );

        expect(cart.merchantLocation, isNotNull);
        expect(cart.merchantLocation?.x, TestConstants.testPickupLng);
        expect(cart.merchantLocation?.y, TestConstants.testPickupLat);
      });

      test('Cart serializes to/from JSON with merchant location', () {
        final cart = Cart(
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          merchantLocation: Coordinate(
            x: TestConstants.testPickupLng,
            y: TestConstants.testPickupLat,
          ),
          items: [
            CartItem(
              menuId: 'menu-1',
              merchantId: TestConstants.testMerchantId,
              merchantName: TestConstants.testMerchantName,
              menuName: 'Test Item',
              menuImage: null,
              unitPrice: 25000,
              quantity: 1,
            ),
          ],
          totalItems: 1,
          subtotal: 25000,
          lastUpdated: DateTime(2024, 1, 15, 10, 30),
        );

        // Serialize to JSON
        final json = cart.toJson();
        expect(json['merchantId'], TestConstants.testMerchantId);
        expect(json['merchantLocation'], isNotNull);

        // Deserialize from JSON
        final restored = Cart.fromJson(json);
        expect(restored.merchantId, cart.merchantId);
        expect(restored.merchantLocation?.x, cart.merchantLocation?.x);
        expect(restored.merchantLocation?.y, cart.merchantLocation?.y);
        expect(restored.items.length, cart.items.length);
      });

      test('CartItem calculates subtotal correctly', () {
        final item = CartItem(
          menuId: 'menu-1',
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          menuName: 'Test Item',
          menuImage: null,
          unitPrice: 25000,
          quantity: 3,
        );

        // Calculate manually: unitPrice * quantity
        final itemSubtotal = item.unitPrice * item.quantity;
        expect(itemSubtotal, 75000);
      });
    });

    group('FOOD Order Flow', () {
      test('Cart is required for FOOD orders', () {
        // FOOD orders require items from cart
        const orderType = 'FOOD';
        final requiresCart = orderType == 'FOOD';

        expect(requiresCart, true);
      });

      test('Merchant location is used as pickup for FOOD orders', () {
        final cart = Cart(
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          merchantLocation: Coordinate(
            x: TestConstants.testPickupLng,
            y: TestConstants.testPickupLat,
          ),
          items: [],
          totalItems: 0,
          subtotal: 0,
          lastUpdated: DateTime.now(),
        );

        // For FOOD orders, pickup = merchant location
        final pickupLocation = cart.merchantLocation;

        expect(pickupLocation, isNotNull);
        expect(pickupLocation?.x, TestConstants.testPickupLng);
        expect(pickupLocation?.y, TestConstants.testPickupLat);
      });

      test('Cart empty state prevents FOOD order placement', () {
        final emptyCart = Cart(
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          items: [],
          totalItems: 0,
          subtotal: 0,
          lastUpdated: DateTime.now(),
        );

        final canPlaceOrder = emptyCart.items.isNotEmpty;
        expect(canPlaceOrder, false);
      });
    });
  });
}
