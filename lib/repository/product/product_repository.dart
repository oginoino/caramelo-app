import '../../util/import/domain.dart';
import '../../util/import/packages.dart';
import '../../util/import/dto.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    final String response = await rootBundle.loadString(
      'assets/data/products.json',
    );
    return compute(_parseProducts, response);
  }

  static List<Product> _parseProducts(String encodedJson) {
    final List<dynamic> data = json.decode(encodedJson);
    return data.map((item) => ProductDto.fromJson(item).toDomain()).toList();
  }
}
