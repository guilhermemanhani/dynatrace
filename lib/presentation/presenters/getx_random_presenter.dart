import 'package:dynatrace_test/domain/helpers/helpers.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';
import '../mixins/mixins.dart';
import 'package:get/get.dart';
import '../../ui/pages/random/random.dart';

class GetxRandomPresenter extends GetxController
    with LoadingManager
    implements RandomPresenter {
  final _hero = Rxn<RandomViewModel?>(null);
  final _mainError = RxnString();
  final GetRandomHero loadHero;

  GetxRandomPresenter({required this.loadHero});

  @override
  Stream<RandomViewModel?> get heroStream => _hero.stream;

  @override
  Future<void> loadData() async {
    setIsLoading = true;

    try {
      final hero = await loadHero.getHero();
      _hero.value = RandomViewModel(
        id: hero.id,
        name: hero.name,
        slug: hero.slug,
        images: hero.image,
      );
    } on DomainError catch (error) {
      _mainError.value = error.description;
    } finally {
      setIsLoading = false;
    }
  }

  @override
  Stream<String?> get mainErrorStream => _mainError.stream;

  @override
  // ignore: must_call_super
  void dispose() {}
}
