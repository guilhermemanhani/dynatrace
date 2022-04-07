import '../../../factories/pages/home/home.dart';
import '../../../../ui/pages/home/home.dart';
import 'package:flutter/material.dart';

Widget makeHomePage() => HomePage(presenter: makeGetxHomePresenter());
