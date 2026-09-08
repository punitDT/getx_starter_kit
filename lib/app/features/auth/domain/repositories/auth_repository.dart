import '../../../../core/utils/result.dart';
import '../entities/user_entity.dart';
import '../../data/models/login_request_model.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> login(LoginRequestModel model);
  Future<Result<UserEntity>> register(LoginRequestModel model);
  Future<void> logout();
  Future<Result<String>> refreshToken();
}
