import 'package:dynatrace_test/ui/pages/home/hero_view_model.dart';
import 'package:flutter/material.dart';

abstract class HomePresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<List<HeroViewModel>> get heroesStream;
}
