import 'package:dynatrace_test/main/factories/usecases/usecases.dart';
import 'package:dynatrace_test/presentation/presenters/presenters.dart';
import 'package:dynatrace_test/ui/pages/random/random.dart';

RandomPresenter makeGetxRandomPresenter() =>
    GetxRandomPresenter(loadHero: makeRemouteGetRandomHero());
