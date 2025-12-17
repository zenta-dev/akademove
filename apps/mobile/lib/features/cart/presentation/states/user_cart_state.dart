part of '_export.dart';

class UserCartState extends Equatable {
  const UserCartState({
    this.cart,
    this.isLoading = false,
    this.error,
    this.pendingItem,
    this.pendingMerchantName,
    this.pendingMerchantLocation,
    this.pendingMerchantCategory,
    this.showMerchantConflict = false,
    this.attachment,
    this.attachmentUrl,
    this.isUploadingAttachment = false,
  });

  final Cart? cart;
  final bool isLoading;
  final String? error;

  /// Pending item to add (when merchant conflict detected)
  final CartItem? pendingItem;
  final String? pendingMerchantName;
  final Coordinate? pendingMerchantLocation;
  final MerchantCategory? pendingMerchantCategory;
  final bool showMerchantConflict;

  /// Attachment for Printing merchants
  final DocumentPickResult? attachment;
  final String? attachmentUrl;
  final bool isUploadingAttachment;

  /// Computed properties
  int get totalItems => cart?.totalItems ?? 0;
  double get subtotal => (cart?.subtotal ?? 0).toDouble();
  bool get isEmpty => cart == null || cart!.items.isEmpty;
  bool get hasMerchantConflict => showMerchantConflict && pendingItem != null;
  bool get isPrintingMerchant => cart?.isPrintingMerchant ?? false;
  bool get hasAttachment => attachment != null || attachmentUrl != null;

  @override
  List<Object?> get props => [
    cart,
    isLoading,
    error,
    pendingItem,
    pendingMerchantName,
    pendingMerchantLocation,
    pendingMerchantCategory,
    showMerchantConflict,
    attachment,
    attachmentUrl,
    isUploadingAttachment,
  ];

  UserCartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? error,
    CartItem? pendingItem,
    String? pendingMerchantName,
    Coordinate? pendingMerchantLocation,
    MerchantCategory? pendingMerchantCategory,
    bool? showMerchantConflict,
    DocumentPickResult? attachment,
    String? attachmentUrl,
    bool? isUploadingAttachment,
    bool clearError = false,
    bool clearCart = false,
    bool clearPending = false,
    bool clearAttachment = false,
  }) {
    return UserCartState(
      cart: clearCart ? null : (cart ?? this.cart),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      pendingItem: clearPending ? null : (pendingItem ?? this.pendingItem),
      pendingMerchantName: clearPending
          ? null
          : (pendingMerchantName ?? this.pendingMerchantName),
      pendingMerchantLocation: clearPending
          ? null
          : (pendingMerchantLocation ?? this.pendingMerchantLocation),
      pendingMerchantCategory: clearPending
          ? null
          : (pendingMerchantCategory ?? this.pendingMerchantCategory),
      showMerchantConflict: clearPending
          ? false
          : (showMerchantConflict ?? this.showMerchantConflict),
      attachment: clearAttachment ? null : (attachment ?? this.attachment),
      attachmentUrl: clearAttachment
          ? null
          : (attachmentUrl ?? this.attachmentUrl),
      isUploadingAttachment:
          isUploadingAttachment ?? this.isUploadingAttachment,
    );
  }
}
