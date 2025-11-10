# api_client.api.PaymentApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**paymentWebhookMidtrans**](PaymentApi.md#paymentwebhookmidtrans) | **POST** /payments/webhook/midtrans | 


# **paymentWebhookMidtrans**
> DriverRemove200Response paymentWebhookMidtrans(body)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentApi();
final Object body = Object; // Object | 

try {
    final response = api.paymentWebhookMidtrans(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PaymentApi->paymentWebhookMidtrans: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **body** | **Object**|  | 

### Return type

[**DriverRemove200Response**](DriverRemove200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

