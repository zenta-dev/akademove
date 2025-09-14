//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:auth_client/src/date_serializer.dart';
import 'package:auth_client/src/model/date.dart';

import 'package:auth_client/src/model/account.dart';
import 'package:auth_client/src/model/account_info_post200_response.dart';
import 'package:auth_client/src/model/account_info_post200_response_user.dart';
import 'package:auth_client/src/model/account_info_post_request.dart';
import 'package:auth_client/src/model/change_email_post200_response.dart';
import 'package:auth_client/src/model/change_email_post_request.dart';
import 'package:auth_client/src/model/change_password_post200_response.dart';
import 'package:auth_client/src/model/change_password_post_request.dart';
import 'package:auth_client/src/model/delete_user_callback_get200_response.dart';
import 'package:auth_client/src/model/delete_user_post200_response.dart';
import 'package:auth_client/src/model/delete_user_post_request.dart';
import 'package:auth_client/src/model/forget_password_post200_response.dart';
import 'package:auth_client/src/model/forget_password_post_request.dart';
import 'package:auth_client/src/model/get_session_get200_response.dart';
import 'package:auth_client/src/model/link_social_post200_response.dart';
import 'package:auth_client/src/model/link_social_post_request.dart';
import 'package:auth_client/src/model/link_social_post_request_id_token.dart';
import 'package:auth_client/src/model/list_accounts_get200_response_inner.dart';
import 'package:auth_client/src/model/ok_get200_response.dart';
import 'package:auth_client/src/model/refresh_token_post200_response.dart';
import 'package:auth_client/src/model/refresh_token_post_request.dart';
import 'package:auth_client/src/model/reset_password_post200_response.dart';
import 'package:auth_client/src/model/reset_password_post_request.dart';
import 'package:auth_client/src/model/reset_password_token_get200_response.dart';
import 'package:auth_client/src/model/revoke_other_sessions_post200_response.dart';
import 'package:auth_client/src/model/revoke_session_post200_response.dart';
import 'package:auth_client/src/model/revoke_session_post_request.dart';
import 'package:auth_client/src/model/revoke_sessions_post200_response.dart';
import 'package:auth_client/src/model/send_verification_email_post200_response.dart';
import 'package:auth_client/src/model/send_verification_email_post400_response.dart';
import 'package:auth_client/src/model/send_verification_email_post_request.dart';
import 'package:auth_client/src/model/session.dart';
import 'package:auth_client/src/model/sign_in_email_post200_response.dart';
import 'package:auth_client/src/model/sign_in_email_post200_response_user.dart';
import 'package:auth_client/src/model/sign_in_email_post_request.dart';
import 'package:auth_client/src/model/sign_out_post200_response.dart';
import 'package:auth_client/src/model/sign_up_email_post200_response.dart';
import 'package:auth_client/src/model/sign_up_email_post200_response_user.dart';
import 'package:auth_client/src/model/sign_up_email_post_request.dart';
import 'package:auth_client/src/model/social_sign_in200_response.dart';
import 'package:auth_client/src/model/social_sign_in400_response.dart';
import 'package:auth_client/src/model/social_sign_in403_response.dart';
import 'package:auth_client/src/model/social_sign_in_request.dart';
import 'package:auth_client/src/model/social_sign_in_request_id_token.dart';
import 'package:auth_client/src/model/unlink_account_post_request.dart';
import 'package:auth_client/src/model/update_user_post200_response.dart';
import 'package:auth_client/src/model/update_user_post_request.dart';
import 'package:auth_client/src/model/user.dart';
import 'package:auth_client/src/model/verification.dart';
import 'package:auth_client/src/model/verify_email_get200_response.dart';
import 'package:auth_client/src/model/verify_email_get200_response_user.dart';

part 'serializers.g.dart';

@SerializersFor([
  Account,
  AccountInfoPost200Response,
  AccountInfoPost200ResponseUser,
  AccountInfoPostRequest,
  ChangeEmailPost200Response,
  ChangeEmailPostRequest,
  ChangePasswordPost200Response,
  ChangePasswordPostRequest,
  DeleteUserCallbackGet200Response,
  DeleteUserPost200Response,
  DeleteUserPostRequest,
  ForgetPasswordPost200Response,
  ForgetPasswordPostRequest,
  GetSessionGet200Response,
  LinkSocialPost200Response,
  LinkSocialPostRequest,
  LinkSocialPostRequestIdToken,
  ListAccountsGet200ResponseInner,
  OkGet200Response,
  RefreshTokenPost200Response,
  RefreshTokenPostRequest,
  ResetPasswordPost200Response,
  ResetPasswordPostRequest,
  ResetPasswordTokenGet200Response,
  RevokeOtherSessionsPost200Response,
  RevokeSessionPost200Response,
  RevokeSessionPostRequest,
  RevokeSessionsPost200Response,
  SendVerificationEmailPost200Response,
  SendVerificationEmailPost400Response,
  SendVerificationEmailPostRequest,
  Session,
  SignInEmailPost200Response,
  SignInEmailPost200ResponseUser,
  SignInEmailPostRequest,
  SignOutPost200Response,
  SignUpEmailPost200Response,
  SignUpEmailPost200ResponseUser,
  SignUpEmailPostRequest,
  SocialSignIn200Response,
  SocialSignIn400Response,
  SocialSignIn403Response,
  SocialSignInRequest,
  SocialSignInRequestIdToken,
  UnlinkAccountPostRequest,
  UpdateUserPost200Response,
  UpdateUserPostRequest,
  User,
  Verification,
  VerifyEmailGet200Response,
  VerifyEmailGet200ResponseUser,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ListAccountsGet200ResponseInner)]),
        () => ListBuilder<ListAccountsGet200ResponseInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Session)]),
        () => ListBuilder<Session>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
