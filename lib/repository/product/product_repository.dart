import '../../util/import/domain.dart';
import '../../util/import/packages.dart';
import '../../util/import/dto.dart';
import '../../util/import/repository.dart';
import '../../util/import/http.dart';

class ProductRepository extends BaseRepository {
  ProductRepository({required super.httpService});

  Future<List<Product>> getProducts() async {
    return handleResponse(
      request: () async {
        final String response = await rootBundle.loadString(
          'assets/data/products.json',
        );
        final List<dynamic> data = json.decode(response);
        return HttpResponse(
          data: data
              .map((item) => ProductDto.fromJson(item).toDomain())
              .toList(),
          status: HttpStatus(200),
        );
      },
      operation: 'getProducts',
    );
  }
}
