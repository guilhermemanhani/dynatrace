import '../../../data/http/http.dart';
import '../../../data/models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class RemoteGetHero implements GetHero {
  final HttpClient httpClient;
  final String url;

  RemoteGetHero({required this.httpClient, required this.url});

  Future<HeroEntity> getHero() async {
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
      );
      return RemoteHeroModel.fromJson(httpResponse).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
