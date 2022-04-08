import 'package:flutter/material.dart';

import './random.dart';

abstract class RandomPresenter implements Listenable {
  Stream<bool> get isLoadingStream;
  Stream<RandomViewModel?> get heroStream;
  Stream<String?> get mainErrorStream;

  Future<void> loadData();

  void dispose();
}
