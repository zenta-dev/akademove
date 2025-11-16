import 'dart:async';
import 'dart:io';

import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
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

  static const bankProvider = SelectKey<BankProviderEnum>('bank-provider');
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

  BankProviderEnum? _selectedBankProvider;
  Coordinate _outletLocation = MapConstants.defaultCoordinate;
  String _outletAddress = '';
  CountryCode _selectedOwnerCountryCode = CountryCode.ID;
  CountryCode _selectedOutletCountryCode = CountryCode.ID;
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
          'We need access to your location to automatically set your outlet location on the map. This helps customers find your business easily. You can also manually set the location by dragging the marker.',
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

  void _startBankAccountEdit() {
    debugPrint('=== START BANK ACCOUNT EDIT CLICKED ===');
    debugPrint('Before: _isBankAccountEditing = $_isBankAccountEditing');
    debugPrint('Before: _isBankAccountVerified = $_isBankAccountVerified');

    setState(() {
      _isBankAccountEditing = true;
      // Clear the field for new input
      _bankAccountController.clear();
    });

    debugPrint('After: _isBankAccountEditing = $_isBankAccountEditing');
    debugPrint('=== END START BANK ACCOUNT EDIT ===');
  }

  Future<void> _verifyBankAccount() async {
    final accountNumber = _bankAccountController.text.trim();

    if (accountNumber.isEmpty) {
      _showToast(
        context,
        'Validation Error',
        'Please enter bank account number',
      );
      return;
    }

    if (accountNumber.length < 5) {
      _showToast(
        context,
        'Validation Error',
        'Bank account number must be at least 5 digits',
      );
      return;
    }

    if (_selectedBankProvider == null) {
      _showToast(
        context,
        'Validation Error',
        'Please select a bank provider first',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Simulate API call to verify bank account
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Simulate successful verification with masked data
        final maskedNumber =
            '********${accountNumber.substring(accountNumber.length >= 4 ? accountNumber.length - 4 : 0)}';

        setState(() {
          _isBankAccountEditing = false;
          _isBankAccountVerified = true;
          _verifiedBankAccountNumber = maskedNumber;
          // Update controller with masked number
          _bankAccountController.text = maskedNumber;
          // Simulate getting account holder name (you can replace with actual API response)
          _accountHolderName = 'J**n D*e'; // This should come from API
          _ownerBankName = 'J**n D*e'; // This should come from API
          _isLoading = false;
        });

        _showToast(
          context,
          'Success',
          'Bank account verified successfully',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        _showToast(
          context,
          'Error',
          'Failed to verify bank account',
        );
      }
    }
  }

  void _cancelBankAccountEdit() {
    setState(() {
      _isBankAccountEditing = false;
      _bankAccountController.clear();
    });
  }

  Future<void> _handleSaveChanges() async {
    // Validate form
    final isValid = _formController.errors.isEmpty;

    if (!isValid) {
      _showToast(
        context,
        'Validation Error',
        'Please fill all required fields correctly',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        _showToast(
          context,
          'Success',
          'Profile updated successfully',
        );
      }
    } catch (e) {
      if (mounted) {
        _showToast(
          context,
          'Error',
          'Failed to update profile',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyScaffold(
          controller: _scrollController,
          headers: const [
            DefaultAppBar(title: 'Edit Profile'),
          ],
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
                padding: EdgeInsets.only(
                  bottom: 100.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 20.h,
                  children: [
                    _buildTextField(
                      key: _FormKeys.ownerName,
                      label: "Owner's Name",
                      placeholder: 'Enter owner name',
                      icon: LucideIcons.user,
                      validator: const LengthValidator(min: 3),
                      enabled: !_isLoading,
                    ),
                    _buildTextField(
                      key: _FormKeys.ownerEmail,
                      label: "Owner's Email",
                      placeholder: 'Enter owner email',
                      icon: LucideIcons.mail,
                      validator: const EmailValidator(),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !_isLoading,
                    ),
                    _buildPhoneField(
                      context,
                      _FormKeys.ownerPhoneNumber,
                      "Owner's Phone Number",
                      (val) {
                        if (val.country == Country.indonesia) {
                          _selectedOwnerCountryCode = CountryCode.ID;
                        }
                      },
                    ),
                    _buildTextField(
                      key: _FormKeys.outletName,
                      label: "Outlet's Name",
                      placeholder: 'Enter outlet name',
                      icon: LucideIcons.store,
                      validator: const LengthValidator(min: 3),
                      enabled: !_isLoading,
                    ),
                    _buildOutletLocationField(),
                    _buildPhoneField(
                      context,
                      _FormKeys.outletPhoneNumber,
                      "Outlet's Phone Number",
                      (val) {
                        if (val.country == Country.indonesia) {
                          _selectedOutletCountryCode = CountryCode.ID;
                        }
                      },
                    ),
                    _buildTextField(
                      key: _FormKeys.outletEmail,
                      label: "Outlet's Email",
                      placeholder: 'Enter outlet email',
                      icon: LucideIcons.mail,
                      validator: const EmailValidator(),
                      keyboardType: TextInputType.emailAddress,
                      enabled: !_isLoading,
                    ),
                    _buildImagePicker(
                      "Outlet's Document (Optional)",
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
                  onPressed: () {},
                  child: Text(
                    'Save changes',
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
        features: [
          InputFeature.leading(Icon(icon)),
        ],
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
          maxWidth: 207.5 * context.theme.scaling,
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
              "Outlet's Location",
              style: context.typography.small.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
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
          'Make sure the location point on the map is correct to meet the registration requirements.',
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
                          'Search location',
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
                                      if (suggestion.country != null)
                                        Text(
                                          suggestion.country!,
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
                          'Loading map...',
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
            'Benchmark (Optional)',
            style: context.theme.typography.small.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: TextField(
            placeholder: Text(
              'Next to the Uniqlo store.',
              style: context.theme.typography.small.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
            enabled: !_isLoading,
            features: const [
              InputFeature.leading(Icon(LucideIcons.mapPinned)),
            ],
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
          'Choose bank',
          style: context.theme.typography.small.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildEnumSelect<BankProviderEnum>(
          key: _FormKeys.bankProvider,
          placeholder: 'Select bank provider',
          value: _selectedBankProvider,
          items: BankProviderEnum.values,
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
          onImagePicked: (file) => setState(() => docs[key] = file),
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
    debugPrint('=== BUILDING BANK ACCOUNT FIELD ===');
    debugPrint('_isBankAccountEditing: $_isBankAccountEditing');
    debugPrint('_isBankAccountVerified: $_isBankAccountVerified');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.h,
      children: [
        // Row untuk FormField dan icon button
        Row(
          crossAxisAlignment: CrossAxisAlignment
              .end, // ✅ Ubah menjadi end agar sejajar dengan bottom TextField
          spacing: 8.w,
          children: [
            // TextField
            Expanded(
              child: FormField(
                key: _FormKeys.bankAccount,
                label: Text(
                  'Bank Account',
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
                    '********1234',
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

            // Icon button dengan padding bottom agar sejajar dengan TextField
            Padding(
              padding: EdgeInsets.only(bottom: 0.h), // ✅ Sesuaikan jika perlu
              child: GestureDetector(
                onTap: () {
                  if (_isLoading) return;

                  if (_isBankAccountEditing) {
                    debugPrint('✅ CHECKLIST TAPPED - Verifying...');
                    _verifyBankAccount();
                  } else {
                    debugPrint('✏️ PENCIL TAPPED - Starting edit...');
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
                  'Bank Account Number',
                  _verifiedBankAccountNumber ?? '',
                ),
                _buildBankDetailRow(
                  'Account Holder\'s Name',
                  _accountHolderName ?? '',
                ),
                _buildBankDetailRow(
                  'Owner\'s Name',
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

  String _getBankName(BankProviderEnum? provider) {
    if (provider == null) return 'Bank';
    return 'Bank ${provider.name.toUpperCase()}';
  }
}
