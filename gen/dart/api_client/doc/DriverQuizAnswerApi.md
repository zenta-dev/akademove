# api_client.api.DriverQuizAnswerApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driverQuizAnswerCompleteQuiz**](DriverQuizAnswerApi.md#driverquizanswercompletequiz) | **POST** /driver-quiz-answers/complete | 
[**driverQuizAnswerGetAttempt**](DriverQuizAnswerApi.md#driverquizanswergetattempt) | **GET** /driver-quiz-answers/{attemptId} | 
[**driverQuizAnswerGetMyLatestAttempt**](DriverQuizAnswerApi.md#driverquizanswergetmylatestattempt) | **GET** /driver-quiz-answers/me/latest | 
[**driverQuizAnswerGetResult**](DriverQuizAnswerApi.md#driverquizanswergetresult) | **GET** /driver-quiz-answers/{attemptId}/result | 
[**driverQuizAnswerList**](DriverQuizAnswerApi.md#driverquizanswerlist) | **GET** /driver-quiz-answers | 
[**driverQuizAnswerStartQuiz**](DriverQuizAnswerApi.md#driverquizanswerstartquiz) | **POST** /driver-quiz-answers/start | 
[**driverQuizAnswerSubmitAnswer**](DriverQuizAnswerApi.md#driverquizanswersubmitanswer) | **POST** /driver-quiz-answers/answer | 


# **driverQuizAnswerCompleteQuiz**
> DriverQuizAnswerCompleteQuiz200Response driverQuizAnswerCompleteQuiz(completeDriverQuiz)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();
final CompleteDriverQuiz completeDriverQuiz = ; // CompleteDriverQuiz | 

try {
    final response = api.driverQuizAnswerCompleteQuiz(completeDriverQuiz);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerCompleteQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **completeDriverQuiz** | [**CompleteDriverQuiz**](CompleteDriverQuiz.md)|  | 

### Return type

[**DriverQuizAnswerCompleteQuiz200Response**](DriverQuizAnswerCompleteQuiz200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizAnswerGetAttempt**
> DriverQuizAnswerGetAttempt200Response driverQuizAnswerGetAttempt(attemptId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();
final String attemptId = attemptId_example; // String | 

try {
    final response = api.driverQuizAnswerGetAttempt(attemptId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerGetAttempt: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **attemptId** | **String**|  | 

### Return type

[**DriverQuizAnswerGetAttempt200Response**](DriverQuizAnswerGetAttempt200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizAnswerGetMyLatestAttempt**
> DriverQuizAnswerGetAttempt200Response driverQuizAnswerGetMyLatestAttempt()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();

try {
    final response = api.driverQuizAnswerGetMyLatestAttempt();
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerGetMyLatestAttempt: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DriverQuizAnswerGetAttempt200Response**](DriverQuizAnswerGetAttempt200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizAnswerGetResult**
> DriverQuizAnswerCompleteQuiz200Response driverQuizAnswerGetResult(attemptId)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();
final String attemptId = attemptId_example; // String | 

try {
    final response = api.driverQuizAnswerGetResult(attemptId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerGetResult: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **attemptId** | **String**|  | 

### Return type

[**DriverQuizAnswerCompleteQuiz200Response**](DriverQuizAnswerCompleteQuiz200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizAnswerList**
> DriverQuizAnswerList200Response driverQuizAnswerList(driverId, status, page, limit)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();
final String driverId = driverId_example; // String | 
final DriverQuizAnswerStatus status = ; // DriverQuizAnswerStatus | 
final int page = 56; // int | 
final int limit = 56; // int | 

try {
    final response = api.driverQuizAnswerList(driverId, status, page, limit);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerList: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | [optional] 
 **status** | [**DriverQuizAnswerStatus**](.md)|  | [optional] 
 **page** | **int**|  | [optional] 
 **limit** | **int**|  | [optional] 

### Return type

[**DriverQuizAnswerList200Response**](DriverQuizAnswerList200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizAnswerStartQuiz**
> DriverQuizAnswerStartQuiz201Response driverQuizAnswerStartQuiz(startDriverQuiz)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();
final StartDriverQuiz startDriverQuiz = ; // StartDriverQuiz | 

try {
    final response = api.driverQuizAnswerStartQuiz(startDriverQuiz);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerStartQuiz: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **startDriverQuiz** | [**StartDriverQuiz**](StartDriverQuiz.md)|  | 

### Return type

[**DriverQuizAnswerStartQuiz201Response**](DriverQuizAnswerStartQuiz201Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverQuizAnswerSubmitAnswer**
> DriverQuizAnswerSubmitAnswer200Response driverQuizAnswerSubmitAnswer(submitDriverQuizAnswer)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getDriverQuizAnswerApi();
final SubmitDriverQuizAnswer submitDriverQuizAnswer = ; // SubmitDriverQuizAnswer | 

try {
    final response = api.driverQuizAnswerSubmitAnswer(submitDriverQuizAnswer);
    print(response);
} catch on DioException (e) {
    print('Exception when calling DriverQuizAnswerApi->driverQuizAnswerSubmitAnswer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **submitDriverQuizAnswer** | [**SubmitDriverQuizAnswer**](SubmitDriverQuizAnswer.md)|  | 

### Return type

[**DriverQuizAnswerSubmitAnswer200Response**](DriverQuizAnswerSubmitAnswer200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

