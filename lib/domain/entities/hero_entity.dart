class HeroEntity {
  final int id;
  final String name;
  final String slug;
  final String image;

  const HeroEntity(
      {required this.id,
      required this.name,
      required this.slug,
      required this.image});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HeroEntity &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ slug.hashCode ^ image.hashCode;
  }
}
