import '../entities/user_entity.dart';
import '../../data/models/login_request_model.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequestModel model);
  Future<UserEntity> register(LoginRequestModel model);
  Future<void> logout();
  Future<String> refreshToken();
}
