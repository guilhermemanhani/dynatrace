import 'package:equatable/equatable.dart';

class HeroEntity extends Equatable {
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
  List<Object?> get props => [id, name, slug, image];
}
