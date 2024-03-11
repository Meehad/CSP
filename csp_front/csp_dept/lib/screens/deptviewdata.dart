import 'package:csp_dept/screens/survey_chart.dart';
import 'package:csp_dept/screens/survey_table.dart';
import 'package:flutter/material.dart';

class Deptview extends StatefulWidget {
  const Deptview({super.key});

  @override
  State<Deptview> createState() => _DeptviewState();
}

class _DeptviewState extends State<Deptview> {
  @override
  Widget build(BuildContext context) {
    {
      TabController? controller;
      return DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Padding(
                padding: EdgeInsets.only(right: 55),
                child: Center(child: Text(" DATA SECTION")),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: const Color.fromARGB(255, 226, 226,
                    226), // Color of the indicator for the active tab
                unselectedLabelStyle: const TextStyle(color: Color(0xFFC9C5BA)),
                labelColor: const Color.fromARGB(255, 226, 226, 226),
                indicatorSize: TabBarIndicatorSize.tab,
                controller: controller,
                tabs: const [
                  SizedBox(
                    width: 86,
                    child: Tab(text: 'Table'),
                  ),
                  SizedBox(
                    width: 86,
                    child: Tab(text: 'Chart'),
                  ),
                ],
              ),
            ),
            body: TabBarView(controller: controller, children: const [
              SurveyTable(),
              Survey_chart(),
            ]),
          ));
    }
  }
}
