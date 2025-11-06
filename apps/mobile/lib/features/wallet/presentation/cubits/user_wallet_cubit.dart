import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserWalletCubit extends BaseCubit<UserWalletState> {
  UserWalletCubit({
    required WalletRepository walletRepository,
  }) : _walletRepository = walletRepository,
       super(UserWalletState());

  final WalletRepository _walletRepository;

  @override
  Future<void> init() async {
    await Future.wait([getMine(), getTransactionsMine(), getMonthlySummary()]);
  }

  @override
  void reset() {}

  Future<void> getMine() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());
      final res = await _walletRepository.getWallet();

      state.unAssignOperation(methodName);

      emit(state.toSuccess(myWallet: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> getTransactionsMine() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;

      emit(state.toLoading());
      final res = await _walletRepository.getTransactions();

      state.unAssignOperation(methodName);

      emit(state.toSuccess(myTransactions: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<void> getMonthlySummary() async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());
      final now = DateTime.now();
      final res = await _walletRepository.getMonthlySummary(
        month: now.month,

        year: now.year,
      );

      state.unAssignOperation(methodName);

      emit(state.toSuccess(thisMonthSummary: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }
}

class UserWalletTopUpCubit extends BaseCubit<UserWalletTopUpState> {
  UserWalletTopUpCubit({
    required WalletRepository walletRepository,
    required WebSocketService webSocketService,
  }) : _walletRepository = walletRepository,
       _webSocketService = webSocketService,
       super(UserWalletTopUpState());

  final WalletRepository _walletRepository;
  final WebSocketService _webSocketService;
  String? _walletId;

  Future<void> init() async {
    reset();
  }

  void reset() {
    _walletId = null;
    emit(UserWalletTopUpState());
  }

  void setupWebsocket({required String walletId}) {
    _walletId = walletId;
    _webSocketService.connect(
      walletId,
      '${UrlConstants.wsBaseUrl}/wallet/$walletId',
      onMessage: (msg) {
        final parse = (msg as String).parseJson();
        if (parse is Map<String, dynamic>) {
          final data = WSTopUpEnvelope.fromJson(parse);
          if (data.from == WSEnvelopeSender.server &&
              data.to == WSEnvelopeSender.client &&
              data.type == WSEnvelopeType.walletColonTopUpSuccess) {
            emit(state.toSuccess(transactionResult: data.payload.transaction));
          }
        }
      },
    );
  }

  void teardownWebsocket() {
    emit(state.toSuccess());
    reset();
    if (_walletId != null) _webSocketService.disconnect(_walletId ?? '');
  }

  Future<void> topUp(int amount, TopUpRequestMethodEnum method) async {
    try {
      final methodName = getMethodName();
      if (state.checkAndAssignOperation(methodName)) return;
      emit(state.toLoading());
      final res = await _walletRepository.topUp(
        TopUpRequest(
          amount: amount,
          provider: PaymentProvider.MIDTRANS,
          method: method,
        ),
      );

      state.unAssignOperation(methodName);

      emit(state.toSuccess(paymentResult: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[UserRideCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
    }
  }
}
