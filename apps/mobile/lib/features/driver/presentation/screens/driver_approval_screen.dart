import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverApprovalScreen extends StatelessWidget {
  const DriverApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverApprovalCubit, DriverApprovalState>(
      listener: (context, state) {
        if (state.driver.isFailure || state.approvalReview.isFailure) {
          final errorMessage =
              state.driver.error?.message ??
              state.approvalReview.error?.message ??
              context.l10n.an_error_occurred;
          context.showMyToast("Your approval is failed: $errorMessage");
        } else if (state.allDocumentsApproved &&
            state.quizPassed &&
            state.quizVerified) {
          context.showMyToast(
            "Congratulations! Your driver application has been approved.",
          );
          delay(Duration(seconds: 1));
          context.pushReplacementNamed(Routes.driverHome.name);
        }
      },
      builder: (context, state) {
        return Scaffold(
          headers: [
            DefaultAppBar(
              title: context.l10n.pending_approval,
              padding: EdgeInsets.all(16.r),
            ),
          ],
          child: SafeArea(
            child: RefreshTrigger(
              onRefresh: () async {
                context.read<DriverApprovalCubit>().load();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.dg),
                  child: _buildContent(context, state),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, DriverApprovalState state) {
    if (state.driver.isLoading || state.approvalReview.isLoading) {
      return SizedBox(
        height: 400.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (state.driver.isFailure || state.approvalReview.isFailure) {
      return _buildErrorState(context, state);
    }

    final driver = state.driver.data?.value;
    final review = state.approvalReview.data?.value;

    if (driver == null || review == null) {
      return _buildErrorState(context, state);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildStatusHeader(context, state, driver, review),
        SizedBox(height: 24.h),
        _buildRequirementsSection(context, state, driver, review),
        SizedBox(height: 24.h),
        _buildDocumentsSection(context, review),
        SizedBox(height: 24.h),
        _buildQuizSection(context, state, driver),
        Builder(
          builder: (context) {
            final notes = review.reviewNotes;
            if (notes != null && notes.isNotEmpty) {
              return Column(
                children: [
                  SizedBox(height: 24.h),
                  _buildReviewNotesSection(context, review),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, DriverApprovalState state) {
    return SizedBox(
      height: 400.h,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.triangleAlert,
              size: 64.sp,
              color: context.colorScheme.destructive,
            ),
            SizedBox(height: 16.h),
            Text(
              state.driver.error?.message ??
                  state.approvalReview.error?.message ??
                  context.l10n.an_error_occurred,
              style: context.typography.p.copyWith(
                fontSize: 16.sp,
                color: context.colorScheme.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            PrimaryButton(
              onPressed: () => context.read<DriverApprovalCubit>().load(),
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader(
    BuildContext context,
    DriverApprovalState state,
    Driver driver,
    DriverGetReview200ResponseData review,
  ) {
    final statusColor = _getStatusColor(context, review.status);
    final statusIcon = _getStatusIcon(review.status);
    final statusText = _getStatusText(context, review.status);
    final statusDescription = _getStatusDescription(context, state, review);

    return Card(
      child: Column(
        children: [
          Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Icon(statusIcon, size: 40.sp, color: statusColor),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            statusText,
            style: context.typography.h3.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            statusDescription,
            style: context.typography.p.copyWith(
              fontSize: 14.sp,
              color: context.colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementsSection(
    BuildContext context,
    DriverApprovalState state,
    Driver driver,
    DriverGetReview200ResponseData review,
  ) {
    final requirements = [
      _RequirementItem(
        title: 'Documents Verification',
        description: 'All documents must be approved',
        isCompleted: state.allDocumentsApproved,
        hasIssue: state.hasRejectedDocument,
      ),
      _RequirementItem(
        title: context.l10n.driver_knowledge_quiz,
        description: 'Pass the driver knowledge quiz',
        isCompleted: state.quizPassed,
        hasIssue: driver.quizStatus == DriverQuizStatus.FAILED,
      ),
      _RequirementItem(
        title: 'Quiz Verification',
        description: 'Quiz result verified by admin',
        isCompleted: state.quizVerified,
        hasIssue: false,
      ),
    ];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Requirements',
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Complete all requirements to get approved',
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          SizedBox(height: 16.h),
          ...requirements.map((req) => _buildRequirementItem(context, req)),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(BuildContext context, _RequirementItem item) {
    final Color iconColor;
    final IconData icon;

    if (item.isCompleted) {
      iconColor = const Color(0xFF4CAF50);
      icon = LucideIcons.circleCheck;
    } else if (item.hasIssue) {
      iconColor = context.colorScheme.destructive;
      icon = LucideIcons.circleX;
    } else {
      iconColor = const Color(0xFFFF9800);
      icon = LucideIcons.clock;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 24.sp, color: iconColor),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item.description,
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection(
    BuildContext context,
    DriverGetReview200ResponseData review,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documents',
            style: context.typography.h4.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _buildDocumentItem(
            context,
            context.l10n.student_card,
            review.studentCardStatus,
            review.studentCardReason,
          ),
          SizedBox(height: 12.h),
          _buildDocumentItem(
            context,
            context.l10n.driver_license,
            review.driverLicenseStatus,
            review.driverLicenseReason,
          ),
          SizedBox(height: 12.h),
          _buildDocumentItem(
            context,
            context.l10n.vehicle_certificate,
            review.vehicleRegistrationStatus,
            review.vehicleRegistrationReason,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(
    BuildContext context,
    String label,
    Enum status,
    String? reason,
  ) {
    final isApproved = status.name == 'APPROVED';
    final isRejected = status.name == 'REJECTED';
    final isPending = status.name == 'PENDING';

    final Color statusColor;
    final IconData icon;
    final String statusText;

    if (isApproved) {
      statusColor = const Color(0xFF4CAF50);
      icon = LucideIcons.circleCheck;
      statusText = context.l10n.approved;
    } else if (isRejected) {
      statusColor = context.colorScheme.destructive;
      icon = LucideIcons.circleX;
      statusText = context.l10n.rejected;
    } else {
      statusColor = const Color(0xFFFF9800);
      icon = LucideIcons.clock;
      statusText = isPending ? context.l10n.pending_approval : 'Unknown';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20.sp, color: statusColor),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: context.typography.p.copyWith(fontSize: 14.sp),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: statusColor),
              ),
              child: Text(
                statusText,
                style: context.typography.small.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
        if (isRejected && reason != null && reason.isNotEmpty) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: context.colorScheme.destructive.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LucideIcons.info,
                  size: 14.sp,
                  color: context.colorScheme.destructive,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    reason,
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.destructive,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuizSection(
    BuildContext context,
    DriverApprovalState state,
    Driver driver,
  ) {
    final quizStatus = driver.quizStatus;
    final quizScore = driver.quizScore;
    final quizCompletedAt = driver.quizCompletedAt;

    final Color statusColor;
    final IconData icon;
    final String statusText;

    switch (quizStatus) {
      case DriverQuizStatus.PASSED:
        statusColor = const Color(0xFF4CAF50);
        icon = LucideIcons.circleCheck;
        statusText = 'Passed';
      case DriverQuizStatus.FAILED:
        statusColor = context.colorScheme.destructive;
        icon = LucideIcons.circleX;
        statusText = 'Failed';
      case DriverQuizStatus.IN_PROGRESS:
        statusColor = const Color(0xFF2196F3);
        icon = LucideIcons.clock;
        statusText = context.l10n.in_progress;
      case DriverQuizStatus.NOT_STARTED:
      case null:
        statusColor = const Color(0xFFFF9800);
        icon = LucideIcons.circleHelp;
        statusText = 'Not Started';
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.driver_knowledge_quiz,
                  style: context.typography.h4.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: statusColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 14.sp, color: statusColor),
                    SizedBox(width: 4.w),
                    Text(
                      statusText,
                      style: context.typography.small.copyWith(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (quizScore != null) ...[
            Row(
              children: [
                Icon(
                  LucideIcons.trophy,
                  size: 20.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Score: $quizScore%',
                  style: context.typography.p.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
          if (quizCompletedAt != null) ...[
            Row(
              children: [
                Icon(
                  LucideIcons.calendar,
                  size: 20.sp,
                  color: context.colorScheme.mutedForeground,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Completed: ${_formatDate(quizCompletedAt)}',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: context.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
          ],
          if (state.quizVerified) ...[
            Row(
              children: [
                Icon(
                  LucideIcons.badgeCheck,
                  size: 20.sp,
                  color: const Color(0xFF4CAF50),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Verified by admin',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ] else if (quizStatus == DriverQuizStatus.PASSED) ...[
            Row(
              children: [
                Icon(
                  LucideIcons.clock,
                  size: 20.sp,
                  color: const Color(0xFFFF9800),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Awaiting admin verification',
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: const Color(0xFFFF9800),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewNotesSection(
    BuildContext context,
    DriverGetReview200ResponseData review,
  ) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                LucideIcons.messageSquare,
                size: 20.sp,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                'Admin Notes',
                style: context.typography.h4.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: context.colorScheme.muted.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              review.reviewNotes ?? '',
              style: context.typography.p.copyWith(fontSize: 14.sp),
            ),
          ),
          Builder(
            builder: (context) {
              final reviewedAt = review.reviewedAt;
              if (reviewedAt != null) {
                return Column(
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Reviewed on ${_formatDate(reviewedAt)}',
                      style: context.typography.small.copyWith(
                        fontSize: 12.sp,
                        color: context.colorScheme.mutedForeground,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(
    BuildContext context,
    DriverGetReview200ResponseDataStatusEnum status,
  ) {
    switch (status) {
      case DriverGetReview200ResponseDataStatusEnum.PENDING:
        return const Color(0xFFFF9800);
      case DriverGetReview200ResponseDataStatusEnum.APPROVED:
        return const Color(0xFF4CAF50);
      case DriverGetReview200ResponseDataStatusEnum.REJECTED:
        return context.colorScheme.destructive;
    }
  }

  IconData _getStatusIcon(DriverGetReview200ResponseDataStatusEnum status) {
    switch (status) {
      case DriverGetReview200ResponseDataStatusEnum.PENDING:
        return LucideIcons.clock;
      case DriverGetReview200ResponseDataStatusEnum.APPROVED:
        return LucideIcons.circleCheck;
      case DriverGetReview200ResponseDataStatusEnum.REJECTED:
        return LucideIcons.circleX;
    }
  }

  String _getStatusText(
    BuildContext context,
    DriverGetReview200ResponseDataStatusEnum status,
  ) {
    switch (status) {
      case DriverGetReview200ResponseDataStatusEnum.PENDING:
        return context.l10n.pending_approval;
      case DriverGetReview200ResponseDataStatusEnum.APPROVED:
        return context.l10n.approved;
      case DriverGetReview200ResponseDataStatusEnum.REJECTED:
        return context.l10n.rejected;
    }
  }

  String _getStatusDescription(
    BuildContext context,
    DriverApprovalState state,
    DriverGetReview200ResponseData review,
  ) {
    switch (review.status) {
      case DriverGetReview200ResponseDataStatusEnum.PENDING:
        if (state.hasRejectedDocument) {
          return 'Some documents were rejected. Please re-upload the rejected documents.';
        } else if (!state.quizPassed) {
          return 'Please complete and pass the driver knowledge quiz.';
        } else if (!state.quizVerified) {
          return 'Your quiz result is awaiting admin verification.';
        } else if (!state.allDocumentsApproved) {
          return 'Your documents are being reviewed by our team.';
        }
        return 'Your application is being reviewed. This usually takes 1-2 business days.';
      case DriverGetReview200ResponseDataStatusEnum.APPROVED:
        return 'Congratulations! Your driver application has been approved. You can now start accepting orders.';
      case DriverGetReview200ResponseDataStatusEnum.REJECTED:
        return 'Your application was rejected. Please review the feedback and re-apply.';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _RequirementItem {
  const _RequirementItem({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.hasIssue,
  });

  final String title;
  final String description;
  final bool isCompleted;
  final bool hasIssue;
}
