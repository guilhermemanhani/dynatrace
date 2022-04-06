import 'package:equatable/equatable.dart';

class HeroViewModel extends Equatable {
  final int id;
  final String name;
  final String slug;

  const HeroViewModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  @override
  List<Object?> get props => [id, name, slug];
}
