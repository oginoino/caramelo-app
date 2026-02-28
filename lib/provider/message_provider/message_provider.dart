import '../../util/import/packages.dart';
import '../../util/import/repository.dart';
import '../../util/import/domain.dart';

class MessageProvider extends ChangeNotifier {
  final MessageRepository _repository;

  MessageProvider(this._repository) {
    load();
  }

  List<Message> _items = [];
  List<Message> get items => List.unmodifiable(_items);

  bool _loading = false;
  bool get isLoading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _items = await _repository.getMessages();
    } catch (e) {
      _error = 'Falha ao carregar mensagens';
      _items = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

