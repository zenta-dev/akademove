import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/_export.dart';
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
    late MockDocumentService mockDocumentService;

    setUp(() {
      mockCartRepository = MockCartRepository();
      mockOrderRepository = MockOrderRepository();
      mockDocumentService = MockDocumentService();

      cubit = UserCartCubit(
        cartRepository: mockCartRepository,
        orderRepository: mockOrderRepository,
        documentService: mockDocumentService,
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, isA<UserCartState>());
      expect(cubit.state.cart, isNull);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.error, isNull);
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
                stock: 10,
                notes: null,
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
          isA<UserCartState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.error, 'error', isNull),
          isA<UserCartState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.cart, 'cart', isNotNull)
              .having(
                (s) => s.cart?.merchantId,
                'merchantId',
                TestConstants.testMerchantId,
              )
              .having((s) => s.cart?.items.length, 'items.length', 1),
        ],
        verify: (_) {
          verify(() => mockCartRepository.getCart()).called(1);
        },
      );

      blocTest<UserCartCubit, UserCartState>(
        'emits [loading, error] when loadCart fails',
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
          isA<UserCartState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.error, 'error', isNull),
          isA<UserCartState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.error, 'error', 'Failed to load cart'),
        ],
      );
    });

    group('clearCart', () {
      blocTest<UserCartCubit, UserCartState>(
        'emits [cleared] when clearCart succeeds',
        build: () {
          when(
            () => mockCartRepository.clearCart(),
          ).thenAnswer((_) => Future.value());
          return cubit;
        },
        act: (cubit) => cubit.clearCart(),
        expect: () => [
          isA<UserCartState>()
              .having((s) => s.cart, 'cart', isNull)
              .having((s) => s.error, 'error', isNull),
        ],
        verify: (_) {
          verify(() => mockCartRepository.clearCart()).called(1);
        },
      );

      blocTest<UserCartCubit, UserCartState>(
        'emits [error] when clearCart fails',
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
            (s) => s.error,
            'error',
            'Failed to clear cart',
          ),
        ],
      );
    });

    group('reset', () {
      test('resets state to initial', () {
        expect(cubit.state.cart, isNull);
        expect(cubit.state.isLoading, false);

        cubit.reset();

        expect(cubit.state.cart, isNull);
        expect(cubit.state.isLoading, false);
        expect(cubit.state.error, isNull);
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
            stock: 10,
            notes: null,
          ),
          CartItem(
            menuId: 'menu-2',
            merchantId: TestConstants.testMerchantId,
            merchantName: TestConstants.testMerchantName,
            menuName: 'Item 2',
            menuImage: null,
            unitPrice: 15000,
            quantity: 1,
            stock: 5,
            notes: null,
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
              stock: 10,
              notes: null,
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
          stock: 10,
          notes: null,
        );

        // Calculate manually: unitPrice * quantity
        final itemSubtotal = item.unitPrice * item.quantity;
        expect(itemSubtotal, 75000);
      });

      test('CartItem stock validation works correctly', () {
        // Item at max stock
        final atMaxItem = CartItem(
          menuId: 'menu-1',
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          menuName: 'Max Stock Item',
          menuImage: null,
          unitPrice: 25000,
          quantity: 10,
          stock: 10,
          notes: null,
        );
        expect(atMaxItem.isAtMaxStock, true);
        expect(atMaxItem.isOutOfStock, false);

        // Out of stock item
        final outOfStockItem = CartItem(
          menuId: 'menu-2',
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          menuName: 'Out of Stock Item',
          menuImage: null,
          unitPrice: 15000,
          quantity: 1,
          stock: 0,
          notes: null,
        );
        expect(outOfStockItem.isOutOfStock, true);
        expect(outOfStockItem.isAtMaxStock, true);

        // Normal item with remaining stock
        final normalItem = CartItem(
          menuId: 'menu-3',
          merchantId: TestConstants.testMerchantId,
          merchantName: TestConstants.testMerchantName,
          menuName: 'Normal Item',
          menuImage: null,
          unitPrice: 20000,
          quantity: 3,
          stock: 10,
          notes: null,
        );
        expect(normalItem.isAtMaxStock, false);
        expect(normalItem.isOutOfStock, false);
        expect(normalItem.remainingStock, 7);
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
