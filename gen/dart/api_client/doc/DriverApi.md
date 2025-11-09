# api_client.api.DriverApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driverGet**](DriverApi.md#driverget) | **GET** /drivers/{id} | 
[**driverGetMine**](DriverApi.md#drivergetmine) | **GET** /drivers/mine | 
[**driverList**](DriverApi.md#driverlist) | **GET** /drivers | 
[**driverNearby**](DriverApi.md#drivernearby) | **GET** /drivers/nearby | 
[**driverRemove**](DriverApi.md#driverremove) | **DELETE** /drivers/{id} | 
[**driverScheduleCreate**](DriverApi.md#driverschedulecreate) | **POST** /drivers/{driverId}/schedules | 
[**driverScheduleGet**](DriverApi.md#driverscheduleget) | **GET** /drivers/{driverId}/schedules/{id} | 
[**driverScheduleList**](DriverApi.md#driverschedulelist) | **GET** /drivers/{driverId}/schedules | 
[**driverScheduleRemove**](DriverApi.md#driverscheduleremove) | **DELETE** /drivers/{driverId}/schedules/{id} | 
[**driverScheduleUpdate**](DriverApi.md#driverscheduleupdate) | **PUT** /drivers/{driverId}/schedules/{id} | 
[**driverUpdate**](DriverApi.md#driverupdate) | **PUT** /drivers/{id} | 


# **driverGet**
> DriverGetMine200ResponseBody driverGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverGetMine**
> DriverGetMine200Response driverGetMine()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();

try {
    final response = api.driverGetMine();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverGetMine: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DriverGetMine200Response**](DriverGetMine200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverList**
> DriverList200Response driverList(cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.driverList(cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverList: $e\n');
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

[**DriverList200Response**](DriverList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverNearby**
> DriverList200Response driverNearby(x, y, radiusKm, limit, gender)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final num x = 8.14; // num | 
final num y = 8.14; // num | 
final num radiusKm = 8.14; // num | 
final num limit = 8.14; // num | 
final UserGender gender = ; // UserGender | 

try {
    final response = api.driverNearby(x, y, radiusKm, limit, gender);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverNearby: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **x** | **num**|  | 
 **y** | **num**|  | 
 **radiusKm** | **num**|  | 
 **limit** | **num**|  | 
 **gender** | [**UserGender**](.md)|  | [optional] 

### Return type

[**DriverList200Response**](DriverList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverRemove**
> DriverRemove200Response driverRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 

try {
    final response = api.driverRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverRemove200Response**](DriverRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleCreate**
> DriverScheduleCreate200Response driverScheduleCreate(driverId, insertDriverScheduleRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final InsertDriverScheduleRequest insertDriverScheduleRequest = ; // InsertDriverScheduleRequest | 

try {
    final response = api.driverScheduleCreate(driverId, insertDriverScheduleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **insertDriverScheduleRequest** | [**InsertDriverScheduleRequest**](InsertDriverScheduleRequest.md)|  | 

### Return type

[**DriverScheduleCreate200Response**](DriverScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleGet**
> DriverScheduleCreate200Response driverScheduleGet(driverId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.driverScheduleGet(driverId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**DriverScheduleCreate200Response**](DriverScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleList**
> DriverScheduleList200Response driverScheduleList(driverId, cursor, limit, page, query, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.driverScheduleList(driverId, cursor, limit, page, query, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] [default to 'desc']

### Return type

[**DriverScheduleList200Response**](DriverScheduleList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleRemove**
> DriverRemove200Response driverScheduleRemove(driverId, id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String id = id_example; // String | 

try {
    final response = api.driverScheduleRemove(driverId, id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleRemove: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **id** | **String**|  | 

### Return type

[**DriverRemove200Response**](DriverRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverScheduleUpdate**
> DriverScheduleCreate200Response driverScheduleUpdate(driverId, id, updateDriverScheduleRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String driverId = driverId_example; // String | 
final String id = id_example; // String | 
final UpdateDriverScheduleRequest updateDriverScheduleRequest = ; // UpdateDriverScheduleRequest | 

try {
    final response = api.driverScheduleUpdate(driverId, id, updateDriverScheduleRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverScheduleUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **id** | **String**|  | 
 **updateDriverScheduleRequest** | [**UpdateDriverScheduleRequest**](UpdateDriverScheduleRequest.md)|  | 

### Return type

[**DriverScheduleCreate200Response**](DriverScheduleCreate200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverUpdate**
> DriverGetMine200ResponseBody driverUpdate(id, studentId, licensePlate, studentCard, driverLicense, vehicleCertificate, bank, currentLocation)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverApi();
final String id = id_example; // String | 
final num studentId = 8.14; // num | 
final String licensePlate = licensePlate_example; // String | 
final MultipartFile studentCard = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile driverLicense = BINARY_DATA_HERE; // MultipartFile | 
final MultipartFile vehicleCertificate = BINARY_DATA_HERE; // MultipartFile | 
final DriverUpdateRequestBank bank = ; // DriverUpdateRequestBank | 
final DriverUpdateRequestCurrentLocation currentLocation = ; // DriverUpdateRequestCurrentLocation | 

try {
    final response = api.driverUpdate(id, studentId, licensePlate, studentCard, driverLicense, vehicleCertificate, bank, currentLocation);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->driverUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **studentId** | **num**|  | [optional] 
 **licensePlate** | **String**|  | [optional] 
 **studentCard** | **MultipartFile**|  | [optional] 
 **driverLicense** | **MultipartFile**|  | [optional] 
 **vehicleCertificate** | **MultipartFile**|  | [optional] 
 **bank** | [**DriverUpdateRequestBank**](DriverUpdateRequestBank.md)|  | [optional] 
 **currentLocation** | [**DriverUpdateRequestCurrentLocation**](DriverUpdateRequestCurrentLocation.md)|  | [optional] 

### Return type

[**DriverGetMine200ResponseBody**](DriverGetMine200ResponseBody.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

