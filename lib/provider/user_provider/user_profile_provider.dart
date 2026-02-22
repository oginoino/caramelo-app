import '../../util/import/packages.dart';
import '../../util/import/repository.dart';
import '../../util/import/service.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileProvider(this._userRepository, this._persistenceService);

  final UserRepository _userRepository;
  final PersistenceService _persistenceService;

  UserProfile? _profile;
  String? _fullName;
  String? _email;
  bool _isLoading = false;
  String? _errorCode;

  UserProfile? get profile => _profile;
  String? get fullName => _fullName;
  String? get email => _email;
  bool get isLoading => _isLoading;
  String? get errorCode => _errorCode;

  Future<void> loadProfile() async {
    final accessToken = _persistenceService.getAccessToken();
    if (accessToken == null) {
      _profile = null;
      _fullName = null;
      _email = null;
      _errorCode = 'unauthenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorCode = null;
    notifyListeners();

    try {
      _profile = await _userRepository.getCurrentUser();
      final me = await _userRepository.getMe();
      _fullName = me.fullName;
      _email = me.email;
    } on AuthException catch (e) {
      _profile = null;
      _fullName = null;
      _email = null;
      _errorCode = e.code;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    _profile = null;
    _fullName = null;
    _email = null;
    _errorCode = null;
    _isLoading = false;
    notifyListeners();
  }
}
