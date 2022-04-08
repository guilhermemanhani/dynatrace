import '../random/random.dart';
import '../../../../ui/pages/random/random.dart';
import 'package:flutter/material.dart';

Widget makeRandomPage() => RandomPage(presenter: makeGetxRandomPresenter());
