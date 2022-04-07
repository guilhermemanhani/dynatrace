import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import '../../../ui/pages/home/home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final HomePresenter presenter;
  const HomePage({Key? key, required this.presenter}) : super(key: key);

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
        // widget.presenter.mainErrorStream.listen(
        //   (error) {
        //     if (error != null && error.isNotEmpty) {
        //       showErrorMessage(context, error);
        //     }
        //   },
        // );
        return StreamBuilder<List<HeroViewModel>>(
            stream: widget.presenter.heroesStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ReloadScreen(
                    error: '${snapshot.error}',
                    reload: widget.presenter.loadData);
              }
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
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.9),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(
                                            0,
                                            3,
                                          ),
                                        ),
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: hero.images,
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      hero.name,
                                      // style: ConstApp.styleGreyDark,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      hero.slug,
                                      // style: ConstApp.styleGreyBright,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ));
              }
              return const SizedBox(height: 0);
            });
      }),
    );
  }
}
