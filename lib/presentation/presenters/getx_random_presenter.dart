import 'package:dynatrace_test/domain/helpers/helpers.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';
import 'package:get/get.dart';
import '../../ui/pages/random/random.dart';

class GetxRandomPresenter extends GetxController implements RandomPresenter {
  final _hero = Rx<RandomViewModel?>(null);
  final _isLoading = true.obs;
  final _mainError = RxnString();
  final GetRandomHero loadHero;

  GetxRandomPresenter({required this.loadHero});

  @override
  Stream<RandomViewModel?> get heroStream => _hero.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  @override
  Future<void> loadData() async {
    _isLoading.value = true;
    try {
      // final hero = await loadHero.getHero();
      // _hero.value = RandomViewModel(
      //   id: hero.id,
      //   name: hero.name,
      //   slug: hero.slug,
      //   images: hero.image,
      // );
      _hero.value = RandomViewModel(
        id: 1,
        name: 'a',
        slug: '2',
        images: '3',
      );
    } on DomainError catch (error) {
      _mainError.value = error.description;
    }
    _isLoading.value = false;
  }

  @override
  Stream<String?> get mainErrorStream => _mainError.stream;

  @override
  // ignore: must_call_super
  void dispose() {}
}
