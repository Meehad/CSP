// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/viewfeed_data.dart';
import 'package:csp_dept/models/viewfeed_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:csp_dept/widgets/eventfeedCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  Client client = http.Client();
  List<AvgFeedModel> feedbacks = [];

  @override
  void initState() {
    super.initState();
    _retrieveFeedbacks();
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    final postFeed = Provider.of<AvgFeedClass>(context, listen: false);
    postFeed.getPostData(postModel.post?.name ?? "");
  }

  _retrieveFeedbacks() async {
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    feedbacks = [];
    List response = jsonDecode(
        (await client.get(showavgfeed(postModel.post?.name ?? ""))).body);
    for (var element in response) {
      feedbacks.add(AvgFeedModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: feedbacks.length,
        itemBuilder: (context, index) {
          double ir = double.tryParse(feedbacks[index].avg_rating ?? "") ?? 0.0;
          return eventCard(
              event_name: feedbacks[index].event_name, avg_rating: ir);
        },
      ),
    );
  }
}
