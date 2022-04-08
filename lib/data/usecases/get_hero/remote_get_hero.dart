import '../../../data/http/http.dart';
import '../../../data/models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class RemoteGetHero implements GetHeros {
  final HttpClient httpClient;
  final String url;

  RemoteGetHero({required this.httpClient, required this.url});

  @override
  Future<List<HeroEntity>> getHero() async {
    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'get',
      );
      return httpResponse
          .map<HeroEntity>((json) => RemoteHeroModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
