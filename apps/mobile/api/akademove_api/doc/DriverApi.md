# akademove_api.api.DriverApi

## Load the API package
```dart
import 'package:akademove_api/api.dart';
```

All URIs are relative to *http://localhost:3000*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createDriver**](DriverApi.md#createdriver) | **POST** /drivers | 
[**deleteDriver**](DriverApi.md#deletedriver) | **DELETE** /drivers/{id} | 
[**getAllDriver**](DriverApi.md#getalldriver) | **GET** /drivers | 
[**getDriverById**](DriverApi.md#getdriverbyid) | **GET** /drivers/{id} | 
[**updateDriver**](DriverApi.md#updatedriver) | **PUT** /drivers/{id} | 


# **createDriver**
> CreateDriverSuccessResponse createDriver(createDriverRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getDriverApi();
final CreateDriverRequest createDriverRequest = ; // CreateDriverRequest | 

try {
    final response = api.createDriver(createDriverRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->createDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createDriverRequest** | [**CreateDriverRequest**](CreateDriverRequest.md)|  | [optional] 

### Return type

[**CreateDriverSuccessResponse**](CreateDriverSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDriver**
> DeleteDriverSuccessResponse deleteDriver(id)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getDriverApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.deleteDriver(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->deleteDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DeleteDriverSuccessResponse**](DeleteDriverSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllDriver**
> GetAllDriverSuccessResponse getAllDriver(page, limit, cursor)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getDriverApi();
final int page = 56; // int | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 

try {
    final response = api.getAllDriver(page, limit, cursor);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->getAllDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | 
 **limit** | **int**|  | [default to 10]
 **cursor** | **String**|  | [optional] 

### Return type

[**GetAllDriverSuccessResponse**](GetAllDriverSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getDriverById**
> GetDriverByIdSuccessResponse getDriverById(id, fromCache)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getDriverApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final bool fromCache = true; // bool | 

try {
    final response = api.getDriverById(id, fromCache);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->getDriverById: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fromCache** | **bool**|  | [default to false]

### Return type

[**GetDriverByIdSuccessResponse**](GetDriverByIdSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDriver**
> UpdateDriverSuccessResponse updateDriver(id, updateDriverRequest)



### Example
```dart
import 'package:akademove_api/api.dart';

final api = AkademoveApi().getDriverApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final UpdateDriverRequest updateDriverRequest = ; // UpdateDriverRequest | 

try {
    final response = api.updateDriver(id, updateDriverRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverApi->updateDriver: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateDriverRequest** | [**UpdateDriverRequest**](UpdateDriverRequest.md)|  | [optional] 

### Return type

[**UpdateDriverSuccessResponse**](UpdateDriverSuccessResponse.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

