import 'package:equatable/equatable.dart';

class HeroViewModel extends Equatable {
  final int id;
  final String name;
  final String slug;

  HeroViewModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, slug];
}
