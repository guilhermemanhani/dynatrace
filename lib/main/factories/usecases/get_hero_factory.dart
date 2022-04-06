import 'package:dynatrace_test/data/usecases/get_hero/remote_get_hero.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';
import 'package:dynatrace_test/main/factories/http/api_url_factory.dart';
import 'package:dynatrace_test/main/factories/http/http_client_factory.dart';

GetHero makeRemouteGetHero() => RemoteGetHero(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('all.json'),
    );
