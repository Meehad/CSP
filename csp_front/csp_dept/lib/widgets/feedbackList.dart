// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'package:csp_dept/models/viewfeed_data.dart';
import 'package:csp_dept/models/viewfeed_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EventDetailPage extends StatefulWidget {
  final String event_name;

  const EventDetailPage({super.key, required this.event_name});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  Client client = http.Client();
  List<FeedModel> feedbacks = [];

  @override
  void initState() {
    super.initState();
    _retrieveFeedbacks();
    final postFeed = Provider.of<FeedClass>(context, listen: false);
    postFeed.getPostData(widget.event_name);
  }

  _retrieveFeedbacks() async {
    feedbacks = [];
    List response =
        jsonDecode((await client.get(showfeeds(widget.event_name))).body);
    for (var element in response) {
      feedbacks.add(FeedModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedbacks'),
      ),
      body: feedbacks.isNotEmpty
          ? ListView.builder(
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                double ir = double.parse(feedbacks[index].rating);
                DateTime apiDate = DateTime.parse(feedbacks[index].date);
                String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 12),
                        Text(
                          'USER ID: ${feedbacks[index].id_number}_$index',
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
                            'Event Name: ${feedbacks[index].event_name}',
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(thickness: 1, color: Colors.grey),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("User Rating :"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RatingBar.builder(
                                initialRating: ir,
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
                                  // This callback is not required in this context
                                },
                                ignoreGestures: true,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Feedback: ${feedbacks[index].feed}',
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Date: $formattedDate',
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                );
              },
            )
          : LottieBuilder.asset(height: 500, width: 400, 'assets/emptyDB.json'),
    );
  }
}
