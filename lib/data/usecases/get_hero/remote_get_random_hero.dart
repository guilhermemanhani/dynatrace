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
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'get',
      );
      return RemoteHeroModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
