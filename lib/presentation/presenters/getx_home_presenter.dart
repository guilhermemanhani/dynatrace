import '../mixins/mixins.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/pages/home/home.dart';
import 'package:get/get.dart';

class GetxHomePresenter extends GetxController
    with LoadingManager
    implements HomePresenter {
  final _heros = Rx<List<HeroViewModel>>([]);
  final GetHeros loadHero;
  final _mainError = RxnString();

  GetxHomePresenter({required this.loadHero});

  @override
  Stream<List<HeroViewModel>> get heroesStream => _heros.stream;

  @override
  Stream<String?> get mainErrorStream => _mainError.stream;

  @override
  Future<void> loadData() async {
    try {
      setIsLoading = true;
      final heros = await loadHero.getHero();
      _heros.value = heros
          .map((hero) => HeroViewModel(
                id: hero.id,
                name: hero.name,
                slug: hero.slug,
                images: hero.image,
              ))
          .toList();
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }
    setIsLoading = false;
  }
}
