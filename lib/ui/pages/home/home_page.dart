import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:dynatrace_test/ui/mixins/loading_manager.dart';
import 'package:get/route_manager.dart';
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

class _HomePageState extends State<HomePage> with LoadingManager {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: ElevatedButton(
            onPressed: () {
              DynatraceRootAction myAction = Dynatrace()
                  .enterAction("RandomBUTTON tapped - Single Action");
              //Perform the action and whatever else is needed.

              myAction.leaveAction();
              Get.toNamed('/random');
            },
            child: const Text('Escolha aleatório')),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.next_plan_outlined),
          onPressed: () {
            DynatraceRootAction myAction = Dynatrace()
                .enterAction("DynatraceBUTTON tapped - Single Action");
            //Perform the action and whatever else is needed.

            myAction.leaveAction();
            Get.toNamed('/dynatrace');
          }),
      body: Builder(builder: (context) {
        handleLoading(context, widget.presenter.isLoadingStream);
        widget.presenter.loadData();
        widget.presenter.mainErrorStream.listen(
          (error) {
            if (error != null && error.isNotEmpty) {
              showErrorMessage(context, error);
            }
          },
        );
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

              return const SizedBox();
            });
      }),
    );
  }
}
