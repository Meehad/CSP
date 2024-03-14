import 'dart:convert';
import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/feedback_model.dart';
import 'package:csp_citizen/models/survey_data.dart';
import 'package:csp_citizen/models/survey_model.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/screens/drawer.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<EventModel> events = [];
  Client client = http.Client();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _retrieveEvents();
    _retrieveQ();

    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
    final postEvent = Provider.of<EventClass>(context, listen: false);
    postEvent.getPostData();
    final postQ = Provider.of<Qlist>(context, listen: false);
    postQ.getPostData(postModel.post?.id_number ?? "");
  }

  Future<void> _retrieveQ() async {
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();

    try {
      final response =
          await client.get(showRQ(postModel.post?.id_number ?? ""));
      final List<dynamic> responseData = jsonDecode(response.body);
      final dataList = responseData
          .map<SurveyQModel>((element) => SurveyQModel.fromJson(element))
          .toList();

      // Use the Qlist provider to update the data
      final qListProvider = Provider.of<Qlist>(context, listen: false);
      qListProvider.qlist = dataList;

      setState(() {});
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _retrieveEvents() async {
    events = [];
    try {
      List response = jsonDecode((await client.get(showEvents)).body);
      for (var element in response) {
        setState(() {
          events.add(EventModel.fromJson(element));
        });
      }
    } catch (e) {
      print("Error retrieving events: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text('Welcome, ${postModel.post?.name ?? ""}'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.asset(
              'assets/CSP_logo.png', // Replace with the path to your logo
              width: 70,
              height: 70,
            ),
          ),
        ],
      ),
      drawer: const NavBar(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Carousel to display events
          events.isNotEmpty
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 300.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: [
                    for (int i = 0; i < events.length; i++)
                      Image.network(
                        "http://10.0.2.2:8000${events[i].event_img}",
                        fit: BoxFit.cover,
                      ),
                  ],
                )
              : const CircularProgressIndicator(),

          // Dot indicator
          events.isNotEmpty
              ? DotsIndicator(
                  dotsCount: events.length,
                  position: _currentIndex.toInt(),
                  decorator: DotsDecorator(
                    color: Colors.black,
                    size: const Size.square(6.0),
                    activeColor: Colors.white,
                    activeSize: const Size.square(8.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                )
              : const SizedBox(),

          // Animated buttons at the bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/complaint');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(
                        100, 150), // Set the desired height and width
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/complaint.png', // Replace with the path to your image
                        width: 70,
                        height: 70,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Complaint',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/survey');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(
                        120, 150), // Set the desired height and width
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Image.asset(
                          'assets/form.png', // Replace with the path to your image
                          width: 65,
                          height: 65,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Survey',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/feedback');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: const Size(
                        100, 150), // Set the desired height and width
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/feedback.png', // Replace with the path to your image
                        width: 70,
                        height: 70,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Scrollable card at the bottom with unanswered survey questions
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dashboard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Display the count of unanswered survey questions
                      Consumer<Qlist>(
                          builder: (BuildContext context, Qlist Qlist,
                                  Widget? child) =>
                              Qlist.qlist.isNotEmpty
                                  ? Text(
                                      'Number of Unanswered Questions: ${Qlist.qlist.length}',
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  : const Text(
                                      'Give your survey responsibly',
                                      style: TextStyle(fontSize: 16),
                                    )),

                      // Add designed buttons for forms and help
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press for forms
                              Navigator.pushNamed(context,
                                  '/forms'); // Replace '/forms' with your actual route
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.tertiary, // Choose your preferred color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.assignment,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Forms',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press for help
                              Navigator.pushNamed(context,
                                  '/help'); // Replace '/help' with your actual route
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary, // Choose your preferred color for the "Help" button
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.help,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Help',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
