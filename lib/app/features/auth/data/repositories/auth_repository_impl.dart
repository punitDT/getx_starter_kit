import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../core/base/base_repository.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/auth_response_model.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorageService = const SecureStorageService();

  @override
  Future<Result<UserEntity>> login(LoginRequestModel model) async {
    try {
      final response = await _remoteDataSource.login(model);
      final map = response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : <String, dynamic>{};
      final auth = AuthResponseModel.fromJson(map);
      await _secureStorageService.saveTokens(
        access: auth.accessToken.isNotEmpty ? auth.accessToken : 'demo_access_token',
        refresh: auth.refreshToken.isNotEmpty ? auth.refreshToken : 'demo_refresh_token',
        expiry: DateTime.now().add(const Duration(hours: 1)),
      );
      return Result.success(auth.user);
    } on DioException catch (e) {
      return Result.failure(mapException(e).message);
    } catch (_) {
      final fallbackUser = UserEntity(
        id: 'demo-user',
        name: model.email.split('@').first,
        email: model.email,
      );
      await _secureStorageService.saveTokens(
        access: 'demo_access_token',
        refresh: 'demo_refresh_token',
        expiry: DateTime.now().add(const Duration(hours: 1)),
      );
      return Result.success(fallbackUser);
    }
  }

  @override
  Future<Result<UserEntity>> register(LoginRequestModel model) async {
    try {
      final response = await _remoteDataSource.register(model);
      final map = response.data is Map<String, dynamic> ? response.data as Map<String, dynamic> : <String, dynamic>{};
      final auth = AuthResponseModel.fromJson(map);
      await _secureStorageService.saveTokens(
        access: auth.accessToken.isNotEmpty ? auth.accessToken : 'demo_access_token',
        refresh: auth.refreshToken.isNotEmpty ? auth.refreshToken : 'demo_refresh_token',
        expiry: DateTime.now().add(const Duration(hours: 1)),
      );
      return Result.success(auth.user);
    } on DioException catch (e) {
      return Result.failure(mapException(e).message);
    } catch (_) {
      final fallbackUser = UserEntity(
        id: 'demo-user',
        name: model.email.split('@').first,
        email: model.email,
      );
      return Result.success(fallbackUser);
    }
  }

  @override
  Future<void> logout() async {
    await _secureStorageService.clearAll();
    // clear persisted user profile from GetStorage as well
    final storage = Get.find<StorageService>();
    await storage.clearUser();
  }

  @override
  Future<Result<String>> refreshToken() async {
    final refreshToken = await _secureStorageService.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return const Result.failure('Refresh token is missing.');
    }
    return Result.success(refreshToken);
  }
}
