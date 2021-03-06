import 'dart:io';

import 'package:dynatrace_flutter_plugin/dynatrace_flutter_plugin.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
const String HOME_NAV = 'homeNav';
// ignore: constant_identifier_names
const String TEST_NAV = 'testNav';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dynatrace Test App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       onUnknownRoute: (settings) => MaterialPageRoute(
//           builder: (context) => UndefinedView(
//                 name: settings.name!,
//               )),
//       initialRoute: HOME_NAV,
//       routes: {
//         HOME_NAV: (context) => MyHomePage(),
//         TEST_NAV: (context) => TestNav(),
//       },
//       navigatorObservers: [DynatraceNavigationObserver()],
//       home: MyHomePage(),
//     );
//   }
// }

class TestNav extends StatelessWidget {
  const TestNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          child: const Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pushNamed(context, HOME_NAV);
          },
        ),
      ),
    );
  }
}

class UndefinedView extends StatelessWidget {
  final String? name;
  const UndefinedView({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No route defined here!'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var appBarText = const Text("Dynatrace Test App");
  // ignore: prefer_typing_uninitialized_variables
  static var _context;

  static Map<String, VoidCallback> actionsMap = {
    'Single Action': _singleAction,
    'Sub Action': _subAction,
    'Web Action': _webAction,
    'Web Action Override': _webActionOverrideHeader,
    'Web Action Full Manual': _webActionFullManualInstr,
    'Report values': _reportAll,
    'Make Navigation': _makeNavigation,
    'Force errors': _forceErrors,
    'Report crash': _reportCrash,
    'Report crash exception': _reportCrashException,
    'Flush data': _flushData,
    'Tag user': _tagUser,
    'End Session': _endSession,
    'setGpsLocation: Hawaii': _setGpsLocationHawaii,
    'User Privacy Options : All Off': _userPrivacyOptionsAllOff,
    'User Privacy Options : All On': _userPrivacyOptionsAllOn,
    'getUserPrivacyOptions': () async {
      UserPrivacyOptions options = await Dynatrace().getUserPrivacyOptions();
      // ignore: avoid_print
      print('User Privacy Options Crash:');
      // ignore: avoid_print
      print(options.crashReportingOptedIn);
      // ignore: avoid_print
      print('User Privacy Options Level:');
      // ignore: avoid_print
      print(options.dataCollectionLevel);
    }
  };

  @override
  Widget build(BuildContext context) {
    _context = context;

    final ScrollController sController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: appBarText,
      ),
      body: Scrollbar(
        controller: sController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          controller: sController,
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < actionsMap.keys.length; i++)
                  Container(
                    width: 280.0,
                    height: 45.0,
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      //  Colors.white,

                      // color: Colors.blue,
                      onPressed: actionsMap.values.elementAt(i),
                      child: Text(actionsMap.keys.elementAt(i)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _makeNavigation() {
    Navigator.pushNamed(_context, TEST_NAV);
  }

  static void _singleAction() {
    DynatraceRootAction myAction =
        Dynatrace().enterAction("MyButton tapped - Single Action");
    //Perform the action and whatever else is needed.
    myAction.leaveAction();
  }

  static void _subAction() {
    DynatraceRootAction myAction =
        Dynatrace().enterAction("MyButton tapped - Sub Action");
    DynatraceAction mySubAction = myAction.enterAction("MyButton Sub Action");
    //Perform the action and whatever else is needed.
    mySubAction.leaveAction();
    myAction.leaveAction();
  }

  static void _webAction() async {
    DynatraceRootAction action =
        Dynatrace().enterAction("MyButton tapped - Web Action");
    await HttpClient()
        .getUrl(Uri.parse('https://dynatrace.com'))
        .then((request) => request.close())
        // ignore: avoid_print
        .then((response) => print("Request Done"));
    action.leaveAction();
  }

  static void _webActionOverrideHeader() async {
    HttpClient client = HttpClient();
    DynatraceRootAction action =
        Dynatrace().enterAction("MyButton tapped - Web Action Override");
    final request = await client.getUrl(Uri.parse('https://dynatrace.com'));
    request.headers.set(action.getRequestTagHeader(),
        await action.getRequestTag('https://dynatrace.com'));
    final response = await request.close();
    // ignore: avoid_print
    print(response);
    action.leaveAction();
  }

  static void _webActionFullManualInstr() async {
    HttpClient client = HttpClient();

    DynatraceRootAction action =
        Dynatrace().enterAction("MyButton tapped - Web Action Full Manual");
    WebRequestTiming timing =
        await action.createWebRequestTiming('https://dynatrace.com');

    final request = await client.getUrl(Uri.parse('https://dynatrace.com'));
    request.headers.add(timing.getRequestTagHeader(), timing.getRequestTag());
    timing.startWebRequestTiming();
    final response = await request.close();
    timing.stopWebRequestTiming(response.statusCode, null);
    // ignore: avoid_print
    print(response);
    action.leaveAction();
  }

  static void _reportAll() {
    DynatraceRootAction myAction =
        Dynatrace().enterAction("MyButton tapped - Report values");
    myAction.reportStringValue("ValueNameString", "ImportantValue");
    myAction.reportIntValue("ValueNameInt", 1234);
    myAction.reportDoubleValue("ValueNameDouble", 123.4567);
    myAction.reportEvent("ValueNameEvent");
    myAction.reportError("ValueNameError", 408);
    myAction.leaveAction();
  }

  static void _forceErrors() {
    String input = '12,34';
    double.parse(input);
  }

  static void _reportCrash() {
    Dynatrace().reportCrash(
        "FormatException", "Invalid Double", "WHOLE_STACKTRACE_AS_STRING");
  }

  static void _reportCrashException() {
    Dynatrace().reportCrashWithException(
        "FormatException",
        Exception(
            "FormatException, Invalid Double, WHOLE_STACKTRACE_AS_STRING"));
  }

  static void _flushData() {
    Dynatrace().flushEvents();
  }

  static void _tagUser() {
    Dynatrace().identifyUser("User XY");
  }

  static void _endSession() {
    Dynatrace().endSession();
  }

  static void _setGpsLocationHawaii() {
    // set GPS coords to Hawaii
    Dynatrace().setGPSLocation(19, 155);
  }

  static void _userPrivacyOptionsAllOff() {
    Dynatrace().applyUserPrivacyOptions(
        UserPrivacyOptions(DataCollectionLevel.Off, false));
  }

  static void _userPrivacyOptionsAllOn() {
    Dynatrace().applyUserPrivacyOptions(
        UserPrivacyOptions(DataCollectionLevel.UserBehavior, true));
  }
}
