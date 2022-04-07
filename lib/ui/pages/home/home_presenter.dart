import '../../../ui/pages/home/home.dart';
import 'package:flutter/material.dart';

abstract class HomePresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<List<HeroViewModel>> get heroesStream;
  Stream<String?> get mainErrorStream;

  Future<void> loadData();

  void dispose();
}
