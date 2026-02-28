class Location {
  final String id;
  final String name;
  final String? description;

  const Location({
    required this.id,
    required this.name,
    this.description,
  });
}
