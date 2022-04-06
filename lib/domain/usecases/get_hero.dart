import '../../domain/entities/entities.dart';

abstract class GetHero {
  Future<HeroEntity> getHero();
}
