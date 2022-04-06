import '../../domain/entities/entities.dart';

abstract class GetHero {
  Future<List<HeroEntity>> getHero();
}
