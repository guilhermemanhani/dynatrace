import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../../ui/pages/home/home.dart';
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
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          isLoading ? showLoading(context) : hideLoading(context);
        });
        widget.presenter.mainErrorStream.listen((error) {
          if (error != null && error.isNotEmpty) {
            showErrorMessage(context, error);
          }
        });
        return StreamBuilder<List<HeroViewModel>>(
            stream: widget.presenter.heroesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListenableProvider(
                    create: (_) => widget.presenter,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 2 / 2,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var hero = snapshot.data![index];
                        return Text(hero.name);
                      },
                    ));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return SizedBox(height: 0);
            });
      }),
    );
  }
}
