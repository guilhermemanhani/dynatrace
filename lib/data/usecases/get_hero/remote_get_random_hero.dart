import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:dynatrace_test/data/models/remote_hero_model.dart';
import 'package:dynatrace_test/domain/entities/entities.dart';
import 'package:dynatrace_test/domain/helpers/helpers.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';

import '../../../data/http/http.dart';

class RemoteGetRandomHero implements GetRandomHero {
  final HttpClient httpClient;
  final String url;

  RemoteGetRandomHero({required this.httpClient, required this.url});

  @override
  Future<HeroEntity> getHero() async {
    DynatraceRootAction action =
        Dynatrace().enterAction("MyButton tapped - Web Action");
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'get',
      );

      action.leaveAction();
      return RemoteHeroModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
