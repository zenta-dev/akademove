# api_client.api.WalletApi

## Load the API package
```dart
import 'package:api_client/api.dart';
```

All URIs are relative to *http://localhost:3000/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**driverWalletGetMonthlySummary**](WalletApi.md#driverwalletgetmonthlysummary) | **GET** /drivers/{driverId}/wallet/summary | 
[**driverWalletGetSavedBankAccount**](WalletApi.md#driverwalletgetsavedbankaccount) | **GET** /drivers/{driverId}/wallet/bank | 
[**driverWalletGetTransactions**](WalletApi.md#driverwalletgettransactions) | **GET** /drivers/{driverId}/wallet/transactions | 
[**driverWalletGetWallet**](WalletApi.md#driverwalletgetwallet) | **GET** /drivers/{driverId}/wallet | 
[**driverWalletTopUp**](WalletApi.md#driverwallettopup) | **POST** /drivers/{driverId}/wallet/topup | 
[**driverWalletTransfer**](WalletApi.md#driverwallettransfer) | **POST** /drivers/{driverId}/wallet/transfer | 
[**driverWalletWithdraw**](WalletApi.md#driverwalletwithdraw) | **POST** /drivers/{driverId}/wallet/withdraw | 
[**merchantWalletGetMonthlySummary**](WalletApi.md#merchantwalletgetmonthlysummary) | **GET** /merchants/{merchantId}/wallet/summary | 
[**merchantWalletGetSavedBankAccount**](WalletApi.md#merchantwalletgetsavedbankaccount) | **GET** /merchants/{merchantId}/wallet/bank | 
[**merchantWalletGetTransactions**](WalletApi.md#merchantwalletgettransactions) | **GET** /merchants/{merchantId}/wallet/transactions | 
[**merchantWalletGetWallet**](WalletApi.md#merchantwalletgetwallet) | **GET** /merchants/{merchantId}/wallet | 
[**merchantWalletTopUp**](WalletApi.md#merchantwallettopup) | **POST** /merchants/{merchantId}/wallet/topup | 
[**merchantWalletTransfer**](WalletApi.md#merchantwallettransfer) | **POST** /merchants/{merchantId}/wallet/transfer | 
[**merchantWalletWithdraw**](WalletApi.md#merchantwalletwithdraw) | **POST** /merchants/{merchantId}/wallet/withdraw | 
[**walletGet**](WalletApi.md#walletget) | **GET** /wallets | 
[**walletGetCommissionReport**](WalletApi.md#walletgetcommissionreport) | **GET** /wallets/commission-report | 
[**walletGetMonthlySummary**](WalletApi.md#walletgetmonthlysummary) | **GET** /wallets/summary | 
[**walletGetSavedBankAccount**](WalletApi.md#walletgetsavedbankaccount) | **GET** /wallets/bank | 
[**walletPay**](WalletApi.md#walletpay) | **POST** /wallets/pay | 
[**walletTopUp**](WalletApi.md#wallettopup) | **POST** /wallets/topup | 
[**walletTransfer**](WalletApi.md#wallettransfer) | **POST** /wallets/transfer | 
[**walletWithdraw**](WalletApi.md#walletwithdraw) | **POST** /wallets/withdraw | 


# **driverWalletGetMonthlySummary**
> DriverWalletGetMonthlySummary200Response driverWalletGetMonthlySummary(driverId, year, month)



Get driver wallet monthly summary

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 
final num year = 8.14; // num | 
final num month = 8.14; // num | 

try {
    final response = api.driverWalletGetMonthlySummary(driverId, year, month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletGetMonthlySummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **year** | **num**|  | 
 **month** | **num**|  | 

### Return type

[**DriverWalletGetMonthlySummary200Response**](DriverWalletGetMonthlySummary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverWalletGetSavedBankAccount**
> DriverWalletGetSavedBankAccount200Response driverWalletGetSavedBankAccount(driverId)



Get saved bank account details from driver profile for pre-filling withdrawal forms

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 

try {
    final response = api.driverWalletGetSavedBankAccount(driverId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletGetSavedBankAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 

### Return type

[**DriverWalletGetSavedBankAccount200Response**](DriverWalletGetSavedBankAccount200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverWalletGetTransactions**
> DriverWalletGetTransactions200Response driverWalletGetTransactions(driverId, cursor, limit, direction, page, query, sortBy, order, mode)



Get driver wallet transactions

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.driverWalletGetTransactions(driverId, cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletGetTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**DriverWalletGetTransactions200Response**](DriverWalletGetTransactions200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverWalletGetWallet**
> DriverWalletGetWallet200Response driverWalletGetWallet(driverId)



Get driver wallet by driver ID

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 

try {
    final response = api.driverWalletGetWallet(driverId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletGetWallet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 

### Return type

[**DriverWalletGetWallet200Response**](DriverWalletGetWallet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverWalletTopUp**
> DriverWalletTopUp200Response driverWalletTopUp(driverId, topUpRequest)



Top up driver wallet

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 
final TopUpRequest topUpRequest = ; // TopUpRequest | 

try {
    final response = api.driverWalletTopUp(driverId, topUpRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletTopUp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **topUpRequest** | [**TopUpRequest**](TopUpRequest.md)|  | 

### Return type

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverWalletTransfer**
> DriverWalletTransfer200Response driverWalletTransfer(driverId, transferRequest)



Transfer from driver wallet to another user

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 
final TransferRequest transferRequest = ; // TransferRequest | 

try {
    final response = api.driverWalletTransfer(driverId, transferRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletTransfer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **transferRequest** | [**TransferRequest**](TransferRequest.md)|  | 

### Return type

[**DriverWalletTransfer200Response**](DriverWalletTransfer200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **driverWalletWithdraw**
> DriverWalletTopUp200Response driverWalletWithdraw(driverId, withdrawRequest)



Withdraw from driver wallet to bank account

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String driverId = driverId_example; // String | 
final WithdrawRequest withdrawRequest = ; // WithdrawRequest | 

try {
    final response = api.driverWalletWithdraw(driverId, withdrawRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->driverWalletWithdraw: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **driverId** | **String**|  | 
 **withdrawRequest** | [**WithdrawRequest**](WithdrawRequest.md)|  | 

### Return type

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletGetMonthlySummary**
> DriverWalletGetMonthlySummary200Response merchantWalletGetMonthlySummary(merchantId, year, month)



Get merchant wallet monthly summary

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 
final num year = 8.14; // num | 
final num month = 8.14; // num | 

try {
    final response = api.merchantWalletGetMonthlySummary(merchantId, year, month);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletGetMonthlySummary: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **year** | **num**|  | 
 **month** | **num**|  | 

### Return type

[**DriverWalletGetMonthlySummary200Response**](DriverWalletGetMonthlySummary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletGetSavedBankAccount**
> DriverWalletGetSavedBankAccount200Response merchantWalletGetSavedBankAccount(merchantId)



Get saved bank account details from merchant profile for pre-filling withdrawal forms

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 

try {
    final response = api.merchantWalletGetSavedBankAccount(merchantId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletGetSavedBankAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 

### Return type

[**DriverWalletGetSavedBankAccount200Response**](DriverWalletGetSavedBankAccount200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletGetTransactions**
> DriverWalletGetTransactions200Response merchantWalletGetTransactions(merchantId, cursor, limit, direction, page, query, sortBy, order, mode)



Get merchant wallet transactions

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 
final String cursor = cursor_example; // String | 
final Object limit = ; // Object | 
final String direction = direction_example; // String | 
final Object page = ; // Object | 
final String query = query_example; // String | 
final String sortBy = sortBy_example; // String | 
final PaginationOrder order = ; // PaginationOrder | 
final PaginationMode mode = ; // PaginationMode | 

try {
    final response = api.merchantWalletGetTransactions(merchantId, cursor, limit, direction, page, query, sortBy, order, mode);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletGetTransactions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **cursor** | **String**|  | [optional] 
 **limit** | [**Object**](.md)|  | [optional] 
 **direction** | **String**|  | [optional] 
 **page** | [**Object**](.md)|  | [optional] 
 **query** | **String**|  | [optional] 
 **sortBy** | **String**|  | [optional] 
 **order** | [**PaginationOrder**](.md)|  | [optional] [default to desc]
 **mode** | [**PaginationMode**](.md)|  | [optional] [default to offset]

### Return type

[**DriverWalletGetTransactions200Response**](DriverWalletGetTransactions200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletGetWallet**
> DriverWalletGetWallet200Response merchantWalletGetWallet(merchantId)



Get merchant wallet by merchant ID

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 

try {
    final response = api.merchantWalletGetWallet(merchantId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletGetWallet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 

### Return type

[**DriverWalletGetWallet200Response**](DriverWalletGetWallet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletTopUp**
> DriverWalletTopUp200Response merchantWalletTopUp(merchantId, topUpRequest)



Top up merchant wallet

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 
final TopUpRequest topUpRequest = ; // TopUpRequest | 

try {
    final response = api.merchantWalletTopUp(merchantId, topUpRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletTopUp: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **topUpRequest** | [**TopUpRequest**](TopUpRequest.md)|  | 

### Return type

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletTransfer**
> DriverWalletTransfer200Response merchantWalletTransfer(merchantId, transferRequest)



Transfer from merchant wallet to another user

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 
final TransferRequest transferRequest = ; // TransferRequest | 

try {
    final response = api.merchantWalletTransfer(merchantId, transferRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletTransfer: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **transferRequest** | [**TransferRequest**](TransferRequest.md)|  | 

### Return type

[**DriverWalletTransfer200Response**](DriverWalletTransfer200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **merchantWalletWithdraw**
> DriverWalletTopUp200Response merchantWalletWithdraw(merchantId, withdrawRequest)



Withdraw from merchant wallet to bank account

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final String merchantId = merchantId_example; // String | 
final WithdrawRequest withdrawRequest = ; // WithdrawRequest | 

try {
    final response = api.merchantWalletWithdraw(merchantId, withdrawRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->merchantWalletWithdraw: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **merchantId** | **String**|  | 
 **withdrawRequest** | [**WithdrawRequest**](WithdrawRequest.md)|  | 

### Return type

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletGet**
> DriverWalletGetWallet200Response walletGet()



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

[**DriverWalletGetWallet200Response**](DriverWalletGetWallet200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletGetCommissionReport**
> WalletGetCommissionReport200Response walletGetCommissionReport(period, startDate, endDate)



Get commission report for drivers with balance summary, chart data, and transaction history

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final CommissionReportPeriod period = ; // CommissionReportPeriod | 
final DateTime startDate = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime endDate = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.walletGetCommissionReport(period, startDate, endDate);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletGetCommissionReport: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **period** | [**CommissionReportPeriod**](.md)|  | [optional] [default to daily]
 **startDate** | **DateTime**|  | [optional] 
 **endDate** | **DateTime**|  | [optional] 

### Return type

[**WalletGetCommissionReport200Response**](WalletGetCommissionReport200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletGetMonthlySummary**
> DriverWalletGetMonthlySummary200Response walletGetMonthlySummary(year, month)



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

[**DriverWalletGetMonthlySummary200Response**](DriverWalletGetMonthlySummary200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletGetSavedBankAccount**
> DriverWalletGetSavedBankAccount200Response walletGetSavedBankAccount()



Get saved bank account details from driver/merchant profile for pre-filling withdrawal forms

### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();

try {
    final response = api.walletGetSavedBankAccount();
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletGetSavedBankAccount: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**DriverWalletGetSavedBankAccount200Response**](DriverWalletGetSavedBankAccount200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletPay**
> DriverWalletTopUp200Response walletPay(payRequest)



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

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletTopUp**
> DriverWalletTopUp200Response walletTopUp(topUpRequest)



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

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletTransfer**
> DriverWalletTransfer200Response walletTransfer(transferRequest)



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

[**DriverWalletTransfer200Response**](DriverWalletTransfer200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **walletWithdraw**
> DriverWalletTopUp200Response walletWithdraw(withdrawRequest)



### Example
```dart
import 'package:api_client/api.dart';

final api = ApiClient().getWalletApi();
final WithdrawRequest withdrawRequest = ; // WithdrawRequest | 

try {
    final response = api.walletWithdraw(withdrawRequest);
    print(response);
} catch on DioException (e) {
    print('Exception when calling WalletApi->walletWithdraw: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **withdrawRequest** | [**WithdrawRequest**](WithdrawRequest.md)|  | 

### Return type

[**DriverWalletTopUp200Response**](DriverWalletTopUp200Response.md)

### Authorization

[bearer_auth](../README.md#bearer_auth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

