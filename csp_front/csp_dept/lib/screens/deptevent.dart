import 'package:csp_dept/screens/event_publish.dart';
import 'package:csp_dept/screens/view_feedback.dart';
import 'package:flutter/material.dart';

class deptevent extends StatelessWidget {
  const deptevent({super.key});

  @override
  Widget build(BuildContext context) {
    TabController? _controller;
    return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("CSP EVENT"),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _controller,
              tabs: [
                Container(
                  width: 86,
                  child: Tab(text: 'Event Publish'),
                ),
                Container(
                  width: 86,
                  child: Tab(text: 'Event Feedback'),
                ),
              ],
            ),
          ),
          body: TabBarView(controller: _controller, children: const [
            Event_publish(),
            ViewFeedback(),
          ]),
          backgroundColor: Colors.lightBlueAccent,
        ));
  }
}
