// import 'package:csp_dept/screens/survey_chart.dart';
// import 'package:csp_dept/screens/survey_table.dart';
// import 'package:flutter/material.dart';

// class Deptview extends StatefulWidget {
//   const Deptview({super.key});

//   @override
//   State<Deptview> createState() => _DeptviewState();
// }

// class _DeptviewState extends State<Deptview> {
//   @override
//   Widget build(BuildContext context) {
//     {
//       TabController? controller;
//       return DefaultTabController(
//           initialIndex: 0,
//           length: 2,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Padding(
//                 padding: EdgeInsets.only(right: 55),
//                 child: Center(child: Text(" DATA SECTION")),
//               ),
//               bottom: TabBar(
//                 isScrollable: true,
//                 indicatorColor: const Color.fromARGB(255, 226, 226,
//                     226), // Color of the indicator for the active tab
//                 unselectedLabelStyle: const TextStyle(color: Color(0xFFC9C5BA)),
//                 labelColor: const Color.fromARGB(255, 226, 226, 226),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 controller: controller,
//                 tabs: const [
//                   SizedBox(
//                     width: 86,
//                     child: Tab(text: 'Table'),
//                   ),
//                   SizedBox(
//                     width: 86,
//                     child: Tab(text: 'Chart'),
//                   ),
//                 ],
//               ),
//             ),
//             body: TabBarView(controller: controller, children: const [
//               SurveyTable(),
//               Survey_chart(),
//             ]),
//           ));
//     }
//   }
// }

import 'dart:convert';

import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/survey_data.dart';
import 'package:csp_dept/models/survey_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Deptview extends StatefulWidget {
  const Deptview({super.key});

  @override
  State<Deptview> createState() => _DeptviewState();
}

class _DeptviewState extends State<Deptview> {
  Client client = http.Client();
  List<SurveyModel> responses = [];

  @override
  void initState() {
    super.initState();
    _retrieveSurvey();
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    final getSurvey = Provider.of<SurveyClass>(context, listen: false);
    getSurvey.getPostData(postModel.post?.name ?? "");
  }

  _retrieveSurvey() async {
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    responses = [];
    List response = jsonDecode(
        (await client.get(showans(postModel.post?.name ?? ""))).body);
    for (var element in response) {
      responses.add(SurveyModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xFF698996),
          title:
              const Text('Data Section', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8.0,
              margin: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: responses.isNotEmpty
                      ? DataTable(
                          headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                          dataTextStyle:
                              const TextStyle(fontStyle: FontStyle.normal),
                          columns: const <DataColumn>[
                            DataColumn(label: Text('ID Number')),
                            DataColumn(label: Text('Question')),
                            DataColumn(label: Text('Answer')),
                            DataColumn(label: Text('Date submitted')),
                          ],
                          rows: responses.map((r) {
                            DateTime apiDate = DateTime.parse(r.time_sub);
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(apiDate);
                            return DataRow(
                              cells: [
                                DataCell(Text(r.id_number)),
                                DataCell(Text(r.question)),
                                DataCell(Text(r.answer)),
                                DataCell(Text(formattedDate)),
                              ],
                            );
                          }).toList(),
                        )
                      : const Center(
                          child: Text('No data available'),
                        ),
                ),
              ),
            )));
  }
}
