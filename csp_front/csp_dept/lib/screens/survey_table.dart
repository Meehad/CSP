import 'dart:convert';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/survey_data.dart';
import 'package:csp_dept/models/survey_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SurveyTable extends StatefulWidget {
  const SurveyTable({super.key});

  @override
  State<SurveyTable> createState() => _SurveyTableState();
}

class _SurveyTableState extends State<SurveyTable> {
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
    try {
      final response = await client.get(showans(postModel.post?.name ?? ""));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        for (var element in responseData) {
          responses.add(SurveyModel.fromJson(element));
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to retrieve survey data: ${response.statusCode}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error retrieving survey data: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: responses.isNotEmpty
          ? DataTable(
              headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.indigo),
              dataTextStyle: const TextStyle(fontStyle: FontStyle.normal),
              columns: const <DataColumn>[
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
            )
          : Center(
              child: LottieBuilder.asset(
                  height: 500, width: 400, 'assets/emptyDB.json')),
    );
  }
}
