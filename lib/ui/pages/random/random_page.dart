import 'package:cached_network_image/cached_network_image.dart';
import '../../mixins/mixins.dart';
import 'package:provider/provider.dart';
import '../../../ui/pages/random/random.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget with LoadingManager {
  final RandomPresenter presenter;

  RandomPage(this.presenter, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random'),
      ),
      body: Builder(
        builder: (context) {
          handleLoading(context, presenter.isLoadingStream);
          presenter.loadData();

          return StreamBuilder<RandomViewModel?>(
              stream: presenter.heroStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
                if (snapshot.hasData) {
                  return ListenableProvider(
                      create: (_) => presenter,
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
                                imageUrl: snapshot.data!.images,
                                placeholder: (context, url) => const SizedBox(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                snapshot.data!.name,
                                // style: ConstApp.styleGreyDark,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                snapshot.data!.slug,
                                // style: ConstApp.styleGreyBright,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ));
                }
                return const SizedBox(height: 0);
              });
        },
      ),
    );
  }
}
