import 'package:get/get.dart';

mixin LoadingManager on GetxController {
  final _isLoading = true.obs;
  Stream<bool> get isLoadingStream => _isLoading.stream;
  set setIsLoading(bool value) => _isLoading.value = value;
}
