# api_client.api.WalletApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**walletGet**](WalletApi.md#walletget) | **GET** /wallets | 
[**walletGetMonthlySummary**](WalletApi.md#walletgetmonthlysummary) | **GET** /wallets/summary | 
[**walletPay**](WalletApi.md#walletpay) | **POST** /wallets/pay | 
[**walletTopUp**](WalletApi.md#wallettopup) | **POST** /wallets/topup | 
[**walletTransactions**](WalletApi.md#wallettransactions) | **GET** /wallets/transactions | 
[**walletTransfer**](WalletApi.md#wallettransfer) | **POST** /wallets/transfer | 
[**walletWebhookMidtrans**](WalletApi.md#walletwebhookmidtrans) | **POST** /wallets/webhook/midtrans | 


# **walletGet**
> WalletGet200Response walletGet()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();

try {
    final response = api.walletGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**WalletGet200Response**](WalletGet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletGetMonthlySummary**
> WalletGetMonthlySummary200Response walletGetMonthlySummary(year, month)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final num year = 8.14; // num | 
final num month = 8.14; // num | 

try {
    final response = api.walletGetMonthlySummary(year, month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletGetMonthlySummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **year** | **num**|  | 
 **month** | **num**|  | 

### Return type

[**WalletGetMonthlySummary200Response**](WalletGetMonthlySummary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletPay**
> WalletTopUp200Response walletPay(payRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final PayRequest payRequest = ; // PayRequest | 

try {
    final response = api.walletPay(payRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletPay: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payRequest** | [**PayRequest**](PayRequest.md)|  | 

### Return type

[**WalletTopUp200Response**](WalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletTopUp**
> WalletTopUp200Response walletTopUp(topUpRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final TopUpRequest topUpRequest = ; // TopUpRequest | 

try {
    final response = api.walletTopUp(topUpRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletTopUp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **topUpRequest** | [**TopUpRequest**](TopUpRequest.md)|  | 

### Return type

[**WalletTopUp200Response**](WalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletTransactions**
> WalletTransactions200Response walletTransactions()



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();

try {
    final response = api.walletTransactions();
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletTransactions: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**WalletTransactions200Response**](WalletTransactions200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletTransfer**
> WalletTopUp200Response walletTransfer(transferRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final TransferRequest transferRequest = ; // TransferRequest | 

try {
    final response = api.walletTransfer(transferRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletTransfer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **transferRequest** | [**TransferRequest**](TransferRequest.md)|  | 

### Return type

[**WalletTopUp200Response**](WalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletWebhookMidtrans**
> DriverRemove200Response walletWebhookMidtrans(body)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final Object body = Object; // Object | 

try {
    final response = api.walletWebhookMidtrans(body);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletWebhookMidtrans: $e\n');
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

