import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/pdf_data.dart';
import 'package:csp_citizen/models/survey_data.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/screens/Onboarding.dart';
import 'package:csp_citizen/screens/complaint.dart';
import 'package:csp_citizen/screens/feed.dart';
import 'package:csp_citizen/screens/forms.dart';
import 'package:csp_citizen/screens/help.dart';
import 'package:csp_citizen/screens/home.dart';
import 'package:csp_citizen/screens/profile.dart';
import 'package:csp_citizen/screens/survey.dart';
import 'package:csp_citizen/screens/about.dart';
import 'package:csp_citizen/themes/dark_theme.dart';
import 'package:csp_citizen/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feedback/feedback.dart';

void main() {
  runApp(
    
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DataClass>(
          create: (context) => DataClass(),
        ),
        ChangeNotifierProvider<EventClass>(
          create: (context) => EventClass(),
        ),
        ChangeNotifierProvider<pdfClass>(
          create: (context) => pdfClass(),
        ),
        ChangeNotifierProvider<Qlist>(
          create: (_) => Qlist(),
        ),
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
        localeOverride: const Locale('en'),
        child: const MyApp(),
      ),
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
      theme: lighttheme,
      darkTheme: darkTheme,
      home: const OnboardingScreen(),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/profile': (context) => const ProfilePage(),
        '/complaint': (context) => const ComplaintPage(),
        '/survey': (context) => const SurveyPage(),
        '/feedback': (context) => const FeedbackPage(),
        '/about': (context) => const AboutPage(),
        '/forms': (context) => const Formspage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}





