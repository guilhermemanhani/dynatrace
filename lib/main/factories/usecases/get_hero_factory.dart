import '../../../data/usecases/get_hero/remote_get_hero.dart';
import '../../../domain/usecases/usecases.dart';
import '../../../main/factories/http/http.dart';

GetHero makeRemouteGetHero() => RemoteGetHero(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('all.json'),
    );
