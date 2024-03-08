import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/screens/complaint.dart';
import 'package:csp_citizen/screens/feedback.dart';
import 'package:csp_citizen/screens/forms.dart';
import 'package:csp_citizen/screens/home.dart';
import 'package:csp_citizen/screens/login.dart';
import 'package:csp_citizen/screens/profile.dart';
import 'package:csp_citizen/screens/survey.dart';
import 'package:csp_citizen/screens/about.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataClass(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventClass(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Login(),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/profile': (context) => const ProfilePage(),
        '/complaint': (context) => const ComplaintPage(),
        '/survey': (context) => const SurveyPage(),
        '/feedback': (context) => const FeedbackPage(),
        '/about': (context) => AboutPage(),
        '/forms':(context) => Formspage()
      },
    );
  }
}
