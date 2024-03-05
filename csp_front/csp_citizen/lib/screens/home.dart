// Import necessary packages and classes
import 'dart:convert';
import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/feedback_model.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// Define a stateful widget called MyHomePage
class MyHomePage extends StatefulWidget {
  // Constructor to initialize the title
  const MyHomePage({super.key, required this.title});

  // Required parameter: title to be displayed on the app bar
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Define the state for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  List<EventModel> events = [];
  Client client = http.Client();
  String imagePath = "";
  int i = 0;

  // Override initState to perform one-time initialization tasks
  @override
  void initState() {
    super.initState();
    _retrieveEvents();

    // Get post data using the DataClass provider
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();

    final postEvent = Provider.of<EventClass>(context, listen: false);
    postEvent.getPostData();
  }

  // Fetch events data from the API
  _retrieveEvents() async {
    events = [];
    List response = jsonDecode((await client.get(showEvents)).body);
    for (var element in response) {
      events.add(EventModel.fromJson(element));
    }
    setState(() {});
  }

  // Build method to construct the UI
  @override
  Widget build(BuildContext context) {
    // Get post data using the DataClass provider
    final postModel = Provider.of<DataClass>(context);

    // Return the main scaffold containing the app structure
    return Scaffold(
      // App bar with a title and profile button
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // here along side title we give current username from user model we created using provider
        title: Text('${widget.title} : ${postModel.post?.name ?? ""}'),
        // button to navigate to profile page
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),

      // Body of the app containing a column with various buttons navigate to different pages for each service for citizen and a carousel to show events
      body: Center(
        child: Column(children: [
          const SizedBox(height: 50),
          Column(
            children: [
              // Button to navigate to the complaint screen
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/complaint');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.report,
                          size: 30, color: Color.fromARGB(255, 44, 44, 44)),
                      SizedBox(width: 8),
                      Text(
                        'Report a Complaint',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button to navigate to the survey screen
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/survey');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.poll,
                          size: 30, color: Color.fromARGB(255, 48, 48, 48)),
                      SizedBox(width: 8),
                      Text(
                        'Take a Survey',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button to navigate to the feedback screen
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/feedback');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.feedback,
                          size: 30, color: Color.fromARGB(255, 45, 45, 45)),
                      SizedBox(width: 8),
                      Text(
                        'Provide Feedback',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Carousel to display events
              const SizedBox(height: 40),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.9,
                ),
                items: [
                  // Images in the carousel
                  for (int i = 0; i < events.length; i++)
                    Image.network(
                      "http://10.0.2.2:8000${events[i].event_img}",
                      fit: BoxFit.cover,
                    ),
                ],
              )
            ],
          ),
        ]),
      ),

      // Background color of the scaffold
      backgroundColor: Colors.green,
    );
  }
}
