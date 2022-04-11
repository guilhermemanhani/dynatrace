import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:dynatrace_test/main/factories/pages/page.dart';
import 'package:dynatrace_test/ui/pages/dynatrace/dynatrace_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
// As configurações de privacidade configuradas abaixo são fornecidas apenas
// para permitir um início rápido com a captura de dados de monitoramento.
// Isso deve ser solicitado ao usuário
//(por exemplo, em uma tela de configurações de privacidade) e a decisão do usuário
//deve ser aplicada de forma semelhante a este exemplo.

void main() {
  //Dynatrace().setDataCollectionLevel(DataCollectionLevel.User);
//Dynatrace().setCrashReportingOptedIn(true);
  Dynatrace().start(
    const MyApp(),
    // configuration: const Configuration(
    //   reportCrash: true,
    //   monitorWebRequest: true,
    //   logLevel: LogLevel.Debug,
    //   certificateValidation: true,
    //   userOptIn: false,
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dynatrace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      navigatorObservers: [
        DynatraceNavigationObserver(),
      ],
      getPages: [
        GetPage(name: '/home', page: makeHomePage),
        GetPage(name: '/random', page: makeRandomPage),
        GetPage(
            name: '/dynatrace',
            page: () => MyHomePage(
                  title: 'Dynatrace',
                )),
      ],
    );
  }
}
