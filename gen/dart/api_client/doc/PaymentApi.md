# api_client.api.PaymentApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**bankValidateAccount**](PaymentApi.md#bankvalidateaccount) | **POST** /bank/validate | 
[**paymentWebhookMidtrans**](PaymentApi.md#paymentwebhookmidtrans) | **POST** /payments/webhook/midtrans | 
[**paymentWebhookMidtransPayout**](PaymentApi.md#paymentwebhookmidtranspayout) | **POST** /payments/webhook/midtrans/payout | Midtrans Iris Payout Webhook


# **bankValidateAccount**
> BankValidateAccount200Response bankValidateAccount(bankValidationRequest)



Validate a bank account using Midtrans Iris API. Returns account holder name if valid.

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentApi();
final BankValidationRequest bankValidationRequest = ; // BankValidationRequest | 

try {
    final response = api.bankValidateAccount(bankValidationRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PaymentApi->bankValidateAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bankValidationRequest** | [**BankValidationRequest**](BankValidationRequest.md)|  | 

### Return type

[**BankValidateAccount200Response**](BankValidateAccount200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

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

# **paymentWebhookMidtransPayout**
> BadgeRemove200Response paymentWebhookMidtransPayout(requestBody)

Midtrans Iris Payout Webhook

Webhook endpoint for Midtrans Iris payout/disbursement status updates

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getPaymentApi();
final Map<String, Object> requestBody = Object; // Map<String, Object> | 

try {
    final response = api.paymentWebhookMidtransPayout(requestBody);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PaymentApi->paymentWebhookMidtransPayout: $e\n');
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

