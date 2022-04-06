import 'package:dynatrace_test/main/factories/usecases/usecases.dart';
import 'package:dynatrace_test/presentation/presenters/presenters.dart';
import 'package:dynatrace_test/ui/pages/home/home.dart';

HomePresenter makeGetxHomePresenter() =>
    GetxHomePresenter(loadHero: makeRemouteGetHero());
