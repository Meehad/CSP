import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/event_data.dart';
import 'package:csp_dept/models/survey_data.dart';
import 'package:csp_dept/models/viewfeed_data.dart';
import 'package:csp_dept/screens/deptdetails.dart';
import 'package:csp_dept/screens/deptevent.dart';
import 'package:csp_dept/screens/deptform.dart';
import 'package:csp_dept/screens/depthome.dart';
import 'package:csp_dept/screens/deptviewdata.dart';
import 'package:csp_dept/screens/survey_chart.dart';
import 'package:csp_dept/screens/survey_table.dart';
import 'package:csp_dept/screens/help.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/deptlogin.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DeptDataClass(),
        ),
        ChangeNotifierProvider(create: (context) => FeedClass()),
        ChangeNotifierProvider(create: (context) => EventClass()),
        ChangeNotifierProvider(create: (context) => SurveyClass()),
        ChangeNotifierProvider(create: (context) => SurveyDataProvider()),
        ChangeNotifierProvider(create: (context) => AvgFeedClass()),
      ],
      child: BetterFeedback(
        theme: FeedbackThemeData(
          background: const Color.fromARGB(255, 40, 40, 40),
          feedbackSheetColor: const Color.fromARGB(255, 28, 28, 28),
          drawColors: [
            Colors.red,
            Colors.green,
            Colors.blue,
            Colors.yellow,
          ],
          bottomSheetDescriptionStyle: const TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
          bottomSheetTextInputStyle: const TextStyle(color: Color.fromARGB(255, 212, 212, 212))
        ),
        localizationsDelegates: [
          GlobalFeedbackLocalizationsDelegate(),
        ],
        localeOverride: const Locale('en'),child: const MyApp(),),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF698996)),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color.fromARGB(255, 226, 226, 226))
              .copyWith(background: const Color.fromARGB(255, 226, 226, 226)),
          buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF698996)),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xFF698996)),
                  foregroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 213, 213, 213)))),
        ),
        home: const DeptLogin(),
        routes: {
          '/home': (context) => const Depthome(),
          '/dept_details': (context) => const deptdetails(),
          '/event': (context) => const DeptEvent(),
          '/survey': (context) => const SurveyApp(),
          '/dataview': (context) => const Deptview(),
          '/help':(context) => const HelpPage(),
          '/surveytable': (context) => const SurveyTable(),
          '/surveychart': (context) => const Survey_chart(),
        });
  }
}
