import 'dart:developer';
import 'package:akademove/core/errors.dart';
import 'package:akademove/core/services/kv_service.dart';
import 'package:akademove/features/user/domain/entities/user_entity.dart';
import 'package:api_client/api_client.dart' as api;
import 'package:auth_client/auth_client.dart' as auth;
import 'package:dio/dio.dart';

class AuthRepository {
  const AuthRepository({
    required this.authClient,
    required this.apiClient,
    required this.localKV,
  });

  final auth.AuthClient authClient;
  final api.ApiClient apiClient;
  final KeyValueService localKV;

  Future<UserEntity> signIn(auth.SignInEmailPostRequest request) async {
    return _guard(() async {
      request.rebuild((v) => v.rememberMe = true);
      log(request.toString());

      final result = await authClient.getDefaultApi().signInEmailPost(
        signInEmailPostRequest: request,
      );

      final data = result.data ?? (throw RepositoryError('User not found', []));

      authClient.setBearerAuth('bearerAuth', data.token);
      apiClient.setBearerAuth('bearer_auth', data.token);
      await localKV.set(KeyValueKeys.token, data.token);

      return _mapToUser(
        id: data.user.id,
        name: data.user.name ?? 'Folks',
        email: data.user.email,
        emailVerified: data.user.emailVerified,
        image: data.user.image,
        createdAt: data.user.createdAt,
        updatedAt: data.user.updatedAt,
      );
    });
  }

  Future<UserEntity> authenticate() async {
    return _guard(() async {
      final token = await localKV.get<String>(KeyValueKeys.token);
      log(
        'TOKEN :$token',
      );
      if (token != null) {
        authClient.setBearerAuth('bearerAuth', token);
        apiClient.setBearerAuth('bearer_auth', token);
      }
      final result = await authClient.getDefaultApi().getSessionGet();

      final data = result.data ?? (throw RepositoryError('User not found', []));

      return _mapToUser(
        id: data.user.id ?? '',
        name: data.user.name,
        email: data.user.email,
        emailVerified: data.user.emailVerified,
        image: data.user.image,
        createdAt: data.user.createdAt,
        updatedAt: data.user.updatedAt,
      );
    });
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      log(e.toString());
      throw RepositoryError('Invalid credentials', [e]);
    } on RepositoryError {
      rethrow;
      // ignore: avoid_catches_without_on_clauses wildcard
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw RepositoryError('Internal server error', []);
    }
  }

  UserEntity _mapToUser({
    required String id,
    required String? name,
    required String email,
    required bool emailVerified,
    required String? image,
    required dynamic createdAt,
    required dynamic updatedAt,
  }) {
    return UserEntity(
      id: id,
      name: name ?? 'Folks',
      email: email,
      emailVerified: emailVerified,
      image: image,
      role: null,
      banned: null,
      banReason: null,
      banExpires: null,
      createdAt: _normalizeDate(createdAt),
      updatedAt: _normalizeDate(updatedAt),
    );
  }

  DateTime _normalizeDate(dynamic value) {
    if (value is DateTime) return value;
    if (value is String) return DateTime.parse(value);
    throw RepositoryError('Invalid date format', []);
  }
}
