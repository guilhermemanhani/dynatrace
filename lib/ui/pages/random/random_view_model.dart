class RandomViewModel {
  final int id;
  final String name;
  final String slug;
  final String images;

  const RandomViewModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.images,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RandomViewModel &&
        other.id == id &&
        other.name == name &&
        other.slug == slug &&
        other.images == images;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ slug.hashCode ^ images.hashCode;
  }
}
