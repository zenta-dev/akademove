# api_client.api.DriverQuizQuestionApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driverQuizQuestionCreate**](DriverQuizQuestionApi.md#driverquizquestioncreate) | **POST** /driver-quiz-questions | 
[**driverQuizQuestionGet**](DriverQuizQuestionApi.md#driverquizquestionget) | **GET** /driver-quiz-questions/{id} | 
[**driverQuizQuestionGetQuizQuestions**](DriverQuizQuestionApi.md#driverquizquestiongetquizquestions) | **GET** /driver-quiz-questions/quiz | 
[**driverQuizQuestionList**](DriverQuizQuestionApi.md#driverquizquestionlist) | **GET** /driver-quiz-questions | 
[**driverQuizQuestionRemove**](DriverQuizQuestionApi.md#driverquizquestionremove) | **DELETE** /driver-quiz-questions/{id} | 
[**driverQuizQuestionUpdate**](DriverQuizQuestionApi.md#driverquizquestionupdate) | **PUT** /driver-quiz-questions/{id} | 


# **driverQuizQuestionCreate**
> DriverQuizQuestionCreate201Response driverQuizQuestionCreate(insertDriverQuizQuestion)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizQuestionApi();
final InsertDriverQuizQuestion insertDriverQuizQuestion = ; // InsertDriverQuizQuestion | 

try {
    final response = api.driverQuizQuestionCreate(insertDriverQuizQuestion);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizQuestionApi->driverQuizQuestionCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **insertDriverQuizQuestion** | [**InsertDriverQuizQuestion**](InsertDriverQuizQuestion.md)|  | 

### Return type

[**DriverQuizQuestionCreate201Response**](DriverQuizQuestionCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizQuestionGet**
> DriverQuizQuestionCreate201Response driverQuizQuestionGet(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizQuestionApi();
final String id = id_example; // String | 

try {
    final response = api.driverQuizQuestionGet(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizQuestionApi->driverQuizQuestionGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**DriverQuizQuestionCreate201Response**](DriverQuizQuestionCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizQuestionGetQuizQuestions**
> DriverQuizQuestionGetQuizQuestions200Response driverQuizQuestionGetQuizQuestions(category, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizQuestionApi();
final String category = category_example; // String | 
final int limit = 56; // int | 

try {
    final response = api.driverQuizQuestionGetQuizQuestions(category, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizQuestionApi->driverQuizQuestionGetQuizQuestions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | **String**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

[**DriverQuizQuestionGetQuizQuestions200Response**](DriverQuizQuestionGetQuizQuestions200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizQuestionList**
> DriverQuizQuestionList200Response driverQuizQuestionList(cursor, limit, direction, page, query, sortBy, order, mode, category, type, isActive)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizQuestionApi();
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 
final DriverQuizQuestionCategory category = ; // DriverQuizQuestionCategory | 
final DriverQuizQuestionType type = ; // DriverQuizQuestionType | 
final bool isActive = true; // bool | 

try {
    final response = api.driverQuizQuestionList(cursor, limit, direction, page, query, sortBy, order, mode, category, type, isActive);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizQuestionApi->driverQuizQuestionList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]
 **category** | [**DriverQuizQuestionCategory**](.md)|  | [optional] 
 **type** | [**DriverQuizQuestionType**](.md)|  | [optional] 
 **isActive** | **bool**|  | [optional] 

### Return type

[**DriverQuizQuestionList200Response**](DriverQuizQuestionList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizQuestionRemove**
> BadgeRemove200Response driverQuizQuestionRemove(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizQuestionApi();
final String id = id_example; // String | 

try {
    final response = api.driverQuizQuestionRemove(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizQuestionApi->driverQuizQuestionRemove: $e\n');
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

# **driverQuizQuestionUpdate**
> DriverQuizQuestionCreate201Response driverQuizQuestionUpdate(id, updateDriverQuizQuestion)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizQuestionApi();
final String id = id_example; // String | 
final UpdateDriverQuizQuestion updateDriverQuizQuestion = ; // UpdateDriverQuizQuestion | 

try {
    final response = api.driverQuizQuestionUpdate(id, updateDriverQuizQuestion);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizQuestionApi->driverQuizQuestionUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateDriverQuizQuestion** | [**UpdateDriverQuizQuestion**](UpdateDriverQuizQuestion.md)|  | 

### Return type

[**DriverQuizQuestionCreate201Response**](DriverQuizQuestionCreate201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

