# api_client.api.PaymentApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://10.86.19.105:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**paymentWebhookMidtrans**](PaymentApi.md#paymentwebhookmidtrans) | **POST** /payments/webhook/midtrans | 


# **paymentWebhookMidtrans**
> BadgeRemove200Response paymentWebhookMidtrans(requestBody)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentApi();
final Map<String, Object> requestBody = Object; // Map<String, Object> | 

try {
    final response = api.paymentWebhookMidtrans(requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PaymentApi->paymentWebhookMidtrans: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **requestBody** | [**Map&lt;String, Object&gt;**](Object.md)|  | 

### Return type

[**BadgeRemove200Response**](BadgeRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

