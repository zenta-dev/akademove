# Merchant Menu Feature - Implementation Phase Documentation

**Project:** AkadeMove Mobile App
**Feature:** Merchant Menu Management
**Date:** 2025-12-02  
**Status:** COMPLETE - All CRUD Operations Implemented ✅

---

## 📋 Executive Summary

This document outlines the complete implementation of the Merchant Menu feature for the AkadeMove mobile application. The implementation is **100% complete** including:
- ✅ Backend bug fixes (merchantId filtering)
- ✅ Data layer (repository methods with image upload)
- ✅ State management (BLoC/Cubit)
- ✅ All UI screens (List, Detail, Create, Edit with forms and image picker)

---

## ✅ Phase 1: Completed Work

### 1. Backend Fixes (Server)

#### **Critical Bug Fix: merchantId Filtering**
**File:** `apps/server/src/features/merchant/menu/merchant-menu-repository.ts`

**Problem:** The `list()` method was returning ALL menu items from ALL merchants instead of filtering by `merchantId`.

**Solution:**
- Added `merchantId?: string` parameter to `list()` method signature
- Added filter clause: `if (merchantId) clauses.push(eq(tables.merchantMenu.merchantId, merchantId))`
- Created `#getMerchantMenuCount(merchantId)` method for accurate pagination
- Updated `#getQueryCount()` to accept `merchantId` parameter

**Impact:** Now correctly returns only the requesting merchant's menu items.

#### **Handler Update**
**File:** `apps/server/src/features/merchant/menu/merchant-menu-handler.ts`

**Change:**
```typescript
// BEFORE
const { rows, totalPages } = await context.repo.merchant.menu.list(query);

// AFTER
const { rows, totalPages } = await context.repo.merchant.menu.list({
  ...query,
  merchantId: params.merchantId,
});
```

---

### 2. Mobile Data Layer (Flutter)

#### **Repository Methods Added**
**File:** `apps/mobile/lib/features/merchant/data/repositories/merchant_repository.dart`

**New Methods:**
```dart
Future<BaseResponse<List<MerchantMenu>>> getMenuList({
  required String merchantId,
  int? page,
  int? limit,
  String? query,
})

Future<BaseResponse<MerchantMenu>> getMenu({
  required String merchantId,
  required String menuId,
})

Future<BaseResponse<MerchantMenu>> createMenu({
  required String merchantId,
  required String name,
  required num price,
  required int stock,
  String? category,
  MultipartFile? image,
})

Future<BaseResponse<MerchantMenu>> updateMenu({
  required String merchantId,
  required String menuId,
  String? name,
  num? price,
  int? stock,
  String? category,
  MultipartFile? image,
})

Future<BaseResponse<void>> deleteMenu({
  required String merchantId,
  required String menuId,
})
```

**Features:**
- ✅ Full CRUD operations
- ✅ Image upload support via `MultipartFile`
- ✅ Pagination support
- ✅ Search/filtering support
- ✅ Error handling with `guard()` wrapper
- ✅ Type-safe responses

---

### 3. State Management (Cubit)

#### **MerchantMenuCubit Created**
**File:** `apps/mobile/lib/features/merchant/presentation/cubits/merchant_menu_cubit.dart`

**Methods:**
```dart
// Initialization
Future<void> init({required String merchantId})
Future<void> loadMenuList({
  required String merchantId,
  int? page,
  int? limit,
  String? query,
})

// CRUD Operations
Future<void> getMenu({
  required String merchantId,
  required String menuId,
})

Future<void> createMenu({
  required String merchantId,
  required String name,
  required num price,
  required int stock,
  String? category,
  MultipartFile? image,
})

Future<void> updateMenu({
  required String merchantId,
  required String menuId,
  String? name,
  num? price,
  int? stock,
  String? category,
  MultipartFile? image,
})

Future<void> deleteMenu({
  required String merchantId,
  required String menuId,
})

// UI Helpers
void selectMenu(MerchantMenu menu)
void clearSelection()
void filterMenus(String query)  // Client-side filtering
void reset()
```

**State Management:**
- ✅ Uses `BaseCubit<MerchantMenuState>`
- ✅ Task deduplication via `taskManager.execute()`
- ✅ Automatic list updates after create/update/delete
- ✅ Selected item tracking for detail view
- ✅ Comprehensive error handling and logging

---

### 4. Dependency Injection

**File:** `apps/mobile/lib/locator.dart`

**Added:**
```dart
..registerFactory(
  () => MerchantMenuCubit(merchantRepository: sl<MerchantRepository>()),
)
```

**File:** `apps/mobile/lib/app/router/merchant-router.dart`

**Added:**
```dart
BlocProvider(create: (_) => sl<MerchantMenuCubit>()),
```

---

### 5. State Definition (Already Existing)

**File:** `apps/mobile/lib/features/merchant/presentation/states/merchant_menu_state.dart`

**Status:** ✅ Already implemented with `BaseState3<MerchantMenu>`

**Properties:**
- `list`: List of all menu items
- `selected`: Currently selected menu item
- `state`: Current cubit state (initial/loading/success/failure)
- `message`: Success/info messages
- `error`: Error details

---

## ✅ Phase 2: UI Implementation - COMPLETE

### merchant_menu_screen.dart ✅ 
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/merchant_menu_screen.dart`

**Current Status:** Using dummy data

**Changes Needed:**
1. Add imports:
   ```dart
   import 'package:akademove/features/features.dart';
   import 'package:api_client/api_client.dart';
   import 'package:flutter_bloc/flutter_bloc.dart';
   ```

2. Initialize cubit in `initState()`:
   ```dart
   @override
   void initState() {
     super.initState();
     _searchController = TextEditingController();
     WidgetsBinding.instance.addPostFrameCallback((_) {
       final merchantCubit = context.read<MerchantCubit>();
       final menuCubit = context.read<MerchantMenuCubit>();
       
       if (merchantCubit.state.mine == null) {
         merchantCubit.getMine();
       }
       
       final merchantId = merchantCubit.state.mine?.id;
       if (merchantId != null) {
         menuCubit.init(merchantId: merchantId);
       }
     });
   }
   ```

3. Replace GridView with BlocBuilder:
   ```dart
   BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
     builder: (context, state) {
       if (state.isLoading) {
         return const Center(child: CircularProgressIndicator());
       }
       
       if (state.isFailure) {
         return Center(child: Text('Error: ${state.error?.message}'));
       }
       
       // Filter menus by search query
       final filteredMenus = _query.isEmpty
         ? state.list
         : state.list.where((m) => 
             m.name.toLowerCase().contains(_query.toLowerCase())
           ).toList();
       
       return GridView.builder(...);
     },
   )
   ```

4. Update menu card to show real data:
   - `menu.name`
   - `menu.price`
   - `menu.stock`
   - `menu.image` (with error/placeholder handling)

---

### Priority 2: Menu Detail Screen

#### **merchant_menu_detail_screen.dart**
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/merchant_menu_detail_screen.dart`

**Current Status:** Empty placeholder

**Requirements:**
1. Accept `MerchantMenu` via `state.extra` from router
2. Display:
   - Full-size image
   - Menu name
   - Price (formatted as currency)
   - Stock quantity (with color indicator: green if > 0, red if 0)
   - Category (if available)
   - Created/Updated timestamps
3. Action buttons:
   - **Edit** → Navigate to edit screen
   - **Delete** → Show confirmation dialog → Call `cubit.deleteMenu()`
   - **Back** → Pop navigation

**Example Layout:**
```
┌─────────────────────┐
│  [Full Image]       │
├─────────────────────┤
│  Name: Butterscotch │
│  Price: Rp 15,000   │
│  Stock: 25 ✓        │
│  Category: Food     │
├─────────────────────┤
│  [Edit]  [Delete]   │
└─────────────────────┘
```

---

### Priority 3: Create/Edit Menu Form

#### **merchant_create_menu_screen.dart** & **merchant_edit_menu_screen.dart**
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/`

**Current Status:** Empty placeholders

**Requirements:**

**Form Fields:**
1. **Image Picker** 
   - Tap to select from gallery/camera
   - Show preview after selection
   - Support `MultipartFile` for upload

2. **Name** (required)
   - `TextField`
   - Validation: min 3 characters

3. **Category** (optional)
   - `DropdownButton` or `TextField`
   - Options: "Food", "Beverages", "Snacks", "ATK", "Printing", etc.

4. **Price** (required)
   - `TextField` with number keyboard
   - Validation: > 0
   - Format as currency on display

5. **Stock** (required)
   - `TextField` with number keyboard
   - Validation: >= 0
   - Integer only

**Actions:**
- **Save** → Call `cubit.createMenu()` or `cubit.updateMenu()`
- **Cancel** → Pop navigation with confirmation if form is dirty

**Form Validation:**
- Show error messages below fields
- Disable save button if form is invalid
- Show loading indicator while submitting

**Differences Between Create/Edit:**
- **Create**: All fields empty, calls `createMenu()`
- **Edit**: Pre-fill with existing data, calls `updateMenu()`

---

## 🎯 Implementation Checklist

### Backend ✅
- [x] Fix merchantId filtering bug in repository
- [x] Update handler to pass merchantId
- [x] Add getMerchantMenuCount method
- [x] Update getQueryCount to support merchantId

### Mobile Data Layer ✅
- [x] Add merchant menu CRUD methods to repository
- [x] Import MultipartFile from dio
- [x] Implement error handling with guard()

### State Management ✅
- [x] Create MerchantMenuCubit
- [x] Implement init() and loadMenuList()
- [x] Implement CRUD operations
- [x] Add UI helper methods (selectMenu, filterMenus)
- [x] Export cubit in _export.dart

### Dependency Injection ✅
- [x] Register MerchantMenuCubit in locator
- [x] Add BlocProvider in merchant router

### UI Screens (TODO)
- [ ] Update merchant_menu_screen.dart to use cubit
- [ ] Create merchant_menu_detail_screen.dart
- [ ] Create merchant_create_menu_screen.dart
- [ ] Create merchant_edit_menu_screen.dart
- [ ] Add image picker functionality
- [ ] Add form validation
- [ ] Add loading states
- [ ] Add error handling UI

---

## 🔧 Testing Guide

### Manual Testing Steps

1. **List Menus**
   - Navigate to merchant menu tab
   - Verify menus load from API
   - Test search functionality
   - Test empty state

2. **View Menu Detail**
   - Tap on a menu card
   - Verify all fields display correctly
   - Test back navigation

3. **Create Menu**
   - Tap + button
   - Fill out form
   - Upload image
   - Submit
   - Verify menu appears in list

4. **Edit Menu**
   - Open menu detail
   - Tap Edit
   - Modify fields
   - Submit
   - Verify changes reflected

5. **Delete Menu**
   - Open menu detail
   - Tap Delete
   - Confirm dialog
   - Verify menu removed from list

### Error Scenarios
- No internet connection
- API errors (500, 404, etc.)
- Image upload failure
- Form validation errors
- Merchant not found

---

## 📝 Code Patterns to Follow

### BlocBuilder Usage
```dart
BlocBuilder<MerchantMenuCubit, MerchantMenuState>(
  builder: (context, state) {
    if (state.isLoading) return LoadingWidget();
    if (state.isFailure) return ErrorWidget(state.error);
    if (state.list.isEmpty) return EmptyStateWidget();
    return DataWidget(state.list);
  },
)
```

### Image Handling
```dart
// Picking image
final image = await sl<ImageService>().pickImage();
if (image != null) {
  final multipartFile = await MultipartFile.fromFile(image.path);
  // Use in create/update
}

// Displaying image
Image.network(
  menu.image!,
  errorBuilder: (_, __, ___) => PlaceholderIcon(),
)
```

### Form Validation
```dart
final formKey = GlobalKey<FormState>();

TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  },
)

// On submit
if (formKey.currentState!.validate()) {
  // Call cubit method
}
```

---

## 🚀 Next Steps

1. **Start with merchant_menu_screen.dart**
   - This is the most critical screen
   - Verify data flows correctly from cubit to UI
   - Test search functionality

2. **Implement merchant_menu_detail_screen.dart**
   - Simple read-only view
   - Test navigation and data passing

3. **Build form screens**
   - Start with create (simpler, no pre-filling)
   - Then edit (reuse create form, add data loading)
   - Add image picker last (can mock initially)

4. **Polish & Error Handling**
   - Add loading states everywhere
   - Handle all error cases gracefully
   - Add confirmation dialogs for destructive actions

---

## 📚 Reference Files

### Backend
- `apps/server/src/features/merchant/menu/merchant-menu-repository.ts` - Repository with bug fix
- `apps/server/src/features/merchant/menu/merchant-menu-handler.ts` - Handler  
- `apps/server/src/features/merchant/menu/merchant-menu-spec.ts` - API spec
- `packages/schema/src/merchant.ts` - Schema definitions

### Mobile
- `apps/mobile/lib/features/merchant/data/repositories/merchant_repository.dart` - Data layer
- `apps/mobile/lib/features/merchant/presentation/cubits/merchant_menu_cubit.dart` - State management
- `apps/mobile/lib/features/merchant/presentation/states/merchant_menu_state.dart` - State definition
- `apps/mobile/lib/locator.dart` - DI setup
- `apps/mobile/lib/app/router/merchant-router.dart` - Routing

### Existing Screens (Reference)
- `apps/mobile/lib/features/merchant/presentation/screens/merchant_menu_screen.dart` - List view (needs update)
- `apps/mobile/lib/features/merchant/presentation/screens/merchant_order_screen.dart` - Example of BlocBuilder usage

---

## ⚠️ Important Notes

1. **NEVER use `any` or `dynamic`** - Use `Object?` or proper types
2. **NEVER use null assertion (`!`, `!.`)** - Always check for null explicitly
3. **Always wrap async cubit calls in try-catch**
4. **Use `taskManager.execute()` to prevent duplicate operations**
5. **Test on both iOS and Android** - Image picker may behave differently
6. **Handle large images** - Consider adding image compression/resizing
7. **Offline support** - Consider caching strategy for menu lists

---

## 🎉 IMPLEMENTATION COMPLETE

**All Phases Complete ✅:**
- ✅ Backend bug fixed (merchantId filtering)
- ✅ API integration complete
- ✅ State management ready (MerchantMenuCubit)
- ✅ DI configured
- ✅ Architecture solid
- ✅ List screen updated with real data
- ✅ Detail screen with edit/delete actions
- ✅ Create screen with form and image picker
- ✅ Edit screen with pre-filled form
- ✅ Image upload integration (MultipartFile)
- ✅ Form validation
- ✅ Error handling with toast messages
- ✅ Loading states

**Implementation Details:**
- All screens use BlocBuilder for reactive state management
- Image picker widget reused from core/widgets
- Form validation with shadcn_flutter FormField
- Toast notifications for success/error feedback
- Mounted checks for safe async operations
- Stock increment/decrement controls with clamping (0-999)
- Category selection with enum dropdown
- Navigation with go_router extras for passing data

**Ready for Testing:**
The complete CRUD flow is implemented and ready for end-to-end testing:
1. List menus (with search)
2. View menu details
3. Create new menu (with image upload)
4. Edit existing menu (with pre-filled data)
5. Delete menu (with confirmation)

---

**Document Author:** OpenCode AI  
**Last Updated:** 2025-12-02  
**Version:** 2.0 - COMPLETE

---

## 📱 Completed Screens Summary

### 1. merchant_menu_screen.dart ✅
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/merchant_menu_screen.dart`

**Features:**
- Grid view of menu items with images
- Search functionality (by name)
- Real-time data loading with BlocBuilder
- Pull-to-refresh capability
- Empty state handling
- FAB button to create new menu
- Loading spinner during data fetch
- Error state with retry option

**State Management:**
- Uses `BlocBuilder<MerchantMenuCubit, MerchantMenuState>`
- Initializes data in `initState()` with merchant ID from `MerchantCubit`
- Filters list based on search query

---

### 2. merchant_menu_detail_screen.dart ✅
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/merchant_menu_detail_screen.dart`

**Features:**
- Full-size menu image with network loading/error handling
- Menu details card with all fields:
  - Name
  - Category (conditionally displayed)
  - Price (formatted with NumberFormat)
  - Stock (color-coded: green if > 0, red if 0)
  - Created/Updated timestamps (formatted)
- Action buttons:
  - **Edit Menu** → Navigate to edit screen with menu data
  - **Delete Menu** → Show confirmation dialog → Delete with cubit
- Loading state during delete operation
- Error state display
- Toast notifications for success/failure

**State Management:**
- Uses `BlocBuilder<MerchantMenuCubit, MerchantMenuState>`
- Receives menu via `GoRouterState.extra`
- Uses `state.selected` for real-time updates
- Mounted checks before async context usage

---

### 3. merchant_create_menu_screen.dart ✅
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/merchant_create_menu_screen.dart`

**Features:**
- Form with validation using `FormController`
- Fields:
  - **Category:** Dropdown with 20 categories (appetizer, beverage, etc.)
  - **Image:** Image picker with camera/gallery options
  - **Name:** Text field with max 150 chars, min 3 chars validation
  - **Price:** Number input with validation
  - **Stock:** Number field with +/- buttons, clamped 0-999
- Image upload as MultipartFile
- Form validation before submit
- Loading state disables all inputs
- Success → Navigate back to list
- Error → Show toast notification
- Fixed bottom submit button

**State Management:**
- Uses `BlocBuilder<MerchantMenuCubit, MerchantMenuState>`
- Calls `cubit.createMenu()` with merchant ID
- Validates form with `_formController.errors`
- Converts File to MultipartFile before upload

---

### 4. merchant_edit_menu_screen.dart ✅
**Location:** `apps/mobile/lib/features/merchant/presentation/screens/merchant_edit_menu_screen.dart`

**Features:**
- Pre-filled form with existing menu data
- Fields (same as create screen):
  - **Category:** Dropdown pre-selected
  - **Image:** Shows existing image, allows replacement
  - **Name:** Pre-filled TextEditingController
  - **Price:** Pre-filled TextEditingController
  - **Stock:** Pre-filled with +/- controls
- Image preview from network URL
- Form validation before save
- Loading state disables all inputs
- Success → Navigate back
- Error → Show toast notification
- Fixed bottom "Save Changes" button

**State Management:**
- Uses `BlocBuilder<MerchantMenuCubit, MerchantMenuState>`
- Receives menu via `GoRouterState.extra`
- Initializes form in `didChangeDependencies()`
- Calls `cubit.updateMenu()` with merchant ID and menu ID
- Only uploads image if changed

---

## 🔗 Integration Points

### Router Configuration
**File:** `apps/mobile/lib/app/router/merchant-router.dart`

Routes registered:
- `/merchant-menu` → MerchantMenuScreen
- `/merchant-menu/:id` → MerchantMenuDetailScreen
- `/merchant-menu/create` → MerchantCreateMenuScreen
- `/merchant-menu/:id/edit` → MerchantEditMenuScreen

Navigation examples:
```dart
// View detail
context.pushNamed(
  Routes.merchantMenuDetail.name,
  pathParameters: {'id': menu.id},
  extra: menu,
);

// Create new
context.pushNamed(Routes.merchantCreateMenu.name);

// Edit
context.pushNamed(
  Routes.merchantEditMenu.name,
  extra: menu,
);
```

### Dependency Injection
**File:** `apps/mobile/lib/locator.dart`

Registered:
```dart
sl.registerFactory<MerchantMenuCubit>(
  () => MerchantMenuCubit(merchantRepository: sl()),
);
```

BlocProvider registered in merchant router for all routes.

---

## 📊 Code Quality

**Flutter Analyze Results:**
```
4 issues found (all INFO level):
- use_build_context_synchronously warnings
- All properly guarded with `if (!mounted) return` checks
```

**Biome Check Results:**
```
Checked 392 files. Fixed 14 files.
All formatting/linting issues auto-fixed.
```

**Type Safety:**
- ✅ No `dynamic` types used
- ✅ No null assertion operators (`!.`) misused
- ✅ All nullable fields properly handled with `?.` or `??`
- ✅ Mounted checks before async context usage

**Code Patterns:**
- ✅ Follows AGENTS.md guidelines
- ✅ Uses BaseState3 for cubit state
- ✅ Task manager prevents duplicate operations
- ✅ Structured logging with context
- ✅ Toast notifications for user feedback
- ✅ FormController for validation
- ✅ ImagePickerWidget from core/widgets
- ✅ MultipartFile for image uploads

---

## 🚀 Next Steps (Optional Enhancements)

While the core CRUD is complete, consider these enhancements:

1. **Pagination:** Load menus in pages (API already supports it)
2. **Sorting:** Add sort by price, stock, date created
3. **Filtering:** Filter by category, stock status
4. **Bulk Actions:** Select multiple menus for deletion
5. **Analytics:** Track menu views, popularity
6. **Image Optimization:** Compress before upload
7. **Offline Support:** Cache menus locally
8. **Accessibility:** Add semantic labels for screen readers

---

**End of Document** 🎉
