import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/event_data.dart';
import 'package:csp_dept/models/survey_data.dart';
import 'package:csp_dept/models/viewfeed_data.dart';
import 'package:csp_dept/screens/deptdetails.dart';
import 'package:csp_dept/screens/deptevent.dart';
import 'package:csp_dept/screens/deptform.dart';
import 'package:csp_dept/screens/depthome.dart';
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
        ChangeNotifierProvider(create: (context) => SurveyClass())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const DeptLogin(),
        routes: {
          '/home': (context) => const Depthome(),
          '/dept_details': (context) => const deptdetails(),
          '/event': (context) => const deptevent(),
          '/survey': (context) => SurveyApp(),
        });
  }
}