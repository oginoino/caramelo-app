import '../../util/import/packages.dart';
import '../../util/import/repository.dart';
import '../../util/import/domain.dart';

class LocationProvider extends ChangeNotifier {
  final LocationRepository _repository;

  LocationProvider(this._repository) {
    loadLocations();
  }

  List<Location> _locations = [];
  List<Location> get locations => List.unmodifiable(_locations);

  String? _selectedLocation;
  String? get selectedLocation => _selectedLocation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadLocations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _locations = await _repository.getLocations();
      if (_selectedLocation == null && _locations.isNotEmpty) {
        _selectedLocation = _locations.first.name;
      }
    } catch (e) {
      debugPrint('Error loading locations: $e');
      _errorMessage = 'Failed to load locations. Please try again later.';
      _locations = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedLocation(String? locationName) {
    if (_selectedLocation != locationName) {
      _selectedLocation = locationName;
      notifyListeners();
    }
  }

  Future<void> addLocation(String name) async {
    if (name.trim().isEmpty) return;

    final trimmedName = name.trim();
    final exists = _locations.any((loc) => loc.name == trimmedName);

    if (!exists) {
      final newLocation = Location(
        id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
        name: trimmedName,
      );

      _locations = List<Location>.from(_locations)..add(newLocation);
      _selectedLocation = trimmedName;
      notifyListeners();
    } else {
      _selectedLocation = trimmedName;
      notifyListeners();
    }
  }

  void removeLocation(String locationId) {
    _locations = _locations.where((loc) => loc.id != locationId).toList();
    
    if (_selectedLocation != null) {
      final wasSelected = !_locations.any((loc) => loc.name == _selectedLocation);
      if (wasSelected && _locations.isNotEmpty) {
        _selectedLocation = _locations.first.name;
      } else if (_locations.isEmpty) {
        _selectedLocation = null;
      }
    }
    
    notifyListeners();
  }

  void clearCache() {
    _locations = [];
    _selectedLocation = null;
    _errorMessage = null;
    notifyListeners();
  }
}