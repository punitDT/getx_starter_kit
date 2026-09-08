import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  T? read<T>(String key) => _box.read(key);

  void write(String key, dynamic value) => _box.write(key, value);

  void remove(String key) => _box.remove(key);

  Future<void> clear() async => _box.erase();
}
