import '../../domain/entities/entities.dart';

abstract class GetRandomHero {
  Future<HeroEntity> getHero();
}
