// import 'dart:convert';
// import 'package:csp_dept/models/dept_data.dart';
// import 'package:csp_dept/models/survey_data.dart';
// import 'package:csp_dept/models/survey_model.dart';
// import 'package:csp_dept/urls.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class SurveyTable extends StatefulWidget {
//   const SurveyTable({Key? key}) : super(key: key);

//   @override
//   State<SurveyTable> createState() => _SurveyTableState();
// }

// class _SurveyTableState extends State<SurveyTable> {
//   Client client = http.Client();
//   List<SurveyModel> responses = [];

//   @override
//   void initState() {
//     super.initState();
//     _retrieveSurvey();
//     final postModel = Provider.of<DeptDataClass>(context, listen: false);
//     postModel.getPostData();
//     final getSurvey = Provider.of<SurveyClass>(context, listen: false);
//     getSurvey.getPostData(postModel.post?.name ?? "");
//   }

//   _retrieveSurvey() async {
//     final postModel = Provider.of<DeptDataClass>(context, listen: false);
//     postModel.getPostData();
//     responses = [];
//     List response = jsonDecode(
//         (await client.get(showans(postModel.post?.name ?? ""))).body);
//     for (var element in response) {
//       responses.add(SurveyModel.fromJson(element));
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 8.0,
//       margin: const EdgeInsets.all(16.0),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: responses.isNotEmpty?
//           DataTable(
//             headingTextStyle:
//                 const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
//             dataTextStyle: const TextStyle(fontStyle: FontStyle.normal),
//             columns: const <DataColumn>[
//               DataColumn(label: Text('ID Number')),
//               DataColumn(label: Text('Question')),
//               DataColumn(label: Text('Answer')),
//               DataColumn(label: Text('Date submitted')),
//             ],
//             rows: responses.map((r) {
//               DateTime apiDate = DateTime.parse(r.time_sub);
//               String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);
//               return DataRow(
//                 cells: [
//                   DataCell(Text(r.id_number)),
//                   DataCell(Text(r.question)),
//                   DataCell(Text(r.answer)),
//                   DataCell(Text(formattedDate)),
//                 ],
//               );
//             }).toList(),
//           ):const Center(
//                   child: Text('No data available'),
//                 ),
//         ),
//       ),
//     );
//   }
// }
