// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(CreateDriverRequest.serializer)
          ..add(CreateDriverSuccessResponse.serializer)
          ..add(CreateDriverSuccessResponseSuccessEnum.serializer)
          ..add(CreateMerchantRequest.serializer)
          ..add(CreateMerchantRequestTypeEnum.serializer)
          ..add(CreateMerchantSuccessResponse.serializer)
          ..add(CreateMerchantSuccessResponseSuccessEnum.serializer)
          ..add(CreateOrderRequest.serializer)
          ..add(CreateOrderRequestNote.serializer)
          ..add(CreateOrderRequestStatusEnum.serializer)
          ..add(CreateOrderRequestTypeEnum.serializer)
          ..add(CreateOrderSuccessResponse.serializer)
          ..add(CreateOrderSuccessResponseSuccessEnum.serializer)
          ..add(CreatePromoRequest.serializer)
          ..add(CreatePromoSuccessResponse.serializer)
          ..add(CreatePromoSuccessResponseSuccessEnum.serializer)
          ..add(CreateReportRequest.serializer)
          ..add(CreateReportRequestCategoryEnum.serializer)
          ..add(CreateReportRequestStatusEnum.serializer)
          ..add(CreateReportSuccessResponse.serializer)
          ..add(CreateReportSuccessResponseSuccessEnum.serializer)
          ..add(CreateReviewRequest.serializer)
          ..add(CreateReviewRequestCategoryEnum.serializer)
          ..add(CreateReviewSuccessResponse.serializer)
          ..add(CreateReviewSuccessResponseSuccessEnum.serializer)
          ..add(CreateScheduleRequest.serializer)
          ..add(CreateScheduleRequestDayOfWeekEnum.serializer)
          ..add(CreateScheduleSuccessResponse.serializer)
          ..add(CreateScheduleSuccessResponseSuccessEnum.serializer)
          ..add(DeleteDriverSuccessResponse.serializer)
          ..add(DeleteDriverSuccessResponseSuccessEnum.serializer)
          ..add(DeleteMerchantSuccessResponse.serializer)
          ..add(DeleteMerchantSuccessResponseSuccessEnum.serializer)
          ..add(DeleteOrderSuccessResponse.serializer)
          ..add(DeleteOrderSuccessResponseSuccessEnum.serializer)
          ..add(DeletePromoSuccessResponse.serializer)
          ..add(DeletePromoSuccessResponseSuccessEnum.serializer)
          ..add(DeleteReportSuccessResponse.serializer)
          ..add(DeleteReportSuccessResponseSuccessEnum.serializer)
          ..add(DeleteReviewSuccessResponse.serializer)
          ..add(DeleteReviewSuccessResponseSuccessEnum.serializer)
          ..add(DeleteScheduleSuccessResponse.serializer)
          ..add(DeleteScheduleSuccessResponseSuccessEnum.serializer)
          ..add(Driver.serializer)
          ..add(DriverStatusEnum.serializer)
          ..add(FailedResponse.serializer)
          ..add(FailedResponseSuccessEnum.serializer)
          ..add(GetAllDriverSuccessResponse.serializer)
          ..add(GetAllDriverSuccessResponseSuccessEnum.serializer)
          ..add(GetAllMerchantSuccessResponse.serializer)
          ..add(GetAllMerchantSuccessResponseSuccessEnum.serializer)
          ..add(GetAllOrderSuccessResponse.serializer)
          ..add(GetAllOrderSuccessResponseSuccessEnum.serializer)
          ..add(GetAllPromoSuccessResponse.serializer)
          ..add(GetAllPromoSuccessResponseSuccessEnum.serializer)
          ..add(GetAllReportSuccessResponse.serializer)
          ..add(GetAllReportSuccessResponseSuccessEnum.serializer)
          ..add(GetAllReviewSuccessResponse.serializer)
          ..add(GetAllReviewSuccessResponseSuccessEnum.serializer)
          ..add(GetAllScheduleSuccessResponse.serializer)
          ..add(GetAllScheduleSuccessResponseSuccessEnum.serializer)
          ..add(GetDriverByIdSuccessResponse.serializer)
          ..add(GetDriverByIdSuccessResponseSuccessEnum.serializer)
          ..add(GetMerchantByIdSuccessResponse.serializer)
          ..add(GetMerchantByIdSuccessResponseSuccessEnum.serializer)
          ..add(GetOrderByIdSuccessResponse.serializer)
          ..add(GetOrderByIdSuccessResponseSuccessEnum.serializer)
          ..add(GetPromoByIdSuccessResponse.serializer)
          ..add(GetPromoByIdSuccessResponseSuccessEnum.serializer)
          ..add(GetReportByIdSuccessResponse.serializer)
          ..add(GetReportByIdSuccessResponseSuccessEnum.serializer)
          ..add(GetReviewByIdSuccessResponse.serializer)
          ..add(GetReviewByIdSuccessResponseSuccessEnum.serializer)
          ..add(GetScheduleByIdSuccessResponse.serializer)
          ..add(GetScheduleByIdSuccessResponseSuccessEnum.serializer)
          ..add(Location.serializer)
          ..add(Merchant.serializer)
          ..add(MerchantTypeEnum.serializer)
          ..add(Order.serializer)
          ..add(OrderStatusEnum.serializer)
          ..add(OrderTypeEnum.serializer)
          ..add(Promo.serializer)
          ..add(Report.serializer)
          ..add(ReportCategoryEnum.serializer)
          ..add(ReportStatusEnum.serializer)
          ..add(Review.serializer)
          ..add(ReviewCategoryEnum.serializer)
          ..add(Schedule.serializer)
          ..add(ScheduleDayOfWeekEnum.serializer)
          ..add(Time.serializer)
          ..add(UpdateDriverRequest.serializer)
          ..add(UpdateDriverRequestStatusEnum.serializer)
          ..add(UpdateDriverSuccessResponse.serializer)
          ..add(UpdateDriverSuccessResponseSuccessEnum.serializer)
          ..add(UpdateMerchantSuccessResponse.serializer)
          ..add(UpdateMerchantSuccessResponseSuccessEnum.serializer)
          ..add(UpdateOrderRequest.serializer)
          ..add(UpdateOrderRequestStatusEnum.serializer)
          ..add(UpdateOrderRequestTypeEnum.serializer)
          ..add(UpdateOrderSuccessResponse.serializer)
          ..add(UpdateOrderSuccessResponseSuccessEnum.serializer)
          ..add(UpdatePromoSuccessResponse.serializer)
          ..add(UpdatePromoSuccessResponseSuccessEnum.serializer)
          ..add(UpdateReportSuccessResponse.serializer)
          ..add(UpdateReportSuccessResponseSuccessEnum.serializer)
          ..add(UpdateReviewSuccessResponse.serializer)
          ..add(UpdateReviewSuccessResponseSuccessEnum.serializer)
          ..add(UpdateScheduleRequest.serializer)
          ..add(UpdateScheduleRequestDayOfWeekEnum.serializer)
          ..add(UpdateScheduleSuccessResponse.serializer)
          ..add(UpdateScheduleSuccessResponseSuccessEnum.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Driver)]),
            () => ListBuilder<Driver>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Merchant)]),
            () => ListBuilder<Merchant>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Order)]),
            () => ListBuilder<Order>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Promo)]),
            () => ListBuilder<Promo>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Report)]),
            () => ListBuilder<Report>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Review)]),
            () => ListBuilder<Review>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Schedule)]),
            () => ListBuilder<Schedule>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
