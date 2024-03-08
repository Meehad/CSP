import 'dart:convert';
import 'package:csp_citizen/models/feedback_data.dart';
import 'package:csp_citizen/models/feedback_model.dart';
import 'package:csp_citizen/models/user_data.dart';
import 'package:csp_citizen/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

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
  }

  _retrieveEvents() async {
    events = [];
    List response = jsonDecode((await client.get(showEvents)).body);
    for (var element in response) {
      events.add(EventModel.fromJson(element));
    }
    setState(() {});
  }

  _submitFeedback(int ind, String event_name, double rate) async {
    try {
      final postModel = Provider.of<DataClass>(context, listen: false);
      postModel.getPostData();
      Response res = await post(postfeed, body: {
        'id_number': postModel.post?.id_number ?? "",
        'event_name': event_name,
        'feed': feedbackControllers[ind].text,
        'rating': rate.toString(),
      });
      if (res.statusCode == 201) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[300],
                title: const Text('CSP'),
                content: const Text('Success!'),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        events.removeAt(ind);
                      });
                    },
                    child: const Text('ok'),
                  )
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[300],
                title: const Text('CSP'),
                content: const Text('Failed!'),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok'),
                  )
                ],
              );
            });
      }
      FocusScope.of(context).unfocus();
    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildFeedbackCard(String imagePath, String title, String description, String date, int ind) {
  DateTime apiDate = DateTime.parse(date);
  String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          child: Image.network(
            "http://10.0.2.2:8000$imagePath",
            height: 200,
            width: double.infinity, // Adjust the width to fill the card
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF698996), // Adjust the color as needed
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
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
                  SizedBox(width: 8),
                  Text(
                    rating.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 8),
              TextField(
                controller: feedbackControllers[ind],
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Enter your feedback here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  _submitFeedback(ind, title, rating);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color(0xFF698996),
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            feedbackControllers.add(TextEditingController());
            return _buildFeedbackCard(
                events[index].event_img,
                events[index].event_name,
                events[index].event_details,
                events[index].date,
                index);
          },
        ),
      ),
      // backgroundColor: const Color(0xFF97B1A6),
    );
  }
}
