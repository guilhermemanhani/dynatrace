import 'package:dynatrace_test/data/usecases/get_hero/remote_get_random_hero.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';
import 'package:dynatrace_test/main/factories/http/api_url_factory.dart';
import 'package:dynatrace_test/main/factories/http/http_client_factory.dart';

GetRandomHero makeRemouteGetRandomHero() => RemoteGetRandomHero(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('/id/1.json'),
    );
