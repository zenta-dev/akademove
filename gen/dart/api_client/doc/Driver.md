# api_client.model.Driver

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**userId** | **String** |  | 
**studentId** | **num** |  | 
**licensePlate** | **String** |  | 
**status** | [**DriverStatus**](DriverStatus.md) |  | 
**quizStatus** | [**DriverQuizStatus**](DriverQuizStatus.md) |  | [optional] [default to DriverQuizStatus.NOT_STARTED]
**quizAttemptId** | **String** |  | [optional] 
**quizScore** | **int** |  | [optional] 
**quizCompletedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**rating** | **num** |  | 
**isTakingOrder** | **bool** |  | 
**isOnline** | **bool** |  | 
**currentLocation** | [**Coordinate**](Coordinate.md) |  | [optional] 
**lastLocationUpdate** | [**DateTime**](DateTime.md) |  | [optional] 
**cancellationCount** | **int** |  | [optional] [default to 0]
**lastCancellationDate** | [**DateTime**](DateTime.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**studentCard** | **String** |  | 
**driverLicense** | **String** |  | 
**vehicleCertificate** | **String** |  | 
**bank** | [**Bank**](Bank.md) |  | 
**user** | [**DriverUser**](DriverUser.md) |  | [optional] 
**distance** | **num** | Each user has different result since it calculated value | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


