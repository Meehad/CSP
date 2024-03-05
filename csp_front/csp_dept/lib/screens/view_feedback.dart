import 'dart:convert';
import 'package:csp_dept/models/viewfeed_data.dart';
import 'package:csp_dept/models/viewfeed_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ViewFeedback extends StatefulWidget {
  const ViewFeedback({Key? key}) : super(key: key);

  @override
  State<ViewFeedback> createState() => _ViewFeedbackState();
}

class _ViewFeedbackState extends State<ViewFeedback> {
  Client client = http.Client();
  // double rating = 3.0;
  List<FeedModel> feedbacks = [];

  @override
  void initState() {
    super.initState();
    _retrieveFeedbacks();
    final postFeed = Provider.of<FeedClass>(context, listen: false);
    postFeed.getPostData();
  }

  _retrieveFeedbacks() async {
    feedbacks = [];
    List response = jsonDecode((await client.get(showfeeds)).body);
    for (var element in response) {
      feedbacks.add(FeedModel.fromJson(element));
    }
    setState(() {});
  }

  Widget _buildFeedbackCard(
      String id, String en, double r, String f, String d) {
    return Card(
      elevation: 3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(
          id,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            en,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RatingBar.builder(
            initialRating: r,
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
                r = newRating;
              });
            },
            ignoreGestures: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            f,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        const SizedBox(
          height: 5,
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            d,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
      ]),
    );
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: feedbacks.length,
      itemBuilder: (context, index) {
        double rate = double.parse(feedbacks[index].rating);
        return _buildFeedbackCard(
            feedbacks[index].id_number,
            feedbacks[index].event_name,
            rate,
            feedbacks[index].feed,
            feedbacks[index].date);
      },
    );
  }
}
