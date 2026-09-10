// An interface rule-book. The UI interacts with this, not the network layer directly.
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchAllProducts();
}
