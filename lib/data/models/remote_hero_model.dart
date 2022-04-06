import 'package:dynatrace_test/data/http/http.dart';
import 'package:dynatrace_test/domain/entities/hero_entity.dart';

class RemoteHeroModel {
  int id;
  String name;
  String slug;

  RemoteHeroModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory RemoteHeroModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') ||
        !json.containsKey('name') ||
        !json.containsKey('slug')) {
      throw HttpError.invalidData;
    }
    return RemoteHeroModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }

  HeroEntity toEntity() => HeroEntity(id: id, name: name, slug: slug);
}
