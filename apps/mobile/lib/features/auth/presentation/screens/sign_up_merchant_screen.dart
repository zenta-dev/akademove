import 'dart:async';
import 'dart:io';

import 'package:akademove/app/router/router.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/gen/assets.gen.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class _FormKeys {
  static const FormKey<String> step1OwnerName = TextFieldKey(
    'step-1-owner-name',
  );
  static const FormKey<String> step1OwnerEmail = TextFieldKey(
    'step-1-owner-email',
  );
  static const FormKey<String> step1OwnerPhoneNumber = TextFieldKey(
    'step-1-owner-phone-number',
  );
  static const FormKey<String> step1OwnerPassword = TextFieldKey(
    'step-1-owner-password',
  );
  static const FormKey<String> step1OwnerConfirmPassword = TextFieldKey(
    'step-1-owner-confirm_password',
  );

  static const FormKey<String> step2OutletName = TextFieldKey(
    'step-2-outlet-name',
  );
  static const FormKey<String> step2OutletEmail = TextFieldKey(
    'step-2-outlet-email',
  );
  static const FormKey<String> step2OutletPhoneNumber = TextFieldKey(
    'step-2-outlet-phone-number',
  );

  static const step3BankProvider = SelectKey<BankProviderEnum>(
    'step-3-bank-provider',
  );
  static const FormKey<String> step3BankNumber = TextFieldKey(
    'step-3-bank-number',
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

  BankProviderEnum? _selectedBankProvider;
  Coordinate _outletLocation = MapConstants.defaultCoordinate;
  String _outletAddress = '';
  CountryCode _selectedOwnerCountryCode = CountryCode.ID;
  CountryCode _selectedOutletCountryCode = CountryCode.ID;
  bool _isLocationLoaded = false;
  bool _isDraggingMarker = false;

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
            'Location Permission',
            'Using default location. You can drag the marker to set your outlet location.',
          );
        }
        return;
      }

      final position = await _determinePosition();
      if (!mounted) return;

      final location = Coordinate(
        x: position.longitude,
        y: position.latitude,
      );
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
      debugPrint('Error loading location: $e');
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
            'Permission Denied',
            'Location permission is required to set your outlet location automatically.',
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
        title: const Text('Location Permission'),
        content: const Text(
          'We need access to your location to automatically set your outlet location on the map. This helps customers find your business easily.\n\nYou can also manually set the location by dragging the marker.',
        ),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Allow'),
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
        title: const Text('Location Services Disabled'),
        content: const Text(
          'Location services are currently disabled on your device. Please enable them to automatically detect your outlet location.',
        ),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Open Settings'),
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
        title: const Text('Location Permission Required'),
        content: const Text(
          'Location permission has been permanently denied. To use automatic location detection, please enable it in your app settings.\n\nYou can still manually set your outlet location by dragging the marker on the map.',
        ),
        actions: [
          OutlineButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          PrimaryButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Open Settings'),
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
        infoWindow: const InfoWindow(
          title: 'Outlet Location',
          snippet: 'Drag to adjust position',
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
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
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
      desiredAccuracy: LocationAccuracy.high,
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
      debugPrint('Error getting address: $e');
      if (mounted) {
        setState(() => _outletAddress = 'Unable to get address');
      }
    }
  }

  Future<void> _searchLocation(String query) async {
    if (query.trim().isEmpty) {
      _showToast(context, 'Search Error', 'Please enter a location to search');
      return;
    }

    setState(() => _isSearching = true);

    try {
      final locations = await locationFromAddress(query);

      if (locations.isNotEmpty && mounted) {
        final location = locations.first;
        await _moveToLocation(location.latitude, location.longitude);

        _showToast(
          context,
          'Location Found',
          'Marker moved to searched location',
        );
      } else {
        if (mounted) {
          setState(() => _isSearching = false);
          _showToast(
            context,
            'Not Found',
            'Location not found. Please try a different search.',
          );
        }
      }
    } catch (e) {
      debugPrint('Error searching location: $e');
      if (mounted) {
        setState(() => _isSearching = false);
        _showToast(
          context,
          'Search Error',
          'Unable to search location. Please check your internet connection.',
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
      CameraUpdate.newLatLngZoom(
        LatLng(latitude, longitude),
        16,
      ),
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
      final locations = await locationFromAddress(
        query,
      );

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
            debugPrint('Error getting placemark: $e');
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
      debugPrint('Error fetching suggestions: $e');
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
    ].where((e) => e != null && e.isNotEmpty).join(', ');

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
      debugPrint('Error getting location from suggestion: $e');
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

  bool _validateStep(int stepIndex, bool Function() validator) {
    final isValid = validator();
    _stepController.setStatus(stepIndex, isValid ? null : StepState.failed);
    if (!isValid) _stepController.jumpToStep(stepIndex);
    return isValid;
  }

  bool _validateFormFields<T>(List<FormKey<T>> keys) {
    return keys.every((key) => _formController.errors[key] == null);
  }

  bool _validateDocuments<T>(Map<T, File?> docs, Map<T, String?> errors) {
    errors.updateAll((key, _) => null);
    var isValid = true;

    docs.forEach((key, file) {
      if (file == null) {
        errors[key] = "File shouldn't be empty";
        isValid = false;
      }
    });

    if (!isValid) setState(() {}); // Update UI to show errors
    return isValid;
  }

  bool get _isStep1Valid => _validateFormFields([
    _FormKeys.step1OwnerName,
    _FormKeys.step1OwnerEmail,
    _FormKeys.step1OwnerPhoneNumber,
    _FormKeys.step1OwnerPassword,
    _FormKeys.step1OwnerConfirmPassword,
  ]);

  bool get _isStep2Valid =>
      _validateFormFields([
        _FormKeys.step2OutletName,
        _FormKeys.step2OutletEmail,
        _FormKeys.step2OutletPhoneNumber,
      ]) &&
      _validateDocuments(_step2Docs, _step2DocsErrors);

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
      builder: (context, overlay) => context.buildToast(
        title: title,
        message: message,
      ),
      location: ToastLocation.topCenter,
    );
  }

  void _handleSignUpSuccess(BuildContext context, String? message) {
    _showToast(context, 'Sign Up Success', message ?? 'Successfully signed up');
    context.read<SignUpCubit>().reset();
    context.pushReplacementNamed(Routes.authSignIn.name);
  }

  void _handleSignUpFailure(BuildContext context, String? error) {
    _showToast(context, 'Sign Up Failed', error ?? 'Unknown error');
  }

  void _handleFormSubmit<T>(
    BuildContext context,
    Map<FormKey<T>, dynamic> values,
  ) {
    if (!_validateStep(2, () => _isStep3Valid)) return;

    final cubit = context.read<SignUpCubit>();
    if (cubit.state.isLoading) return;

    final formData = _extractFormData(values);
    if (formData == null) {
      _showToast(context, 'Error', 'Please fill all required fields');
      return;
    }

    cubit.signUpMerchant(
      ownerName: formData['ownerName']!,
      ownerEmail: formData['ownerEmail']!,
      ownerPhone: Phone(
        countryCode: _selectedOwnerCountryCode,
        number: int.parse(formData['ownerPhoneNumber']!),
      ),
      ownerPassword: formData['ownerPassword']!,
      ownerConfirmPassword: formData['ownerConfirmPassword']!,
      outletName: formData['outletName']!,
      outletEmail: formData['outletEmail']!,
      outletPhone: Phone(
        countryCode: _selectedOutletCountryCode,
        number: int.parse(formData['outletPhoneNumber']!),
      ),
      outletLocation: _outletLocation,
      outletAddress: _outletAddress,
      bankProvider: _selectedBankProvider!,
      bankNumber: int.parse(formData['bankNumber']!),
      photoPath: null,
      documentPath: _step2Docs[_Step2Docs.governmentDocument]!.path,
    );
  }

  Map<String, String>? _extractFormData<T>(Map<FormKey<T>, dynamic> values) {
    final data = {
      'ownerName': _FormKeys.step1OwnerName[values],
      'ownerEmail': _FormKeys.step1OwnerEmail[values],
      'ownerPhoneNumber': _FormKeys.step1OwnerPhoneNumber[values],
      'ownerPassword': _FormKeys.step1OwnerPassword[values],
      'ownerConfirmPassword': _FormKeys.step1OwnerConfirmPassword[values],
      'outletName': _FormKeys.step2OutletName[values],
      'outletEmail': _FormKeys.step2OutletEmail[values],
      'outletPhoneNumber': _FormKeys.step2OutletPhoneNumber[values],
      'bankNumber': _FormKeys.step3BankNumber[values],
    };

    // Validate all fields are present
    if (data.values.any((v) => v == null) ||
        _step2Docs.values.any((v) => v == null) ||
        _selectedBankProvider == null) {
      return null;
    }

    return data.map((k, v) => MapEntry(k, v!));
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
          'Validation Error',
          'Please complete all required fields',
        );
      }
    } else {
      _stepController.previousStep();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      controller: _scrollController,
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.isFailure) {
            _handleSignUpFailure(context, state.error?.message);
          }
          if (state.isSuccess) {
            _handleSignUpSuccess(context, state.message);
          }
        },
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              // Block scroll events when dragging marker
              if (_isDraggingMarker) {
                return true; // Consume the notification to prevent scrolling
              }
              return false; // Allow normal scrolling
            },
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
    );
  }

  Step _buildStep1(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 1'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpMerchant1.image(height: 200.h),
        title: 'Tell us about yourself to kickstart your merchant journey!',
        content: [
          _buildTextField(
            key: _FormKeys.step1OwnerName,
            label: 'Owner Name',
            placeholder: 'John Doe',
            icon: LucideIcons.user,
            validator: const LengthValidator(min: 3),
            enabled: !state.isLoading,
          ),
          _buildTextField(
            key: _FormKeys.step1OwnerEmail,
            label: 'Email',
            placeholder: 'john@gmail.com',
            icon: LucideIcons.mail,
            validator: const EmailValidator(),
            keyboardType: TextInputType.emailAddress,
            enabled: !state.isLoading,
          ),
          _buildPhoneField(
            context,
            state,
            _FormKeys.step1OwnerPhoneNumber,
            (val) {
              if (val.country == Country.indonesia) {
                _selectedOwnerCountryCode = CountryCode.ID;
              }
            },
          ),
          _buildTextField(
            key: _FormKeys.step1OwnerPassword,
            label: 'Password',
            placeholder: '*******',
            icon: LucideIcons.key,
            validator: const SafePasswordValidator(),
            enabled: !state.isLoading,
            isPassword: true,
          ),
          _buildTextField(
            key: _FormKeys.step1OwnerConfirmPassword,
            label: 'Confirm Password',
            placeholder: '*******',
            icon: LucideIcons.key,
            validator: const CompareWith.equal(
              _FormKeys.step1OwnerPassword,
              message: 'Passwords do not match',
            ),
            enabled: !state.isLoading,
            isPassword: true,
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: 'Back',
            onPressed: () => context.pop(),
          ),
          _buildActionButton(
            icon: LucideIcons.arrowRight,
            label: 'Next',
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

  Step _buildStep2(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 2'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpMerchant2.image(height: 200.h),
        title:
            'Share your outlet details and location so customers can find you easily!',
        content: [
          _buildTextField(
            key: _FormKeys.step2OutletName,
            label: 'Outlet Name',
            placeholder: 'Your Outlet Name',
            icon: LucideIcons.store,
            validator: const LengthValidator(min: 3),
            enabled: !state.isLoading,
          ),
          _buildTextField(
            key: _FormKeys.step2OutletEmail,
            label: 'Email',
            placeholder: 'outlet@example.com',
            icon: LucideIcons.mail,
            validator: const EmailValidator(),
            enabled: !state.isLoading,
          ),
          _buildPhoneField(
            context,
            state,
            _FormKeys.step2OutletPhoneNumber,
            (val) {
              if (val.country == Country.indonesia) {
                _selectedOutletCountryCode = CountryCode.ID;
              }
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Outlet Location'),
                  if (_isDraggingMarker)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
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
                            'Dragging...',
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
                'Search for a location, tap on map, or drag the marker',
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
                              placeholder: const Text(
                                'Search location (e.g., Monas Jakarta)',
                              ),
                              enabled: !state.isLoading,
                              onChanged: _onSearchChanged,
                              onSubmitted: (_) =>
                                  _searchLocation(_searchController.text),
                              features: [
                                InputFeature.leading(
                                  _isSearching
                                      ? SizedBox(
                                          width: 16.w,
                                          height: 16.h,
                                          child:
                                              const CircularProgressIndicator(
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
                          constraints: BoxConstraints(
                            maxHeight: 200.h,
                          ),
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
                                        color: context
                                            .theme
                                            .colorScheme
                                            .mutedForeground,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 2.h,
                                          children: [
                                            Text(
                                              displayText,
                                              style: context
                                                  .theme
                                                  .typography
                                                  .small,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            if (suggestion.country != null)
                                              Text(
                                                suggestion.country!,
                                                style: context
                                                    .theme
                                                    .typography
                                                    .xSmall
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
                                        color: context
                                            .theme
                                            .colorScheme
                                            .mutedForeground,
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
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  if (_mapController != null && mounted) {
                                    _mapController!.animateCamera(
                                      CameraUpdate.newLatLngZoom(
                                        LatLng(
                                          _outletLocation.y.toDouble(),
                                          _outletLocation.x.toDouble(),
                                        ),
                                        16,
                                      ),
                                    );
                                  }
                                },
                              );
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
                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () {
                                  if (mounted) {
                                    setState(() => _isDraggingMarker = false);
                                  }
                                },
                              );
                            },
                            myLocationEnabled: true,
                            zoomControlsEnabled: false,
                            rotateGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            mapToolbarEnabled: false,
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
              if (_outletAddress.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.secondary.withValues(
                      alpha: .1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.theme.colorScheme.border,
                    ),
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
          ),
          _buildImagePicker(
            'Government Document',
            _Step2Docs.governmentDocument,
            _step2Docs,
            _step2DocsErrors,
            context,
          ),
        ],
        actions: _buildNavigationActions(
          () => _validateStep(1, () => _isStep2Valid),
        ),
      ),
    );
  }

  Step _buildStep3(BuildContext context, SignUpState state) {
    return Step(
      title: const Text('Step 3'),
      contentBuilder: (context) => _buildStepContainer(
        heroImage: Assets.images.hero.signUpMerchant3.image(height: 200.h),
        title: 'Add your bank account to receive payments securely!',
        content: [
          _buildBankProviderSelect(state),
          _buildTextField(
            key: _FormKeys.step3BankNumber,
            label: 'Bank Account Number',
            placeholder: '11223344',
            keyboardType: TextInputType.number,
            icon: LucideIcons.wallet,
            validator: const LengthValidator(min: 5),
            enabled: !state.isLoading,
          ),
        ],
        actions: [
          _buildActionButton(
            icon: LucideIcons.arrowLeft,
            label: 'Back',
            onPressed: () => _handleStepNavigation(
              isNext: false,
              validator: () => true,
            ),
          ),
          _buildSubmitButton(state),
        ],
      ),
    );
  }

  Widget _buildStepContainer({
    required Widget heroImage,
    required String title,
    required List<Widget> content,
    required List<Widget> actions,
  }) {
    return StepContainer(
      actions: actions,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8.h,
        children: [
          heroImage,
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.theme.typography.h3.copyWith(fontSize: 20.sp),
          ),
          ...content,
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isPrimary = false,
    bool isTrailing = false,
  }) {
    final iconWidget = Icon(
      icon,
      size: 16.sp,
      color: isPrimary ? Colors.white : null,
    );
    final textWidget = Text(
      label,
      style: isPrimary
          ? context.theme.typography.small.copyWith(color: Colors.white)
          : null,
    );

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4.w,
      children: isTrailing
          ? [textWidget, iconWidget]
          : [iconWidget, textWidget],
    );

    return Expanded(
      child: isPrimary
          ? PrimaryButton(onPressed: onPressed, child: content)
          : OutlineButton(onPressed: onPressed, child: content),
    );
  }

  List<Widget> _buildNavigationActions(bool Function() validator) {
    return [
      _buildActionButton(
        icon: LucideIcons.arrowLeft,
        label: 'Back',
        onPressed: () => _handleStepNavigation(
          isNext: false,
          validator: () => true,
        ),
      ),
      _buildActionButton(
        icon: LucideIcons.arrowRight,
        label: 'Next',
        isPrimary: true,
        isTrailing: true,
        onPressed: () => _handleStepNavigation(
          isNext: true,
          validator: validator,
        ),
      ),
    ];
  }

  Widget _buildSubmitButton(SignUpState state) {
    return Expanded(
      child: FormErrorBuilder(
        builder: (context, errors, child) {
          final hasErrors = errors.isNotEmpty;
          final isLoading = state.isLoading;

          return Button(
            style: isLoading || hasErrors
                ? const ButtonStyle.outline()
                : const ButtonStyle.primary(),
            onPressed: (!hasErrors && !isLoading)
                ? () => context.submitForm()
                : null,
            child: isLoading
                ? const Submiting(simpleText: true)
                : Text(
                    'Sign Up',
                    style: context.theme.typography.medium.copyWith(
                      color: Colors.white,
                    ),
                  ),
          );
        },
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
    bool isPassword = false,
  }) {
    return FormField(
      key: key,
      label: Text(label),
      validator: validator,
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: TextField(
        placeholder: Text(placeholder),
        enabled: enabled,
        keyboardType: keyboardType,
        features: [
          InputFeature.leading(Icon(icon)),
          if (isPassword) const InputFeature.passwordToggle(),
        ],
      ),
    );
  }

  Widget _buildBankProviderSelect(SignUpState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.h,
      children: [
        const Text('Bank Provider'),
        _buildEnumSelect<BankProviderEnum>(
          key: _FormKeys.step3BankProvider,
          placeholder: 'Pick your bank provider',
          value: _selectedBankProvider,
          items: BankProviderEnum.values,
          enabled: !state.isLoading,
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
        placeholder: Text(placeholder),
        onChanged: onChanged,
        popup: SelectPopup<T>(
          items: SelectItemList(
            children: items
                .map(
                  (e) => SelectItemButton(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          ),
        ).call,
      ),
    );
  }

  Widget _buildPhoneField<T extends String>(
    BuildContext context,
    SignUpState state,
    FormKey<T> key,
    void Function(PhoneNumber val) onChanged,
  ) {
    return FormField(
      key: key,
      label: const Text('Phone'),
      validator: const LengthValidator(min: 10, max: 15),
      showErrors: const {
        FormValidationMode.changed,
        FormValidationMode.submitted,
      },
      child: ComponentTheme(
        data: PhoneInputTheme(
          maxWidth: 212 * context.theme.scaling,
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

  Widget _buildImagePicker<T>(
    String label,
    T key,
    Map<T, File?> docs,
    Map<T, String?> errors,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        Text(label),
        ImagePickerWidget(
          size: Size(double.infinity, 64.h),
          onValueChanged: (file) => setState(() => docs[key] = file),
        ),
        if (errors[key] != null)
          DefaultTextStyle.merge(
            style: TextStyle(color: context.theme.colorScheme.destructive),
            child: Text(errors[key]!).xSmall().medium(),
          ),
      ],
    );
  }
}
