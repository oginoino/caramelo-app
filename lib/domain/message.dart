import '../util/import/packages.dart';

class Message {
  final String id;
  final String title;
  final String? description;
  final IconData? icon;

  const Message({
    required this.id,
    required this.title,
    this.description,
    this.icon,
  });
}

