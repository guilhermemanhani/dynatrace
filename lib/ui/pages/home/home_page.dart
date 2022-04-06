import 'package:dynatrace_test/ui/pages/home/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  HomePage(this.presenter);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    widget.presenter.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: Container(),
    );
  }
}
