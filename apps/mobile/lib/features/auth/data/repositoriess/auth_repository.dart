import 'package:akademove/core/errors.dart';
import 'package:akademove/features/user/domain/entities/user_entity.dart';
import 'package:auth_client/auth_client.dart' as auth;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  const AuthRepository(this.remote);
  final auth.DefaultApi remote;

  Future<UserEntity> signIn(auth.SignInEmailPostRequest request) async {
    try {
      request.rebuild((v) => v.rememberMe = true);
      final result = await remote.signInEmailPost(
        signInEmailPostRequest: request,
      );
      final data = result.data;
      if (data == null) throw RepositoryError('User not found', []);
      final user = UserEntity(
        id: data.user.id,
        name: data.user.name ?? 'Folks',
        email: data.user.email,
        emailVerified: data.user.emailVerified,
        image: data.user.image,
        role: null,
        banned: null,
        banReason: null,
        banExpires: null,
        createdAt: data.user.createdAt,
        updatedAt: data.user.updatedAt,
      );
      return user;
    } on DioException catch (e) {
      debugPrint(e.toString());
      throw RepositoryError('Invalid credentials', [e]);
    } on RepositoryError catch (e) {
      debugPrint(e.toString());
      rethrow;
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw RepositoryError('Internal server error', [e]);
    }
  }
}
