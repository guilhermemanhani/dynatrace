import 'package:dynatrace_test/domain/helpers/helpers.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';
import 'package:dynatrace_test/ui/pages/home/home.dart';
import 'package:get/get.dart';

class GetxHomePresenter extends GetxController implements HomePresenter {
  final _heros = Rx<List<HeroViewModel>>([]);
  var _isLoading = false.obs;
  final GetHero loadHero;

  GetxHomePresenter({required this.loadHero});
  @override
  Stream<List<HeroViewModel>> get heroesStream => _heros.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  Future<void> loadData() async {
    try {
      _isLoading.value = true;
      final heros = await loadHero.getHero();
      _heros.value = heros
          .map((hero) => HeroViewModel(
                id: hero.id,
                name: hero.name,
                slug: hero.slug,
              ))
          .toList();
    } on DomainError catch (error) {}
    _isLoading.value = false;
  }
}
