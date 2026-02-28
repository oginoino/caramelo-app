import '../domain/location.dart';

class LocationDto {
  final String id;
  final String name;
  final String? description;

  const LocationDto({required this.id, required this.name, this.description});

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    if (description != null) 'description': description,
  };

  Location toDomain() => Location(id: id, name: name, description: description);
}
