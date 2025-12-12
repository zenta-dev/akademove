import 'dart:async';
import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class _FormKeys {
  static const FormKey<String> ownerName = TextFieldKey('owner-name');
  static const FormKey<String> ownerEmail = TextFieldKey('owner-email');
  static const FormKey<String> ownerPhoneNumber = TextFieldKey(
    'owner-phone-number',
  );

  static const FormKey<String> outletName = TextFieldKey('outlet-name');
  static const FormKey<String> outletPhoneNumber = TextFieldKey(
    'outlet-phone-number',
  );
  static const FormKey<String> outletEmail = TextFieldKey('outlet-email');
  static const FormKey<String> outletBenchmark = TextFieldKey(
    'outlet-benchmark',
  );

  static const bankProvider = SelectKey<BankProvider>('bank-provider');
  static const FormKey<String> bankAccount = TextFieldKey('bank-account');
}

enum _Documents { outletDocument }

class MerchantEditProfileScreen extends StatefulWidget {
  const MerchantEditProfileScreen({super.key});

  @override
  State<MerchantEditProfileScreen> createState() =>
      _MerchantEditProfileScreenState();
}

class _MerchantEditProfileScreenState extends State<MerchantEditProfileScreen> {
  late final ScrollController _scrollController;
  late final FormController _formController;

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  BankProvider? _selectedBankProvider;
  Coordinate _outletLocation = MapConstants.defaultCoordinate;
  String _outletAddress = '';
  bool _isLocationLoaded = false;
  bool _isDraggingMarker = false;
  bool _isLoading = false;

  // Bank account editing states
  bool _isBankAccountEditing = false;
  bool _isBankAccountVerified = false;
  String? _verifiedBankAccountNumber;
  String? _accountHolderName;
  String? _ownerBankName;
  final TextEditingController _bankAccountController = TextEditingController();

  // Phone number states
  String? _ownerPhoneNumber;
  String? _outletPhoneNumber;

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Placemark> _searchSuggestions = [];
  bool _showSuggestions = false;
  Timer? _debounce;

  final Map<_Documents, File?> _documents = {
    for (var doc in _Documents.values) doc: null,
  };

  final Map<_Documents, String?> _documentsErrors = {
    for (var doc in _Documents.values) doc: null,
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formController = FormController();
    _loadCurrentLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _scrollController.dispose();
    _formController.dispose();
    _searchController.dispose();
    _bankAccountController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadCurrentLocation() async {
    try {
      final hasPermission = await _requestLocationPermission();

      if (!hasPermission) {
        if (mounted) {
          setState(() {
            _isLocationLoaded = true;
            _updateLocationAndMarker(_outletLocation);
          });
          _showToast(
            context,
            context.l10n.toast_location_permission,
            context.l10n.toast_using_default_location,
          );
        }
        return;
      }

      final position = await _determinePosition();
      if (!mounted) return;

      final location = Coordinate(x: position.longitude, y: position.latitude);
      _updateLocationAndMarker(location);

      setState(() {
        _isLocationLoaded = true;
      });

      await _getAddressFromLatLng(
        LatLng(position.latitude, position.longitude),
      );

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude),
          16,
        ),
      );
    } catch (e) {
      logger.e('Error loading location: $e');
      if (mounted) {
        setState(() {
          _isLocationLoaded = true;
          _updateLocationAndMarker(_outletLocation);
        });
      }
    }
  }

  Future<bool> _requestLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        final shouldOpenSettings = await _showLocationServiceDialog();
        if (shouldOpenSettings) {
          await Geolocator.openLocationSettings();
        }
      }
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      if (mounted) {
        final shouldRequest = await _showPermissionExplanationDialog();
        if (!shouldRequest) return false;
      }

      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        if (mounted) {
          _showToast(
            context,
            context.l10n.reject,
            context.l10n.toast_location_permission,
          );
        }
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        final shouldOpenSettings = await _showPermissionDeniedForeverDialog();
        if (shouldOpenSettings) {
          await Geolocator.openAppSettings();
        }
      }
      return false;
    }

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<bool> _showPermissionExplanationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.dialog_location_permission_title),
        content: Text(context.l10n.dialog_location_permission_message),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.allow),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<bool> _showLocationServiceDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.dialog_location_services_disabled_title),
        content: Text(context.l10n.dialog_location_services_disabled_message),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.open_settings),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  Future<bool> _showPermissionDeniedForeverDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.dialog_location_permission_required_title),
        content: Text(context.l10n.dialog_location_permission_required_message),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.cancel),
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.open_settings),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _updateLocationAndMarker(Coordinate location) {
    _outletLocation = location;
    _markers = {
      Marker(
        markerId: const MarkerId('outletLocation'),
        position: LatLng(location.y.toDouble(), location.x.toDouble()),
        infoWindow: InfoWindow(
          title: context.l10n.label_outlet_location,
          snippet: context.l10n.drag_marker,
        ),
        draggable: true,
        consumeTapEvents: true,
        onDragStart: (position) {
          if (mounted) {
            setState(() => _isDraggingMarker = true);
          }
        },
        onDrag: (position) {
          _outletLocation = Coordinate(
            x: position.longitude,
            y: position.latitude,
          );
        },
        onDragEnd: _onMarkerDragEnd,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }

  Future<void> _onMarkerDragEnd(LatLng newPosition) async {
    if (mounted) {
      setState(() {
        _outletLocation = Coordinate(
          x: newPosition.longitude,
          y: newPosition.latitude,
        );
        _isDraggingMarker = false;
      });
    }

    await _getAddressFromLatLng(newPosition);
  }

  Future<Position> _determinePosition() async {
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty && mounted) {
        final place = placemarks.first;
        setState(() {
          _outletAddress = [
            place.name,
            place.locality,
            place.administrativeArea,
            place.country,
          ].where((e) => e != null && e.isNotEmpty).join(', ');
        });
      }
    } catch (e) {
      logger.e('Error getting address: $e');
      if (mounted) {
        setState(() => _outletAddress = context.l10n.label_unable_get_address);
      }
    }
  }

  Future<void> _searchLocation(String query) async {
    if (query.trim().isEmpty) {
      _showToast(
        context,
        context.l10n.toast_search_error,
        context.l10n.toast_enter_location,
      );
      return;
    }

    setState(() => _isSearching = true);

    try {
      final locations = await locationFromAddress(query);

      if (locations.isNotEmpty && mounted) {
        final location = locations.first;
        await _moveToLocation(location.latitude, location.longitude);

        if (mounted) {
          _showToast(
            context,
            context.l10n.toast_location_found,
            context.l10n.toast_marker_moved,
          );
        }
      } else {
        if (mounted) {
          setState(() => _isSearching = false);
          _showToast(
            context,
            context.l10n.toast_not_found,
            context.l10n.toast_location_not_found,
          );
        }
      }
    } catch (e) {
      logger.e('Error searching location: $e');
      if (mounted) {
        setState(() => _isSearching = false);
        _showToast(
          context,
          context.l10n.toast_search_error,
          context.l10n.toast_search_error_message,
        );
      }
    }
  }

  Future<void> _moveToLocation(double latitude, double longitude) async {
    final newLocation = Coordinate(x: longitude, y: latitude);

    setState(() {
      _updateLocationAndMarker(newLocation);
      _isSearching = false;
      _showSuggestions = false;
      _searchSuggestions.clear();
    });

    await _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 16),
    );

    await _getAddressFromLatLng(LatLng(latitude, longitude));
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        _showSuggestions = false;
        _searchSuggestions.clear();
      });
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSuggestions(query);
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.trim().isEmpty) return;

    setState(() => _isSearching = true);

    try {
      final locations = await locationFromAddress(query);

      if (mounted && locations.isNotEmpty) {
        final suggestions = <Placemark>[];

        for (final location in locations.take(5)) {
          try {
            final placemarks = await placemarkFromCoordinates(
              location.latitude,
              location.longitude,
            );
            if (placemarks.isNotEmpty) {
              suggestions.add(placemarks.first);
            }
          } catch (e) {
            logger.e('Error getting placemark: $e');
          }
        }

        if (mounted) {
          setState(() {
            _searchSuggestions = suggestions;
            _showSuggestions = suggestions.isNotEmpty;
            _isSearching = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _searchSuggestions = [];
            _showSuggestions = false;
            _isSearching = false;
          });
        }
      }
    } catch (e) {
      logger.e('Error fetching suggestions: $e');
      if (mounted) {
        setState(() {
          _searchSuggestions = [];
          _showSuggestions = false;
          _isSearching = false;
        });
      }
    }
  }

  Future<void> _selectSuggestion(Placemark placemark) async {
    final address = [
      placemark.name,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].where((e) => e != null && e.isNotEmpty).join(', ');

    _searchController.text = address;

    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty && mounted) {
        await _moveToLocation(
          locations.first.latitude,
          locations.first.longitude,
        );
      }
    } catch (e) {
      logger.e('Error getting location from suggestion: $e');
    }
  }

  String _formatPlacemark(Placemark placemark) {
    final parts = [
      placemark.name,
      placemark.locality,
      placemark.administrativeArea,
    ].where((e) => e != null && e.isNotEmpty).toList();

    return parts.join(', ');
  }

  void _showToast(BuildContext context, String title, String message) {
    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: title, message: message),
      location: ToastLocation.topCenter,
    );
  }

  Future<void> _handleSaveProfile() async {
    // Validate form
    if (_formController.errors.isNotEmpty) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.error_fill_all_required_fields,
      );
      return;
    }

    // Get form values
    final values = _formController.values;
    final outletName = _FormKeys.outletName[values];
    final outletEmail = _FormKeys.outletEmail[values];
    final bankAccountNumber = _bankAccountController.text.trim();

    // Validate required fields
    if (outletName == null || outletName.isEmpty) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.error_fill_required_fields,
      );
      return;
    }

    if (_selectedBankProvider == null) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.toast_select_bank_first,
      );
      return;
    }

    if (bankAccountNumber.isEmpty) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.toast_enter_bank_account,
      );
      return;
    }

    // Get merchant ID
    final merchantCubit = context.read<MerchantCubit>();
    final merchantId = merchantCubit.state.mine.value?.id;

    if (merchantId == null) {
      _showToast(
        context,
        context.l10n.error,
        context.l10n.error_merchant_info_not_found,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Get document file and convert to MultipartFile
      final documentFile = _documents[_Documents.outletDocument];
      final document = documentFile != null && documentFile.existsSync()
          ? await MultipartFile.fromFile(documentFile.path)
          : null;

      // Parse bank account number
      final bankNumber = num.tryParse(
        bankAccountNumber.replaceAll(RegExp('[^0-9]'), ''),
      );
      if (bankNumber == null) {
        if (mounted) {
          setState(() => _isLoading = false);
          _showToast(
            context,
            context.l10n.error_validation,
            context.l10n.toast_enter_bank_account,
          );
        }
        return;
      }

      if (!mounted) return;

      // Parse outlet phone number
      final phoneNumber = _outletPhoneNumber;
      final outletPhoneNum = phoneNumber != null
          ? num.tryParse(phoneNumber.replaceAll(RegExp('[^0-9]'), ''))
          : null;

      // Call update profile API - BlocListener handles state changes
      final bankProvider = _selectedBankProvider;
      if (bankProvider == null) {
        _showToast(
          context,
          context.l10n.error,
          'Please select a bank provider',
        );
        setState(() => _isLoading = false);
        return;
      }

      merchantCubit.updateProfile(
        merchantId: merchantId,
        name: outletName,
        email: outletEmail,
        phoneCountryCode: '+62',
        phoneNumber: outletPhoneNum?.toInt() ?? 0,
        address: _outletAddress,
        locationX: _outletLocation.x,
        locationY: _outletLocation.y,
        category: null,
        bankProvider: bankProvider.name,
        bankNumber: bankNumber,
        bankAccountName: _accountHolderName,
        document: document,
      );
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showToast(context, context.l10n.error, context.l10n.an_error_occurred);
      }
    }
  }

  void _onUpdateProfileStateChanged(MerchantState state) {
    if (state.updateProfile.isSuccess) {
      setState(() => _isLoading = false);
      _showToast(context, context.l10n.success, context.l10n.toast_success);
      context.read<MerchantCubit>().clearUpdateProfileResult();
    } else if (state.updateProfile.isFailed) {
      setState(() => _isLoading = false);
      _showToast(
        context,
        context.l10n.error,
        state.updateProfile.error?.message ?? context.l10n.an_error_occurred,
      );
    }
  }

  void _startBankAccountEdit() {
    setState(() {
      _isBankAccountEditing = true;
      // Clear the field for new input
      _bankAccountController.clear();
    });
  }

  Future<void> _verifyBankAccount() async {
    final accountNumber = _bankAccountController.text.trim();

    if (accountNumber.isEmpty) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.toast_enter_bank_account,
      );
      return;
    }

    if (accountNumber.length < 5) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.toast_bank_account_min_digits,
      );
      return;
    }

    if (_selectedBankProvider == null) {
      _showToast(
        context,
        context.l10n.error_validation,
        context.l10n.toast_select_bank_first,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        final maskedNumber =
            '********${accountNumber.substring(accountNumber.length >= 4 ? accountNumber.length - 4 : 0)}';

        setState(() {
          _isBankAccountEditing = false;
          _isBankAccountVerified = true;
          _verifiedBankAccountNumber = maskedNumber;
          _bankAccountController.text = maskedNumber;
          _accountHolderName = 'J**n D*e';
          _ownerBankName = 'J**n D*e';
          _isLoading = false;
        });

        _showToast(
          context,
          context.l10n.success,
          context.l10n.toast_bank_account_verified,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showToast(
          context,
          context.l10n.error,
          context.l10n.toast_failed_verify_bank,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MerchantCubit, MerchantState>(
      listenWhen: (previous, current) =>
          previous.updateProfile != current.updateProfile,
      listener: (context, state) => _onUpdateProfileStateChanged(state),
      child: Stack(
        children: [
          MyScaffold(
            controller: _scrollController,
            headers: [DefaultAppBar(title: context.l10n.title_edit_profile)],
            body: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (_isDraggingMarker) {
                  return true;
                }
                return false;
              },
              child: Form(
                controller: _formController,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 20.h,
                    children: [
                      _buildTextField(
                        key: _FormKeys.ownerName,
                        label: context.l10n.label_owner_name,
                        placeholder: context.l10n.placeholder_owner_name,
                        icon: LucideIcons.user,
                        validator: const LengthValidator(min: 3),
                        enabled: !_isLoading,
                      ),
                      _buildTextField(
                        key: _FormKeys.ownerEmail,
                        label: context.l10n.label_owner_email,
                        placeholder: context.l10n.placeholder_owner_email,
                        icon: LucideIcons.mail,
                        validator: const EmailValidator(),
                        keyboardType: TextInputType.emailAddress,
                        enabled: !_isLoading,
                      ),
                      _buildPhoneField(
                        context,
                        _FormKeys.ownerPhoneNumber,
                        context.l10n.label_owner_phone,
                        (val) {
                          setState(() {
                            _ownerPhoneNumber = val.number;
                          });
                        },
                      ),
                      _buildTextField(
                        key: _FormKeys.outletName,
                        label: context.l10n.label_outlet_name,
                        placeholder: context.l10n.placeholder_outlet_name,
                        icon: LucideIcons.store,
                        validator: const LengthValidator(min: 3),
                        enabled: !_isLoading,
                      ),
                      _buildOutletLocationField(),
                      _buildPhoneField(
                        context,
                        _FormKeys.outletPhoneNumber,
                        context.l10n.label_outlet_phone,
                        (val) {
                          setState(() {
                            _outletPhoneNumber = val.number;
                          });
                        },
                      ),
                      _buildTextField(
                        key: _FormKeys.outletEmail,
                        label: context.l10n.label_outlet_email,
                        placeholder: context.l10n.placeholder_outlet_email,
                        icon: LucideIcons.mail,
                        validator: const EmailValidator(),
                        keyboardType: TextInputType.emailAddress,
                        enabled: !_isLoading,
                      ),
                      _buildImagePicker(
                        context.l10n.label_outlet_document,
                        _Documents.outletDocument,
                        _documents,
                        _documentsErrors,
                        context,
                        isOptional: true,
                      ),
                      _buildBankProviderSelect(),
                      _buildBankAccountField(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Button.primary(
                    onPressed: _isLoading ? null : _handleSaveProfile,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            context.l10n.save_changes,
                            style: context.typography.small.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField<T>({
    required FormKey<String> key,
    required String label,
    required String placeholder,
    required IconData icon,
    required Validator<T> validator,
    required bool enabled,
    TextInputType? keyboardType,
  }) {
    return FormField(
      key: key,
      label: Text(
        label,
        style: context.typography.p.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      validator: validator,
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: TextField(
        placeholder: Text(
          placeholder,
          style: context.typography.small.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        enabled: enabled,
        keyboardType: keyboardType,
        features: [InputFeature.leading(Icon(icon))],
      ),
    );
  }

  Widget _buildPhoneField<T extends String>(
    BuildContext context,
    FormKey<T> key,
    String label,
    void Function(PhoneNumber val) onChanged,
  ) {
    return FormField(
      key: key,
      label: Text(
        label,
        style: context.typography.p.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      validator: const LengthValidator(min: 10, max: 15),
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: ComponentTheme(
        data: PhoneInputTheme(
          maxWidth: 200 * context.theme.scaling,
          flagWidth: 22.w,
        ),
        child: PhoneInput(
          initialCountry: Country.indonesia,
          countries: const [Country.indonesia],
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildOutletLocationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.label_outlet_location,
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (_isDraggingMarker)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary.withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  spacing: 4.w,
                  children: [
                    Icon(
                      LucideIcons.move,
                      size: 12.sp,
                      color: context.theme.colorScheme.primary,
                    ),
                    Text(
                      context.l10n.label_dragging,
                      style: context.typography.small.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: context.theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        Text(
          context.l10n.label_outlet_location_description,
          style: context.typography.small.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ).muted(),
        Stack(
          children: [
            Column(
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        placeholder: Text(
                          context.l10n.placeholder_search_location,
                          style: context.typography.small.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        enabled: !_isLoading,
                        onChanged: _onSearchChanged,
                        onSubmitted: (_) =>
                            _searchLocation(_searchController.text),
                        features: [
                          InputFeature.leading(
                            _isSearching
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.h,
                                    child: Icon(
                                      LucideIcons.loader,
                                      size: 16.sp,
                                    ),
                                  )
                                : const Icon(LucideIcons.search),
                          ),
                          if (_searchController.text.isNotEmpty)
                            InputFeature.trailing(
                              IconButton.ghost(
                                icon: const Icon(LucideIcons.x, size: 16),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                    _showSuggestions = false;
                                    _searchSuggestions.clear();
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_showSuggestions && _searchSuggestions.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 4.h),
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.theme.colorScheme.border,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(maxHeight: 200.h),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _searchSuggestions.length,
                      separatorBuilder: (context, index) => Container(
                        height: 1,
                        color: context.theme.colorScheme.border,
                      ),
                      itemBuilder: (context, index) {
                        final suggestion = _searchSuggestions[index];
                        final displayText = _formatPlacemark(suggestion);

                        return GestureDetector(
                          onTap: () => _selectSuggestion(suggestion),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              spacing: 8.w,
                              children: [
                                Icon(
                                  LucideIcons.mapPin,
                                  size: 16.sp,
                                  color:
                                      context.theme.colorScheme.mutedForeground,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 2.h,
                                    children: [
                                      Text(
                                        displayText,
                                        style: context.typography.small
                                            .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        maxLines: 1,
                                      ),
                                      if (suggestion.country
                                          case final country?)
                                        Text(
                                          country,
                                          style: context.theme.typography.xSmall
                                              .copyWith(
                                                color: context
                                                    .theme
                                                    .colorScheme
                                                    .mutedForeground,
                                              ),
                                        ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  LucideIcons.arrowUpRight,
                                  size: 14.sp,
                                  color:
                                      context.theme.colorScheme.mutedForeground,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: double.infinity,
            height: 250.h,
            child: _isLocationLoaded
                ? AbsorbPointer(
                    absorbing: false,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          _outletLocation.y.toDouble(),
                          _outletLocation.x.toDouble(),
                        ),
                        zoom: 16,
                      ),
                      markers: _markers,
                      onMapCreated: (controller) {
                        _mapController = controller;
                        Future.delayed(const Duration(milliseconds: 300), () {
                          final controller = _mapController;
                          if (controller != null && mounted) {
                            controller.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                LatLng(
                                  _outletLocation.y.toDouble(),
                                  _outletLocation.x.toDouble(),
                                ),
                                16,
                              ),
                            );
                          }
                        });
                      },
                      onTap: (position) {
                        setState(() {
                          _updateLocationAndMarker(
                            Coordinate(
                              x: position.longitude,
                              y: position.latitude,
                            ),
                          );
                        });
                        _getAddressFromLatLng(position);
                      },
                      onCameraMoveStarted: () {
                        if (mounted) {
                          setState(() => _isDraggingMarker = true);
                        }
                      },
                      onCameraIdle: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          if (mounted) {
                            setState(() => _isDraggingMarker = false);
                          }
                        });
                      },
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      rotateGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      mapToolbarEnabled: false,
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 8.h,
                      children: [
                        Icon(
                          LucideIcons.loader,
                          size: 32.sp,
                          color: context.theme.colorScheme.primary,
                        ),
                        Text(
                          context.l10n.loading,
                          style: context.typography.small,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        if (_outletAddress.isNotEmpty)
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondary.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.theme.colorScheme.border),
            ),
            child: Row(
              spacing: 8.w,
              children: [
                Icon(
                  LucideIcons.mapPin,
                  size: 16.sp,
                  color: context.theme.colorScheme.primary,
                ),
                Expanded(
                  child: Text(
                    _outletAddress,
                    style: context.theme.typography.small.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Gap(8.h),
        FormField(
          key: _FormKeys.outletBenchmark,
          label: Text(
            context.l10n.label_benchmark_optional,
            style: context.theme.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: TextField(
            placeholder: Text(
              context.l10n.placeholder_benchmark,
              style: context.theme.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            enabled: !_isLoading,
            features: const [InputFeature.leading(Icon(LucideIcons.mapPinned))],
          ),
        ),
      ],
    );
  }

  Widget _buildBankProviderSelect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(
          context.l10n.label_choose_bank,
          style: context.theme.typography.small.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildEnumSelect<BankProvider>(
          key: _FormKeys.bankProvider,
          placeholder: 'Select bank provider',
          value: _selectedBankProvider,
          items: BankProvider.values,
          enabled: !_isLoading,
          onChanged: (value) => setState(() => _selectedBankProvider = value),
        ),
      ],
    );
  }

  Widget _buildEnumSelect<T extends Enum>({
    required FormKey<T> key,
    required String placeholder,
    required T? value,
    required List<T> items,
    required bool enabled,
    required void Function(T?) onChanged,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Select<T>(
        enabled: enabled,
        itemBuilder: (context, item) => Text(item.name),
        value: value,
        placeholder: Text(
          placeholder,
          style: context.typography.small.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        onChanged: onChanged,
        popup: SelectPopup<T>(
          items: SelectItemList(
            children: items
                .map((e) => SelectItemButton(value: e, child: Text(e.name)))
                .toList(),
          ),
        ).call,
      ),
    );
  }

  Widget _buildImagePicker<T>(
    String label,
    T key,
    Map<T, File?> docs,
    Map<T, String?> errors,
    BuildContext context, {
    bool isOptional = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(
          label,
          style: context.theme.typography.small.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        ImagePickerWidget(
          size: Size(double.infinity, 64.h),
          onValueChanged: (file) => setState(() => docs[key] = file),
        ),
        if (!isOptional && errors[key] != null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text(errors[key]!).xSmall().medium(),
          ),
      ],
    );
  }

  Widget _buildBankAccountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 8.w,
          children: [
            Expanded(
              child: FormField(
                key: _FormKeys.bankAccount,
                label: Text(
                  context.l10n.label_bank_account,
                  style: context.typography.p.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                validator: const LengthValidator(min: 5),
                showErrors: const {
                  FormValidationMode.changed,
                  FormValidationMode.submitted,
                },
                child: TextField(
                  controller: _bankAccountController,
                  placeholder: Text(
                    context.l10n.placeholder_bank_account,
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  enabled: !_isLoading && _isBankAccountEditing,
                  keyboardType: TextInputType.number,
                  features: const [
                    InputFeature.leading(Icon(LucideIcons.wallet)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.h), // ✅ Sesuaikan jika perlu
              child: GestureDetector(
                onTap: () {
                  if (_isLoading) return;

                  if (_isBankAccountEditing) {
                    _verifyBankAccount();
                  } else {
                    _startBankAccountEdit();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: _isBankAccountEditing
                        ? context.theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          )
                        : context.theme.colorScheme.secondary.withValues(
                            alpha: 0.5,
                          ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _isBankAccountEditing
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.border,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    _isBankAccountEditing
                        ? LucideIcons.check
                        : LucideIcons.pencil,
                    size: 16.sp,
                    color: _isBankAccountEditing
                        ? context.theme.colorScheme.primary
                        : context.theme.colorScheme.foreground,
                  ),
                ),
              ),
            ),
          ],
        ),

        if (_isBankAccountVerified && !_isBankAccountEditing)
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: context.theme.colorScheme.border.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.h,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        LucideIcons.building2,
                        size: 24.sp,
                        color: const Color(0xFF0066CC),
                      ),
                    ),
                    gap(8.h),
                    Text(
                      _getBankName(_selectedBankProvider),
                      style: context.typography.p.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                Container(
                  height: 1,
                  color: context.theme.colorScheme.border.withValues(
                    alpha: 0.3,
                  ),
                ),

                _buildBankDetailRow(
                  context.l10n.label_bank_account_number,
                  _verifiedBankAccountNumber ?? '',
                ),
                _buildBankDetailRow(
                  context.l10n.label_account_holder_name,
                  _accountHolderName ?? '',
                ),
                _buildBankDetailRow(
                  context.l10n.label_owner_bank_name,
                  _ownerBankName ?? '',
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildBankDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          ':',
          style: context.typography.small.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(8.w),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: context.typography.small.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  String _getBankName(BankProvider? provider) {
    if (provider == null) return 'Bank';
    return 'Bank ${provider.name.toUpperCase()}';
  }
}
