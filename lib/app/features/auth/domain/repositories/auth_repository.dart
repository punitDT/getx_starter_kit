import '../../data/models/login_request_model.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequestModel model);

  Future<UserEntity> register(LoginRequestModel model);

  Future<void> logout();

  Future<String> refreshToken();
}
