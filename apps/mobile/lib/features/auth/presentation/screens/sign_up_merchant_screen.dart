import "dart:async";
import "dart:io";

import "package:akademove/app/router/router.dart";
import "package:akademove/core/_export.dart";
import "package:akademove/features/features.dart";
import "package:akademove/gen/assets.gen.dart";
import "package:akademove/l10n/l10n.dart";
import "package:api_client/api_client.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:geocoding/geocoding.dart" hide Location;
import "package:geolocator/geolocator.dart";
import "package:go_router/go_router.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:shadcn_flutter/shadcn_flutter.dart";

abstract class _FormKeys {
  static const FormKey<String> step1OwnerName = TextFieldKey(
    "step-1-owner-name",
  );
  static const FormKey<String> step1OwnerEmail = TextFieldKey(
    "step-1-owner-email",
  );
  static const FormKey<String> step1OwnerPassword = TextFieldKey(
    "step-1-owner-password",
  );
  static const FormKey<String> step1OwnerConfirmPassword = TextFieldKey(
    "step-1-owner-confirm_password",
  );

  static const FormKey<String> step2OutletName = TextFieldKey(
    "step-2-outlet-name",
  );
  static const FormKey<String> step2OutletEmail = TextFieldKey(
    "step-2-outlet-email",
  );
  static const step3BankProvider = SelectKey<BankProvider>(
    "step-3-bank-provider",
  );
  static const FormKey<String> step3BankNumber = TextFieldKey(
    "step-3-bank-number",
  );
}

enum _Step2Docs { governmentDocument }

class SignUpMerchantScreen extends StatefulWidget {
  const SignUpMerchantScreen({super.key});

  @override
  State<SignUpMerchantScreen> createState() => _SignUpMerchantScreenState();
}

class _SignUpMerchantScreenState extends State<SignUpMerchantScreen> {
  late final ScrollController _scrollController;
  late final FormController _formController;
  late final StepperController _stepController;

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  BankProvider? _selectedBankProvider;
  MerchantCategory? _selectedCategory;
  Coordinate _outletLocation = MapConstants.defaultCoordinate;
  String _outletAddress = "";
  CountryCode _selectedOwnerCountryCode = CountryCode.ID;
  CountryCode _selectedOutletCountryCode = CountryCode.ID;
  bool _isLocationLoaded = false;
  bool _isDraggingMarker = false;
  bool _termsAccepted = false;
  String? _submittedEmail;
  String? _ownerPhoneNumber;
  String? _outletPhoneNumber;

  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Placemark> _searchSuggestions = [];
  bool _showSuggestions = false;
  Timer? _debounce;

  final Map<_Step2Docs, File?> _step2Docs = {
    for (var doc in _Step2Docs.values) doc: null,
  };

  final Map<_Step2Docs, String?> _step2DocsErrors = {
    for (var doc in _Step2Docs.values) doc: null,
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _formController = FormController();
    _stepController = StepperController();
    _loadCurrentLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _scrollController.dispose();
    _formController.dispose();
    _stepController.dispose();
    _searchController.dispose();
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
      logger.e("[SignUpMerchantScreen] Error loading location", error: e);
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
            context.l10n.permission_denied,
            context.l10n.message_leocation_permission_required,
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
        markerId: const MarkerId("outletLocation"),
        position: LatLng(location.y.toDouble(), location.x.toDouble()),
        infoWindow: InfoWindow(
          title: context.l10n.label_outlet_location,
          snippet: context.l10n.drag_to_adjust,
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

    // Get address after dragging ends
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
          ].where((e) => e != null && e.isNotEmpty).join(", ");
        });
      }
    } catch (e) {
      logger.e("[SignUpMerchantScreen] Error getting address", error: e);
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
      logger.e("[SignUpMerchantScreen] Error searching location", error: e);
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
    // Cancel previous debounce timer
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      setState(() {
        _showSuggestions = false;
        _searchSuggestions.clear();
      });
      return;
    }

    // Debounce search by 500ms
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchSuggestions(query);
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.trim().isEmpty) return;

    setState(() => _isSearching = true);

    try {
      // Search for locations
      final locations = await locationFromAddress(query);

      if (mounted && locations.isNotEmpty) {
        // Get placemarks for each location
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
            logger.e(
              "[SignUpMerchantScreen] Error getting placemark",
              error: e,
            );
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
      logger.e("[SignUpMerchantScreen] Error fetching suggestions", error: e);
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
    // Build full address string
    final address = [
      placemark.name,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].where((e) => e != null && e.isNotEmpty).join(", ");

    _searchController.text = address;

    // Get coordinates for the placemark
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty && mounted) {
        await _moveToLocation(
          locations.first.latitude,
          locations.first.longitude,
        );
      }
    } catch (e) {
      logger.e(
        "[SignUpMerchantScreen] Error getting location from suggestion",
        error: e,
      );
    }
  }

  String _formatPlacemark(Placemark placemark) {
    final parts = [
      placemark.name,
      placemark.locality,
      placemark.administrativeArea,
    ].where((e) => e != null && e.isNotEmpty).toList();

    return parts.join(", ");
  }

  bool _validateStep(int stepIndex, bool Function() validator) {
    final isValid = validator();
    _stepController.setStatus(stepIndex, isValid ? null : StepState.failed);
    if (!isValid) _stepController.jumpToStep(stepIndex);
    return isValid;
  }

  bool _validateFormFields<T>(List<FormKey<T>> keys) {
    return keys.every((key) => _formController.errors[key] == null);
  }

  bool _validateDocuments<T>(
    Map<T, File?> docs,
    Map<T, String?> errors, {
    Set<T>? requiredDocs,
  }) {
    errors.updateAll((key, _) => null);
    var isValid = true;

    docs.forEach((key, file) {
      // Only validate if requiredDocs is null (all required) or key is in requiredDocs
      if (requiredDocs == null || requiredDocs.contains(key)) {
        if (file == null) {
          errors[key] = context.l10n.error_file_required;
          isValid = false;
        }
      }
    });

    if (!isValid) setState(() {}); // Update UI to show errors
    return isValid;
  }

  bool get _isStep1Valid => _validateFormFields([
    _FormKeys.step1OwnerName,
    _FormKeys.step1OwnerEmail,
    _FormKeys.step1OwnerPassword,
    _FormKeys.step1OwnerConfirmPassword,
  ]);

  bool get _isStep2Valid =>
      _validateFormFields([
        _FormKeys.step2OutletName,
        _FormKeys.step2OutletEmail,
      ]) &&
      // Document upload is optional - pass empty set for requiredDocs
      _validateDocuments(_step2Docs, _step2DocsErrors, requiredDocs: {}) &&
      _selectedCategory != null;

  bool get _isStep3Valid =>
      _validateFormFields([
        _FormKeys.step3BankProvider,
        _FormKeys.step3BankNumber,
      ]) &&
      _selectedBankProvider != null;

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showToast(BuildContext context, String title, String message) {
    showToast(
      context: context,
      builder: (context, overlay) =>
          context.buildToast(title: title, message: message),
      location: ToastLocation.topCenter,
    );
  }

  void _handleSignUpSuccess(
    BuildContext context,
    String? message,
    String email,
  ) {
    _showToast(
      context,
      context.l10n.sign_up_success,
      message ?? context.l10n.success_signed_up,
    );
    context.pushReplacementNamed(
      Routes.authEmailVerificationPending.name,
      queryParameters: {"email": email},
    );
  }

  void _handleSignUpFailure(BuildContext context, String? error) {
    _showToast(
      context,
      context.l10n.sign_up_failed,
      error ?? context.l10n.error_unknown,
    );
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    if (!_validateStep(2, () => _isStep3Valid)) return;

    final cubit = context.read<AuthCubit>();
    if (cubit.state.user.isLoading) return;

    final formData = _extractFormData(values);
    if (formData == null) {
      _showToast(
        context,
        context.l10n.error,
        context.l10n.error_fill_all_required_fields,
      );
      return;
    }

    final category = _selectedCategory;
    final bankProvider = _selectedBankProvider;
    final document = _step2Docs[_Step2Docs.governmentDocument];

    if (!_termsAccepted || category == null || bankProvider == null) {
      _showToast(
        context,
        context.l10n.error,
        context.l10n.error_fill_all_required_fields,
      );
      return;
    }

    _submittedEmail = formData["ownerEmail"];

    cubit.signUpMerchant(
      ownerName: formData["ownerName"]!,
      ownerEmail: formData["ownerEmail"]!,
      ownerPhone: Phone(
        countryCode: _selectedOwnerCountryCode,
        number: int.parse(formData["ownerPhoneNumber"]!),
      ),
      ownerPassword: formData["ownerPassword"]!,
      ownerConfirmPassword: formData["ownerConfirmPassword"]!,
      outletName: formData["outletName"]!,
      outletEmail: formData["outletEmail"]!,
      outletPhone: Phone(
        countryCode: _selectedOutletCountryCode,
        number: int.parse(formData["outletPhoneNumber"]!),
      ),
      outletLocation: _outletLocation,
      outletAddress: _outletAddress,
      category: category,
      bankProvider: bankProvider,
      bankNumber: int.parse(formData["bankNumber"]!),
      photoPath: null,
      documentPath: document?.path,
    );
  }

  Map<String, String>? _extractFormData<T>(Map<FormKey<T>, dynamic> values) {
    final data = {
      "ownerName": _FormKeys.step1OwnerName[values],
      "ownerEmail": _FormKeys.step1OwnerEmail[values],
      "ownerPhoneNumber": _ownerPhoneNumber,
      "ownerPassword": _FormKeys.step1OwnerPassword[values],
      "ownerConfirmPassword": _FormKeys.step1OwnerConfirmPassword[values],
      "outletName": _FormKeys.step2OutletName[values],
      "outletEmail": _FormKeys.step2OutletEmail[values],
      "outletPhoneNumber": _outletPhoneNumber,
      "bankNumber": _FormKeys.step3BankNumber[values],
    };

    // Validate all fields are present (documents are optional)
    if (data.values.any((v) => v == null) ||
        _selectedBankProvider == null ||
        _selectedCategory == null) {
      return null;
    }

    return data.map((k, v) {
      if (v == null) {
        throw Exception("Form field $k is null");
      }
      return MapEntry(k, v);
    });
  }

  void _handleStepNavigation({
    required bool isNext,
    required bool Function() validator,
  }) {
    _scrollToTop();
    if (isNext) {
      if (validator()) {
        _stepController.nextStep();
      } else {
        _showToast(
          context,
          context.l10n.toast_validation_error,
          context.l10n.toast_complete_required_fields,
        );
      }
    } else {
      _stepController.previousStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(16.dg),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.user.isFailure) {
                _handleSignUpFailure(context, state.user.error?.message);
              }
              if (state.user.isSuccess) {
                final email = _submittedEmail;
                if (email != null) {
                  _handleSignUpSuccess(context, state.user.message, email);
                }
              }
            },
            builder: (context, state) {
              return SafeScrollWrapper(
                blockWhen: () => _isDraggingMarker,
                child: Form(
                  controller: _formController,
                  onSubmit: _handleFormSubmit,
                  child: Column(
                    children: [
                      Gap(12.h),
                      Stepper(
                        controller: _stepController,
                        direction: Axis.horizontal,
                        variant: StepVariant.line,
                        size: StepSize.small,
                        steps: [
                          _buildStep1(context, state),
                          _buildStep2(context, state),
                          _buildStep3(context, state),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Step _buildStep1(BuildContext context, AuthState state) {
    final isLoading = state.user.isLoading;

    return Step(
      title: Text(context.l10n.step_1),
      contentBuilder: (context) => AuthStepContainer(
        heroImage: Assets.images.hero.signUpMerchant1.image(height: 200.h),
        title: context.l10n.merchant_step_1_description,
        content: [
          AuthTextField(
            formKey: _FormKeys.step1OwnerName,
            label: context.l10n.label_owner_name,
            placeholder: context.l10n.placeholder_name,
            icon: LucideIcons.user,
            validator: const LengthValidator(min: 3),
            enabled: !isLoading,
          ),
          AuthTextField(
            formKey: _FormKeys.step1OwnerEmail,
            label: context.l10n.label_email,
            placeholder: context.l10n.placeholder_email,
            icon: LucideIcons.mail,
            validator: const EmailValidator(),
            keyboardType: TextInputType.emailAddress,
            enabled: !isLoading,
          ),
          AuthPhoneField(
            enabled: !isLoading,
            onChanged: (countryCode, phoneNumber) {
              _selectedOwnerCountryCode = countryCode;
              _ownerPhoneNumber = phoneNumber;
              setState(() {});
            },
          ),
          AuthTextField(
            formKey: _FormKeys.step1OwnerPassword,
            label: context.l10n.password,
            placeholder: context.l10n.placeholder_password,
            icon: LucideIcons.key,
            validator: const SafePasswordValidator(),
            enabled: !isLoading,
            isPassword: true,
          ),
          AuthTextField(
            formKey: _FormKeys.step1OwnerConfirmPassword,
            label: context.l10n.label_confirm_password,
            placeholder: context.l10n.placeholder_password,
            icon: LucideIcons.key,
            validator: CompareWith.equal(
              _FormKeys.step1OwnerPassword,
              message: context.l10n.error_passwords_not_match,
            ),
            enabled: !isLoading,
            isPassword: true,
          ),
          AuthTermsCheckbox(
            value: _termsAccepted,
            enabled: !isLoading,
            onChanged: (value) => setState(() => _termsAccepted = value),
          ),
        ],
        actions: [
          AuthActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.back,
            onPressed: () => context.pop(),
          ),
          AuthActionButton(
            icon: LucideIcons.arrowRight,
            label: context.l10n.next,
            isPrimary: true,
            isTrailing: true,
            onPressed: () => _handleStepNavigation(
              isNext: true,
              validator: () => _validateStep(0, () => _isStep1Valid),
            ),
          ),
        ],
      ),
    );
  }

  Step _buildStep2(BuildContext context, AuthState state) {
    final isLoading = state.user.isLoading;

    return Step(
      title: Text(context.l10n.step_2),
      contentBuilder: (context) => AuthStepContainer(
        heroImage: Assets.images.hero.signUpMerchant2.image(height: 200.h),
        title: context.l10n.merchant_step_2_description,
        content: [
          AuthTextField(
            formKey: _FormKeys.step2OutletName,
            label: context.l10n.label_outlet_name,
            placeholder: context.l10n.placeholder_outlet_name,
            icon: LucideIcons.store,
            validator: const LengthValidator(min: 3),
            enabled: !isLoading,
          ),
          AuthTextField(
            formKey: _FormKeys.step2OutletEmail,
            label: context.l10n.label_email,
            placeholder: context.l10n.placeholder_outlet_email,
            icon: LucideIcons.mail,
            validator: const EmailValidator(),
            enabled: !isLoading,
          ),
          AuthPhoneField(
            enabled: !isLoading,
            onChanged: (countryCode, phoneNumber) {
              _selectedOutletCountryCode = countryCode;
              _outletPhoneNumber = phoneNumber;
              setState(() {});
            },
          ),
          _buildCategorySelect(isLoading),
          _buildLocationPicker(isLoading),
          AuthImagePicker(
            label: context.l10n.government_document,
            error: _step2DocsErrors[_Step2Docs.governmentDocument],
            onChanged: (file) => setState(
              () => _step2Docs[_Step2Docs.governmentDocument] = file,
            ),
          ),
        ],
        actions: [
          AuthActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.back,
            onPressed: () =>
                _handleStepNavigation(isNext: false, validator: () => true),
          ),
          AuthActionButton(
            icon: LucideIcons.arrowRight,
            label: context.l10n.next,
            isPrimary: true,
            isTrailing: true,
            onPressed: () => _handleStepNavigation(
              isNext: true,
              validator: () => _validateStep(1, () => _isStep2Valid),
            ),
          ),
        ],
      ),
    );
  }

  Step _buildStep3(BuildContext context, AuthState state) {
    final isLoading = state.user.isLoading;

    return Step(
      title: Text(context.l10n.step_3),
      contentBuilder: (context) => AuthStepContainer(
        heroImage: Assets.images.hero.signUpMerchant3.image(height: 200.h),
        title: context.l10n.merchant_step_3_description,
        content: [
          AuthEnumSelect<BankProvider>(
            label: context.l10n.label_bank_provider,
            placeholder: context.l10n.hint_bank_provider,
            value: _selectedBankProvider,
            items: BankProvider.values,
            enabled: !isLoading,
            onChanged: (value) => setState(() => _selectedBankProvider = value),
          ),
          AuthTextField(
            formKey: _FormKeys.step3BankNumber,
            label: context.l10n.label_bank_account_number,
            placeholder: context.l10n.placeholder_bank_account,
            keyboardType: TextInputType.number,
            icon: LucideIcons.wallet,
            validator: const LengthValidator(min: 5),
            enabled: !isLoading,
          ),
        ],
        actions: [
          AuthActionButton(
            icon: LucideIcons.arrowLeft,
            label: context.l10n.back,
            onPressed: () =>
                _handleStepNavigation(isNext: false, validator: () => true),
          ),
          Expanded(
            child: AuthSubmitButton(
              label: context.l10n.sign_up,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelect(bool isLoading) {
    const categories = MerchantCategory.values;
    final categoryIcons = {
      MerchantCategory.ATK: LucideIcons.pencil,
      MerchantCategory.printing: LucideIcons.printer,
      MerchantCategory.food: LucideIcons.utensils,
    };
    final categoryLabels = {
      MerchantCategory.ATK: context.l10n.atk,
      MerchantCategory.printing: context.l10n.printing,
      MerchantCategory.food: context.l10n.food,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        Text(context.l10n.label_outlet_category),
        Text(
          context.l10n.helper_outlet_category_select,
          style: context.theme.typography.small,
        ).muted(),
        SizedBox(
          width: double.infinity,
          child: Select<MerchantCategory>(
            enabled: !isLoading,
            itemBuilder: (context, item) => Row(
              spacing: 8.w,
              children: [
                Icon(categoryIcons[item], size: 16.sp),
                Text(categoryLabels[item] ?? item.name),
              ],
            ),
            value: _selectedCategory,
            placeholder: Text(context.l10n.placeholder_select_outlet_category),
            onChanged: (value) => setState(() => _selectedCategory = value),
            popup: SelectPopup<MerchantCategory>(
              items: SelectItemList(
                children: categories
                    .map(
                      (e) => SelectItemButton(
                        value: e,
                        child: Row(
                          spacing: 8.w,
                          children: [
                            Icon(categoryIcons[e], size: 16.sp),
                            Text(categoryLabels[e] ?? e.name),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ).call,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationPicker(bool isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(context.l10n.label_outlet_location),
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
                      style: context.theme.typography.small.copyWith(
                        color: context.theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        Text(
          context.l10n.helper_outlet_location,
          style: context.theme.typography.small,
        ).muted(),
        // Search bar with suggestions
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
                        ),
                        enabled: !isLoading,
                        onChanged: _onSearchChanged,
                        onSubmitted: (_) =>
                            _searchLocation(_searchController.text),
                        features: [
                          InputFeature.leading(
                            _isSearching
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
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
                // Suggestions dropdown
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
                      separatorBuilder: (context, index) => Divider(
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
                                        style: context.theme.typography.small,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
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
                        // Ensure marker is visible after map is created
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
                : const Center(child: CircularProgressIndicator()),
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
                    style: context.theme.typography.small,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
