import '../../domain/entities/entities.dart';

abstract class GetHeros {
  Future<List<HeroEntity>> getHero();
}
