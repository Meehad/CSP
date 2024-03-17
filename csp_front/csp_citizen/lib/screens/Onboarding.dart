// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:csp_citizen/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Map<String, dynamic>> onboardingData = [
    {"text": "100 % SECURE! \nAuthorized by the Government", "image": "assets/19198219.png"},
    {"text": " Sumbit Surveys \n Report Complaints \n Give Feedback \n All in One App .", "image": "assets/survey.jpg"},
    {"text": "No Registration, Just Verify Your Adhaar ID", "image": "assets/Wavy_Bus-24_Single-11.png"},
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future<void> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = prefs.getBool('seen') ?? false;

    if (seen) {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      //} else {
      // await prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Change this to your desired background color
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                text: onboardingData[index]["text"],
                image: onboardingData[index]["image"],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _currentPage == onboardingData.length - 1
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(350.0, 48.0)),
                          ),
                          child: const Text('Get Started', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                        ).animate().fadeIn(delay: 1700.ms).scaleY(),
                        const SizedBox(height: 16.0),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _pageController.animateToPage(
                              onboardingData.length - 1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(fontSize: 18.0,color: Colors.black),
                          ),
                        ).animate().fadeIn(delay: 2000.ms).scaleY(),
                        SmoothPageIndicator(
                          
                          controller: _pageController,
                          count: onboardingData.length,
                          effect: const WormEffect(),
                          onDotClicked: (index) {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              
                            );
                          },
                        ).animate().fadeIn(delay: 2000.ms).scaleY(),
                        ElevatedButton(
                          onPressed: () {
                            if (_currentPage < onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: _currentPage == onboardingData.length - 1
                                ? const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0)
                                : const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                            textStyle: TextStyle(color: Colors.black,
                              fontSize: _currentPage == onboardingData.length - 1 ? 18.0 : 18.0,
                            ),
                          ),
                          child: Text(_currentPage < onboardingData.length - 1 ? 'Next' : 'Get Started'),
                        ).animate().fadeIn(delay: 2000.ms).scaleY(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String text;
  final String image;

  const OnboardingPage({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 400, // Set the desired height of the image
          ),
          const SizedBox(height: 20.0),
          Text(
            text,
            style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0)),
            textAlign: TextAlign.left,
          ).animate().fadeIn(delay: 1700.ms).scaleY(),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
