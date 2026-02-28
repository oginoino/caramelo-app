import '../../util/import/packages.dart';
import '../../util/import/http.dart';
import '../../util/import/domain.dart';

class MessageRepository {
  final HttpServiceInterface? httpService;

  MessageRepository({this.httpService});

  Future<List<Message>> getMessages() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const <Message>[
      Message(
        id: 'm1',
        title: 'Entrega em até 15 min',
        description: 'Rápido e perto de você',
        icon: Icons.local_shipping_rounded,
      ),
      Message(
        id: 'm2',
        title: 'Cupons de até 30%',
        description: 'Aproveite ofertas da semana',
        icon: Icons.local_offer_rounded,
      ),
      Message(
        id: 'm3',
        title: 'Pague com Pix',
        description: 'E receba cashback',
        icon: Icons.pix_rounded,
      ),
    ];
  }
}
