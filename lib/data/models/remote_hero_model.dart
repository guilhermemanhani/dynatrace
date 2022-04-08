import 'package:dynatrace_test/data/http/http.dart';
import 'package:dynatrace_test/domain/entities/hero_entity.dart';

class RemoteHeroModel {
  int id;
  String name;
  String slug;
  Pickture image;
  RemoteHeroModel(
      {required this.id,
      required this.name,
      required this.slug,
      required this.image});

  factory RemoteHeroModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') ||
        !json.containsKey('name') ||
        !json.containsKey('slug') ||
        !json.containsKey('images')) {
      throw HttpError.invalidData;
    }
    return RemoteHeroModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: Pickture.fromJson(json['images']),
    );
  }

  HeroEntity toEntity() =>
      HeroEntity(id: id, name: name, slug: slug, image: image.xs);
}

class Pickture {
  String xs;
  String sm;
  String md;
  String lg;
  Pickture({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
  });

  factory Pickture.fromJson(Map<String, dynamic> json) {
    return Pickture(
      xs: json['xs'],
      sm: json['sm'],
      md: json['md'],
      lg: json['lg'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xs'] = xs;
    data['sm'] = sm;
    data['md'] = md;
    data['lg'] = lg;
    return data;
  }
}
