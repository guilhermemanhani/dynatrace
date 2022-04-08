import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynatrace_test/ui/components/components.dart';
import 'package:provider/provider.dart';
import '../../../ui/pages/random/random.dart';
import 'package:flutter/material.dart';

class RandomPage extends StatefulWidget {
  final RandomPresenter presenter;
  const RandomPage({Key? key, required this.presenter}) : super(key: key);

  @override
  _RandomPageState createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  void initState() {
    widget.presenter.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random'),
      ),
      body: Builder(builder: (context) {
        widget.presenter.isLoadingStream.listen((isLoading) {
          isLoading ? showLoading(context) : hideLoading(context);
        });

        return StreamBuilder<RandomViewModel?>(
            stream: widget.presenter.heroStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
                // ReloadScreen(
                //     error: '${snapshot.error}',
                //     reload: widget.presenter.loadData);
              }
              if (snapshot.hasData) {
                return ListenableProvider(
                    create: (_) => widget.presenter,
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
              return Text('error');
            });
      }),
    );
  }
}
