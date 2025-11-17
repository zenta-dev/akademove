# api_client.api.BadgeApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**badgeCreate**](BadgeApi.md#badgecreate) | **POST** /badges | 
[**badgeGet**](BadgeApi.md#badgeget) | **GET** /badges/{id} | 
[**badgeList**](BadgeApi.md#badgelist) | **GET** /badges | 
[**badgeRemove**](BadgeApi.md#badgeremove) | **DELETE** /badges/{id} | 
[**badgeUpdate**](BadgeApi.md#badgeupdate) | **PUT** /badges/{id} | 
[**badgeUserCreate**](BadgeApi.md#badgeusercreate) | **POST** /badges/user | 
[**badgeUserGet**](BadgeApi.md#badgeuserget) | **GET** /badges/user/{id} | 
[**badgeUserList**](BadgeApi.md#badgeuserlist) | **GET** /badges/user | 
[**badgeUserRemove**](BadgeApi.md#badgeuserremove) | **DELETE** /badges/user/{id} | 
[**badgeUserUpdate**](BadgeApi.md#badgeuserupdate) | **PUT** /badges/user/{id} | 


# **badgeCreate**
> BadgeCreate200Response badgeCreate(code, name, description, type, level, targetRole, isActive, displayOrder, criteriaMinOrders, criteriaMinRating, criteriaMinOnTimeRate, criteriaMinStreak, criteriaMinEarnings, benefitsPriorityBoost, benefitsCommissionReduction, icon)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String code = code_example; // String | 
final String name = name_example; // String | 
final String description = description_example; // String | 
final String type = type_example; // String | 
final String level = level_example; // String | 
final String targetRole = targetRole_example; // String | 
final bool isActive = true; // bool | 
final int displayOrder = 56; // int | 
final int criteriaMinOrders = 56; // int | 
final num criteriaMinRating = 8.14; // num | 
final num criteriaMinOnTimeRate = 8.14; // num | 
final int criteriaMinStreak = 56; // int | 
final num criteriaMinEarnings = 8.14; // num | 
final int benefitsPriorityBoost = 56; // int | 
final num benefitsCommissionReduction = 8.14; // num | 
final MultipartFile icon = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.badgeCreate(code, name, description, type, level, targetRole, isActive, displayOrder, criteriaMinOrders, criteriaMinRating, criteriaMinOnTimeRate, criteriaMinStreak, criteriaMinEarnings, benefitsPriorityBoost, benefitsCommissionReduction, icon);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **code** | **String**|  | 
 **name** | **String**|  | 
 **description** | **String**|  | 
 **type** | **String**|  | 
 **level** | **String**|  | 
 **targetRole** | **String**|  | 
 **isActive** | **bool**|  | [default to true]
 **displayOrder** | **int**|  | [default to 0]
 **criteriaMinOrders** | **int**|  | [optional] 
 **criteriaMinRating** | **num**|  | [optional] 
 **criteriaMinOnTimeRate** | **num**|  | [optional] 
 **criteriaMinStreak** | **int**|  | [optional] 
 **criteriaMinEarnings** | **num**|  | [optional] 
 **benefitsPriorityBoost** | **int**|  | [optional] 
 **benefitsCommissionReduction** | **num**|  | [optional] 
 **icon** | **MultipartFile**|  | [optional] 

### Return type

[**BadgeCreate200Response**](BadgeCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeGet**
> BadgeCreate200Response badgeGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeCreate200Response**](BadgeCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeList**
> BadgeList200Response badgeList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.badgeList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

### Return type

[**BadgeList200Response**](BadgeList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeRemove**
> BadgeRemove200Response badgeRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUpdate**
> BadgeCreate200Response badgeUpdate(id, code, name, description, type, level, targetRole, criteriaMinOrders, criteriaMinRating, criteriaMinOnTimeRate, criteriaMinStreak, criteriaMinEarnings, benefitsPriorityBoost, benefitsCommissionReduction, isActive, displayOrder, icon)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 
final String code = code_example; // String | 
final String name = name_example; // String | 
final String description = description_example; // String | 
final String type = type_example; // String | 
final String level = level_example; // String | 
final String targetRole = targetRole_example; // String | 
final int criteriaMinOrders = 56; // int | 
final num criteriaMinRating = 8.14; // num | 
final num criteriaMinOnTimeRate = 8.14; // num | 
final int criteriaMinStreak = 56; // int | 
final num criteriaMinEarnings = 8.14; // num | 
final int benefitsPriorityBoost = 56; // int | 
final num benefitsCommissionReduction = 8.14; // num | 
final bool isActive = true; // bool | 
final int displayOrder = 56; // int | 
final MultipartFile icon = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.badgeUpdate(id, code, name, description, type, level, targetRole, criteriaMinOrders, criteriaMinRating, criteriaMinOnTimeRate, criteriaMinStreak, criteriaMinEarnings, benefitsPriorityBoost, benefitsCommissionReduction, isActive, displayOrder, icon);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **code** | **String**|  | [optional] 
 **name** | **String**|  | [optional] 
 **description** | **String**|  | [optional] 
 **type** | **String**|  | [optional] 
 **level** | **String**|  | [optional] 
 **targetRole** | **String**|  | [optional] 
 **criteriaMinOrders** | **int**|  | [optional] 
 **criteriaMinRating** | **num**|  | [optional] 
 **criteriaMinOnTimeRate** | **num**|  | [optional] 
 **criteriaMinStreak** | **int**|  | [optional] 
 **criteriaMinEarnings** | **num**|  | [optional] 
 **benefitsPriorityBoost** | **int**|  | [optional] 
 **benefitsCommissionReduction** | **num**|  | [optional] 
 **isActive** | **bool**|  | [optional] [default to true]
 **displayOrder** | **int**|  | [optional] [default to 0]
 **icon** | **MultipartFile**|  | [optional] 

### Return type

[**BadgeCreate200Response**](BadgeCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserCreate**
> BadgeUserCreate200Response badgeUserCreate(badgeUserCreateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final BadgeUserCreateRequest badgeUserCreateRequest = ; // BadgeUserCreateRequest | 

try {
    final response = api.badgeUserCreate(badgeUserCreateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **badgeUserCreateRequest** | [**BadgeUserCreateRequest**](BadgeUserCreateRequest.md)|  | 

### Return type

[**BadgeUserCreate200Response**](BadgeUserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserGet**
> BadgeUserCreate200Response badgeUserGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeUserGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeUserCreate200Response**](BadgeUserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserList**
> BadgeUserList200Response badgeUserList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.badgeUserList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

### Return type

[**BadgeUserList200Response**](BadgeUserList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserRemove**
> BadgeRemove200Response badgeUserRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 

try {
    final response = api.badgeUserRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **badgeUserUpdate**
> BadgeUserCreate200Response badgeUserUpdate(id, badgeUserUpdateRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getBadgeApi();
final String id = id_example; // String | 
final BadgeUserUpdateRequest badgeUserUpdateRequest = ; // BadgeUserUpdateRequest | 

try {
    final response = api.badgeUserUpdate(id, badgeUserUpdateRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling BadgeApi->badgeUserUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **badgeUserUpdateRequest** | [**BadgeUserUpdateRequest**](BadgeUserUpdateRequest.md)|  | 

### Return type

[**BadgeUserCreate200Response**](BadgeUserCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

