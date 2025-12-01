# Emergency Button - Flutter Implementation TODO

## ✅ Completed (Backend)

### Phase 1: Schema & Database  
- Emergency types & status enums (ACCIDENT, HARASSMENT, THEFT, MEDICAL, OTHER)
- Emergency table with PostGIS location tracking
- EmergencyRepository with CRUD operations
- Database migration applied

### Phase 2: Handler & Permissions
- Emergency handler with 4 endpoints (trigger, listByOrder, get, updateStatus)
- RBAC permissions for all roles
- Routes registered at `/api/emergencies/*`

### Phase 3: Database Migration
- Fixed `driverId` type to UUID for FK compatibility
- All indexes and constraints in place

## 🚧 In Progress (Flutter)

### Phase 4A: Data Layer (STARTED)
**Location:** `apps/mobile/lib/features/emergency/data/`

✅ Created `emergency_repository.dart` with placeholder methods:
- `trigger(TriggerEmergencyQuery)` - Trigger emergency during IN_TRIP
- `listByOrder(String orderId)` - List emergencies for an order
- `get(String id)` - Get single emergency details

⚠️ **BLOCKED:** Needs API client regeneration after server start

**TODO:**
1. Start server: `bun run dev:server` (may take time)
2. Generate API client: `make gen` (generates from `/api/spec.json`)
3. Update repository methods to use generated API calls
4. Create `_export.dart` file

### Phase 4B: State Management (STARTED)
**Location:** `apps/mobile/lib/features/emergency/presentation/states/`

✅ Created `emergency_state.dart`:
- `EmergencyState` with `triggered` and `list` fields
- Extends `BaseState2` with copyWith pattern
- State transitions: initial → loading → success/failure

⚠️ **BLOCKED:** Needs `melos generate` to create mapper

**TODO:**
1. Run `melos generate` to create `_export.mapper.dart`
2. Verify state compiles without errors

### Phase 4C: Cubit (NOT STARTED)
**Location:** `apps/mobile/lib/features/emergency/presentation/cubits/`

**Files to create:**
- `emergency_cubit.dart`
- `_export.dart`

**Implementation:**
```dart
class EmergencyCubit extends BaseCubit<EmergencyState> {
  EmergencyCubit({required EmergencyRepository repository}) 
    : _repository = repository, 
      super(EmergencyState());

  final EmergencyRepository _repository;

  Future<void> trigger({
    required String orderId,
    required EmergencyType type,
    required String description,
    EmergencyLocation? location,
  }) async {
    try {
      emit(state.toLoading());
      
      final res = await _repository.trigger(
        TriggerEmergencyQuery(
          orderId: orderId,
          type: type,
          description: description,
          location: location,
        ),
      );

      emit(state.toSuccess(
        triggered: res.data,
        message: res.message,
      ));
    } on BaseError catch (e, st) {
      logger.e('[EmergencyCubit] Failed to trigger emergency', 
        error: e, stackTrace: st);
      emit(state.toFailure(e));
    }
  }

  Future<void> loadByOrder(String orderId) async {
    try {
      emit(state.toLoading());
      
      final res = await _repository.listByOrder(orderId);

      emit(state.toSuccess(
        list: res.data,
        message: res.message,
      ));
    } on BaseError catch (e, st) {
      logger.e('[EmergencyCubit] Failed to load emergencies', 
        error: e, stackTrace: st);
      emit(state.toFailure(e));
    }
  }

  void reset() {
    emit(EmergencyState());
  }
}
```

### Phase 4D: UI Widget (NOT STARTED)
**Location:** `apps/mobile/lib/features/emergency/presentation/widgets/`

**Files to create:**
- `emergency_button.dart` - Main emergency button widget
- `emergency_trigger_dialog.dart` - Modal for type selection
- `_export.dart`

**Key Features:**
1. **Emergency Button Widget:**
   - Prominent red panic button
   - Only visible during `IN_TRIP` status
   - Shows icon (e.g., `LucideIcons.alertTriangle`)
   - Positioned as FloatingActionButton or in AppBar

2. **Emergency Trigger Dialog:**
   - Emergency type selector (ACCIDENT, HARASSMENT, THEFT, MEDICAL, OTHER)
   - Description text field
   - Current location capture (automatic via Geolocator)
   - Confirmation step ("Are you sure?")
   - Disable button during loading
   - Success/error toast messages

**Example Widget:**
```dart
class EmergencyButton extends StatelessWidget {
  const EmergencyButton({
    required this.orderId,
    required this.currentLocation,
    super.key,
  });

  final String orderId;
  final EmergencyLocation currentLocation;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showEmergencyDialog(context),
      backgroundColor: Colors.red,
      child: const Icon(LucideIcons.alertTriangle, color: Colors.white),
    );
  }

  void _showEmergencyDialog(BuildContext context) {
    // Show dialog with emergency type selection
    // Call cubit.trigger() on confirmation
  }
}
```

### Phase 4E: Integration (NOT STARTED)
**Location:** Multiple files

**1. Register Dependencies in `locator.dart`:**
```dart
// Add to repository registration
sl.registerLazySingleton<EmergencyRepository>(
  () => EmergencyRepository(apiClient: sl()),
);

// Add to cubit registration  
sl.registerFactory<EmergencyCubit>(
  () => EmergencyCubit(repository: sl()),
);
```

**2. Add to Ride Screens:**

**For Users:** `apps/mobile/lib/features/user/presentation/screens/ride/user_ride_on_trip_screen.dart`
- Add `EmergencyButton` to screen (FloatingActionButton or AppBar action)
- Show only when order status is `IN_TRIP`
- Pass current location from `user_location_cubit`

**For Drivers:** `apps/mobile/lib/features/driver/presentation/screens/driver_ride_on_trip_screen.dart` (if exists)
- Same as user screen
- Drivers can also trigger emergencies

**3. Add Emergency View Screen (Optional):**
- Screen to view emergency details
- List emergencies for an order
- Show status updates from operators

### Phase 4F: Testing (NOT STARTED)

**Unit Tests:** `apps/mobile/test/features/emergency/`
- `cubit/emergency_cubit_test.dart`
- `data/emergency_repository_test.dart`

**Widget Tests:**
- `presentation/widgets/emergency_button_test.dart`

**Integration Test:**
- End-to-end emergency trigger flow

## 🔑 Key Implementation Notes

1. **Location Capture:**
   - Use `geolocator` package to get current GPS coordinates
   - Convert to `EmergencyLocation(latitude, longitude)`
   - Capture automatically when emergency button is pressed

2. **Order Status Check:**
   - Emergency button only enabled when order status is `IN_TRIP`
   - Disable button in other states

3. **Confirmation Dialog:**
   - Always show confirmation before triggering
   - Warn user that emergency contacts will be notified

4. **Error Handling:**
   - Show toast on success: "Emergency triggered, help is on the way"
   - Show error toast if API fails
   - Handle network errors gracefully

5. **Real-time Updates (Future Enhancement):**
   - WebSocket subscription for emergency status updates
   - Show notification when operator acknowledges emergency

## 📋 Step-by-Step Completion Guide

**Step 1: Generate API Client**
```bash
# From project root
bun run dev:server  # Start server (may take time)
make gen            # Generate Dart API client
melos generate      # Run build_runner for json_serializable
```

**Step 2: Fix Repository**
- Update `emergency_repository.dart` with actual API calls
- Remove placeholder errors

**Step 3: Generate State Mapper**
```bash
cd apps/mobile
melos generate  # Generates _export.mapper.dart
```

**Step 4: Create Cubit**
- Implement `emergency_cubit.dart` with trigger/load methods
- Add error handling and logging

**Step 5: Create UI Widgets**
- Build `emergency_button.dart`
- Build `emergency_trigger_dialog.dart`
- Test UI independently

**Step 6: Register Dependencies**
- Add to `locator.dart`
- Add to feature exports

**Step 7: Integrate into Ride Screens**
- Add button to user ride screen
- Add button to driver ride screen (if exists)
- Test during active trip

**Step 8: Test**
- Write unit tests for cubit
- Write widget tests
- Manual end-to-end testing

## 🚨 Common Pitfalls to Avoid

1. ❌ Forgetting to check order status before showing button
2. ❌ Not capturing location before triggering
3. ❌ Missing confirmation dialog
4. ❌ Not handling API errors gracefully
5. ❌ Forgetting to register in `locator.dart`
6. ❌ Not running `melos generate` after creating state files
7. ❌ Not regenerating API client after backend changes

## 📝 Estimated Time

- **API Client Generation:** 5-10 minutes (server startup time)
- **Fix Repository:** 10 minutes
- **Create Cubit:** 20 minutes
- **Create UI Widgets:** 45-60 minutes
- **Integration:** 30 minutes
- **Testing:** 30-45 minutes

**Total:** ~3-4 hours

## ✅ Success Criteria

- [ ] Emergency button visible during IN_TRIP status
- [ ] Tapping button shows type selection dialog
- [ ] Confirmation dialog before triggering
- [ ] API call successfully creates emergency record
- [ ] Success toast shown to user
- [ ] Location captured and sent with emergency
- [ ] Operators can see emergency in admin panel (future)
- [ ] No errors in console during trigger flow
