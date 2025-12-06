# api_client.model.DriverQuizAnswer

## Load the model package
```dart
import 'package:api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**driverId** | **String** |  | 
**status** | [**DriverQuizAnswerStatus**](DriverQuizAnswerStatus.md) |  | 
**totalQuestions** | **int** |  | 
**correctAnswers** | **int** |  | 
**totalPoints** | **int** |  | 
**earnedPoints** | **int** |  | 
**passingScore** | **int** |  | [optional] [default to 70]
**scorePercentage** | **num** |  | 
**answers** | [**List&lt;DriverQuizQuestionAnswer&gt;**](DriverQuizQuestionAnswer.md) |  | 
**startedAt** | [**DateTime**](DateTime.md) |  | 
**completedAt** | [**DateTime**](DateTime.md) |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


