import '../../util/import/domain.dart';
import '../../util/import/packages.dart';
import '../../util/import/dto.dart';
import '../../util/import/repository.dart';
import '../../util/import/http.dart';

class LocationRepository extends BaseRepository {
  LocationRepository({required super.httpService});

  Future<List<Location>> getLocations() async {
    return handleResponse(
      request: () async {
        final String response = await rootBundle.loadString(
          'assets/data/locations.json',
        );
        final List<dynamic> data = json.decode(response);
        return HttpResponse(
          data: data
              .map((item) => LocationDto.fromJson(item).toDomain())
              .toList(),
          status: HttpStatus(200),
        );
      },
      operation: 'getLocations',
    );
  }
}
