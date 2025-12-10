// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '_export.dart';

class DriverApprovalState extends Equatable {
  const DriverApprovalState({
    this.driver = const OperationResult.idle(),
    this.approvalReview = const OperationResult.idle(),
  });

  final OperationResult<Driver> driver;
  final OperationResult<DriverGetReview200ResponseData> approvalReview;

  @override
  List<Object> get props => [driver, approvalReview];

  @override
  bool get stringify => true;

  DriverApprovalState copyWith({
    OperationResult<Driver>? driver,
    OperationResult<DriverGetReview200ResponseData>? approvalReview,
  }) {
    return DriverApprovalState(
      driver: driver ?? this.driver,
      approvalReview: approvalReview ?? this.approvalReview,
    );
  }

  /// Check if all documents are approved
  bool get allDocumentsApproved {
    final review = approvalReview.data?.value;
    if (review == null) return false;
    return review.studentCardStatus ==
            DriverGetReview200ResponseDataStudentCardStatusEnum.APPROVED &&
        review.driverLicenseStatus ==
            DriverGetReview200ResponseDataDriverLicenseStatusEnum.APPROVED &&
        review.vehicleRegistrationStatus ==
            DriverGetReview200ResponseDataVehicleRegistrationStatusEnum
                .APPROVED;
  }

  /// Check if any document is rejected
  bool get hasRejectedDocument {
    final review = approvalReview.data?.value;
    if (review == null) return false;
    return review.studentCardStatus ==
            DriverGetReview200ResponseDataStudentCardStatusEnum.REJECTED ||
        review.driverLicenseStatus ==
            DriverGetReview200ResponseDataDriverLicenseStatusEnum.REJECTED ||
        review.vehicleRegistrationStatus ==
            DriverGetReview200ResponseDataVehicleRegistrationStatusEnum
                .REJECTED;
  }

  /// Check if quiz is passed
  bool get quizPassed {
    final d = driver.data?.value;
    if (d == null) return false;
    return d.quizStatus == DriverQuizStatus.PASSED;
  }

  /// Check if quiz is verified by admin
  bool get quizVerified => approvalReview.data?.value.quizVerified ?? false;

  /// Check if driver application is approved
  bool get isApproved {
    final review = approvalReview.data?.value;
    return review?.status == DriverGetReview200ResponseDataStatusEnum.APPROVED;
  }

  /// Check if driver application is rejected
  bool get isRejected {
    final review = approvalReview.data?.value;
    return review?.status == DriverGetReview200ResponseDataStatusEnum.REJECTED;
  }

  /// Check if driver application is pending
  bool get isPending {
    final review = approvalReview.data?.value;
    return review?.status == DriverGetReview200ResponseDataStatusEnum.PENDING;
  }

  /// Get driver status
  DriverStatus? get driverStatus => driver.data?.value.status;

  /// Check if driver can be activated (all requirements met)
  bool get canBeActivated => allDocumentsApproved && quizPassed && quizVerified;
}
