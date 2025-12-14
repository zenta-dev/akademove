# api_client.api.LeaderboardApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**leaderboardGet**](LeaderboardApi.md#leaderboardget) | **GET** /leaderboards/{id} | 
[**leaderboardList**](LeaderboardApi.md#leaderboardlist) | **GET** /leaderboards | 
[**leaderboardMe**](LeaderboardApi.md#leaderboardme) | **GET** /leaderboards/me | 


# **leaderboardGet**
> LeaderboardGet200Response leaderboardGet(id, includeDriver)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLeaderboardApi();
final String id = id_example; // String | 
final bool includeDriver = true; // bool | 

try {
    final response = api.leaderboardGet(id, includeDriver);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LeaderboardApi->leaderboardGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **includeDriver** | **bool**|  | [optional] 

### Return type

[**LeaderboardGet200Response**](LeaderboardGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **leaderboardList**
> LeaderboardList200Response leaderboardList(category, period, limit, cursor, page, sortBy, order, includeDriver)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLeaderboardApi();
final LeaderboardCategory category = ; // LeaderboardCategory | 
final LeaderboardPeriod period = ; // LeaderboardPeriod | 
final int limit = 56; // int | 
final String cursor = cursor_example; // String | 
final int page = 56; // int | 
final String sortBy = sortBy_example; // String | 
final String order = order_example; // String | 
final bool includeDriver = true; // bool | 

try {
    final response = api.leaderboardList(category, period, limit, cursor, page, sortBy, order, includeDriver);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LeaderboardApi->leaderboardList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | [**LeaderboardCategory**](.md)|  | [optional] 
 **period** | [**LeaderboardPeriod**](.md)|  | [optional] 
 **limit** | **int**|  | [optional] 
 **cursor** | **String**|  | [optional] 
 **page** | **int**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | **String**|  | [optional] 
 **includeDriver** | **bool**|  | [optional] 

### Return type

[**LeaderboardList200Response**](LeaderboardList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **leaderboardMe**
> LeaderboardList200Response leaderboardMe(category, period)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getLeaderboardApi();
final LeaderboardCategory category = ; // LeaderboardCategory | 
final LeaderboardPeriod period = ; // LeaderboardPeriod | 

try {
    final response = api.leaderboardMe(category, period);
    print(response);
} catch on DioException (e) {
    print('Exception when calling LeaderboardApi->leaderboardMe: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | [**LeaderboardCategory**](.md)|  | [optional] 
 **period** | [**LeaderboardPeriod**](.md)|  | [optional] 

### Return type

[**LeaderboardList200Response**](LeaderboardList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

