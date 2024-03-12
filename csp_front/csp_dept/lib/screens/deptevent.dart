import 'package:csp_dept/screens/event_publish.dart';
import 'package:csp_dept/screens/view_feedback.dart';
import 'package:flutter/material.dart';

class DeptEvent extends StatelessWidget {
  const DeptEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Row(
              children: [
                SizedBox(
                  width: 68,
                ),
                Text("EVENT SECTION"),
              ],
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Color.fromARGB(255, 226, 226, 226),
            unselectedLabelStyle: TextStyle(color: Color(0xFFC9C5BA)),
            labelColor: Color.fromARGB(255, 226, 226, 226),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              SizedBox(
                width: 120,
                child: Tab(text: 'Event Publish'),
              ),
              SizedBox(
                width: 120,
                child: Tab(text: 'Event Feedback'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Event_publish(),
            ViewFeedback(),
          ],
        ),
      ),
    );
  }
}
