import 'dart:convert';
import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/feedback_model.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/urls.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


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

    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();

    final postEvent = Provider.of<EventClass>(context, listen: false);
    postEvent.getPostData();
  }

  _retrieveEvents() async {
    events = [];
    List response = jsonDecode((await client.get(showEvents)).body);
    for (var element in response) {
      events.add(EventModel.fromJson(element));
    }
    setState(() {});
  }

  // Dummy list of unanswered survey questions
  // Dummy count of unanswered survey questions
  int unansweredQuestionsCount = 3; // Replace with the actual count

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);

    return Scaffold(
      appBar: AppBar(
  backgroundColor: Color(0xFF698996),
  title: Text('Welcome ${postModel.post?.name ?? ""}'),
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
        'assets/logo 2.png', // Replace with the path to your logo
        width: 50,
        height: 50,
      ),
    ),
  ],
),

       drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF97B1A6),
              ),
              child: Text(
                'Navigation',
                style: TextStyle(fontSize: 25),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/submitFeeback');
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Report a bug'),
              onTap: () {
                BetterFeedback.of(context).show((feedback) async {});
              },
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
            ),
          ],
        ),
      ),
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
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
          ): CircularProgressIndicator(),

          // Dot indicator
          events.isNotEmpty
              ?DotsIndicator(
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
          ):SizedBox(),

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
          primary: const Color(0xFF698996),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size(100, 150), // Set the desired height and width
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
            Image.asset(
              'assets/complaint.png', // Replace with the path to your image
              width: 70,
              height: 70,
            ),
            SizedBox(height: 8),
            Text(
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
          primary: const Color(0xFF97B1A6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size(120, 150), // Set the desired height and width
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
            SizedBox(height: 8),
            Text(
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
          primary: const Color(0xFFC9C5BA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size(100, 150), // Set the desired height and width
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/feedback.png', // Replace with the path to your image
              width: 70,
              height: 70,
            ),
            SizedBox(height: 8),
            Text(
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
)

,

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
              'Survey',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

                      // Display the count of unanswered survey questions
                      Text(
                        'Number of Unanswered Questions: $unansweredQuestionsCount',
                        style: const TextStyle(fontSize: 16),
                      ),

            // Add designed buttons for forms and help
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button press for forms
                    Navigator.pushNamed(context, '/forms'); // Replace '/forms' with your actual route
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF97B1A6), // Choose your preferred color
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
                    Navigator.pushNamed(context, '/help'); // Replace '/help' with your actual route
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF698996), // Choose your preferred color for the "Help" button
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
      backgroundColor: const Color.fromARGB(255, 226, 226, 226),
    );
  }
}
