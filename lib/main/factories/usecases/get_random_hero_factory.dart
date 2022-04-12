import 'dart:math';

import 'package:dynatrace_test/data/usecases/get_hero/remote_get_random_hero.dart';
import 'package:dynatrace_test/domain/usecases/usecases.dart';
import 'package:dynatrace_test/main/factories/http/api_url_factory.dart';
import 'package:dynatrace_test/main/factories/http/http_client_factory.dart';

GetRandomHero makeRemouteGetRandomHero() {
  var rng = Random();
  return RemoteGetRandomHero(
    httpClient: makeHttpAdapter(),
    url: makeApiUrl('/id/${rng.nextInt(100)}.json'),
  );
}
