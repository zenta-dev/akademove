# api_client.model.WithdrawResponse

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**transactionId** | **String** |  | 
**provider** | [**PaymentProvider**](PaymentProvider.md) |  | 
**method** | [**PaymentMethod**](PaymentMethod.md) |  | 
**amount** | **num** |  | 
**status** | [**TransactionStatus**](TransactionStatus.md) |  | 
**bankProvider** | [**BankProvider**](BankProvider.md) |  | 
**payoutReferenceNo** | **String** |  | [optional] 
**payoutStatus** | [**PayoutStatus**](PayoutStatus.md) |  | [optional] 
**metadata** | **Map&lt;String, Object&gt;** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


