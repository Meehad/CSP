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

class DeptViewData extends StatefulWidget {
  const DeptViewData({Key? key}) : super(key: key);

  @override
  State<DeptViewData> createState() => _DeptViewDataState();
}

class _DeptViewDataState extends State<DeptViewData> {
  Client client = http.Client();
  List<SurveyModel> responses = [];

  @override
  void initState() {
    super.initState();
    _retrieveSurvey();
    final getSurvey = Provider.of<SurveyClass>(context, listen: false);
    getSurvey.getPostData();
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
  }

  _retrieveSurvey() async {
    responses = [];
    List response = jsonDecode((await client.get(showans)).body);
    for (var element in response) {
      responses.add(SurveyModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              'DATA SECTION',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
      ),
      body: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
              dataTextStyle: TextStyle(fontStyle: FontStyle.normal),
              columns: <DataColumn>[
                DataColumn(label: Text('ID Number')),
                DataColumn(label: Text('Question')),
                DataColumn(label: Text('Answer')),
                DataColumn(label: Text('Date submitted')),
              ],
              rows: responses.map((r) {
                DateTime apiDate = DateTime.parse(r.time_sub);
                String formattedDate = DateFormat('yyyy-MM-dd').format(apiDate);
                return DataRow(
                  cells: [
                    DataCell(Text(r.id_number)),
                    DataCell(Text(r.question)),
                    DataCell(Text(r.answer)),
                    DataCell(Text(formattedDate)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
