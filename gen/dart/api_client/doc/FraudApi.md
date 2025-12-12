# api_client.api.FraudApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**fraudGetEvent**](FraudApi.md#fraudgetevent) | **GET** /fraud/events/{id} | 
[**fraudGetStats**](FraudApi.md#fraudgetstats) | **GET** /fraud/stats | 
[**fraudGetUserEvents**](FraudApi.md#fraudgetuserevents) | **GET** /fraud/users/{userId}/events | 
[**fraudGetUserProfile**](FraudApi.md#fraudgetuserprofile) | **GET** /fraud/users/{userId}/profile | 
[**fraudListEvents**](FraudApi.md#fraudlistevents) | **GET** /fraud/events | 
[**fraudListHighRiskUsers**](FraudApi.md#fraudlisthighriskusers) | **GET** /fraud/users/high-risk | 
[**fraudReviewEvent**](FraudApi.md#fraudreviewevent) | **POST** /fraud/events/{id}/review | 


# **fraudGetEvent**
> FraudGetEvent200Response fraudGetEvent(id)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 

try {
    final response = api.fraudGetEvent(id);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudGetEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**FraudGetEvent200Response**](FraudGetEvent200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fraudGetStats**
> FraudGetStats200Response fraudGetStats(startDate, endDate, trendDays)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final int trendDays = 56; // int | 

try {
    final response = api.fraudGetStats(startDate, endDate, trendDays);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudGetStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 
 **trendDays** | **int**|  | [optional] 

### Return type

[**FraudGetStats200Response**](FraudGetStats200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fraudGetUserEvents**
> FraudListEvents200Response fraudGetUserEvents(userId, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final String userId = userId_example; // String | 
final int page = 56; // int | 
final int limit = 56; // int | 

try {
    final response = api.fraudGetUserEvents(userId, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudGetUserEvents: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

[**FraudListEvents200Response**](FraudListEvents200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fraudGetUserProfile**
> FraudGetUserProfile200Response fraudGetUserProfile(userId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final String userId = userId_example; // String | 

try {
    final response = api.fraudGetUserProfile(userId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudGetUserProfile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String**|  | 

### Return type

[**FraudGetUserProfile200Response**](FraudGetUserProfile200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fraudListEvents**
> FraudListEvents200Response fraudListEvents(page, limit, status, severity, eventType, userId, driverId, startDate, endDate, sortBy, order)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final Object page = ; // Object | 
final Object limit = ; // Object | 
final FraudStatus status = ; // FraudStatus | 
final FraudSeverity severity = ; // FraudSeverity | 
final FraudEventType eventType = ; // FraudEventType | 
final String userId = userId_example; // String | 
final String driverId = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 

try {
    final response = api.fraudListEvents(page, limit, status, severity, eventType, userId, driverId, startDate, endDate, sortBy, order);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudListEvents: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | [**Object**](.md)|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **status** | [**FraudStatus**](.md)|  | [optional] 
 **severity** | [**FraudSeverity**](.md)|  | [optional] 
 **eventType** | [**FraudEventType**](.md)|  | [optional] 
 **userId** | **String**|  | [optional] 
 **driverId** | **String**|  | [optional] 
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] 

### Return type

[**FraudListEvents200Response**](FraudListEvents200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fraudListHighRiskUsers**
> FraudListHighRiskUsers200Response fraudListHighRiskUsers(page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final int page = 56; // int | 
final int limit = 56; // int | 

try {
    final response = api.fraudListHighRiskUsers(page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudListHighRiskUsers: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

[**FraudListHighRiskUsers200Response**](FraudListHighRiskUsers200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **fraudReviewEvent**
> FraudGetEvent200Response fraudReviewEvent(id, reviewFraudEvent)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getFraudApi();
final String id = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | 
final ReviewFraudEvent reviewFraudEvent = ; // ReviewFraudEvent | 

try {
    final response = api.fraudReviewEvent(id, reviewFraudEvent);
    print(response);
} catch on DioException (e) {
    print('Exception when calling FraudApi->fraudReviewEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **reviewFraudEvent** | [**ReviewFraudEvent**](ReviewFraudEvent.md)|  | 

### Return type

[**FraudGetEvent200Response**](FraudGetEvent200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

