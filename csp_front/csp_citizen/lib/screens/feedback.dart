import 'dart:convert';
import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/feedback_model.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double rating = 3.0; // Default rating value
  Client client = http.Client();
  List<EventModel> events = [];
  List<TextEditingController> feedbackControllers = [];

  @override
  void initState() {
    _retrieveEvents();
    super.initState();
    final postEvent = Provider.of<EventClass>(context, listen: false);
    postEvent.getPostData();
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
    for (int i = 0; i < events.length; i++) {
      feedbackControllers.add(TextEditingController());
      }
    }


  _retrieveEvents() async {
    events = [];
    List response = jsonDecode((await client.get(showEvents)).body);
    for (var element in response) {
      events.add(EventModel.fromJson(element));
    }
    setState(() {});
  }

  Widget _buildFeedbackCard(
      String imagePath, String title, String description,int index) {
    return Card(
      elevation: 3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Image(
          image: NetworkImage("http://10.0.2.2:8000$imagePath"),
          height: 150, // Adjust the height as needed
          width: 150,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RatingBar.builder(
            initialRating: rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 24.0,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: feedbackControllers[index],
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter your feedback here...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
          width: 50,
        ),
        // ignore: unnecessary_const
        ElevatedButton(
          onPressed: () {
            // Add logic to submit feedback for this card
            print("$title");
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 213, 213, 213),
            backgroundColor:
                const Color.fromARGB(255, 58, 58, 58), // Text color
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  2), // Adjust the border radius as needed
            ),
          ),
          child: const Text(
            'Submit Feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            return _buildFeedbackCard(events[index].event_img,
                events[index].event_name, events[index].event_details,index);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
    );
  }
}
