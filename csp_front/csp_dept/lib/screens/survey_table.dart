import 'dart:convert';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/survey_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SurveyTable extends StatelessWidget {
  const SurveyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SurveyModel>>(
      future: _retrieveSurvey(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<SurveyModel>? responses = snapshot.data;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: responses != null && responses.isNotEmpty
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
                : Center(
                    child: LottieBuilder.asset(
                      height: 500,
                      width: 400,
                      'assets/emptyDB.json',
                    ),
                  ),
          );
        }
      },
    );
  }

  Future<List<SurveyModel>> _retrieveSurvey(BuildContext context) async {
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    List<SurveyModel> responses = [];
    try {
      final response = await http.get(showans(postModel.post?.name ?? ""));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        responses = responseData
            .map((element) => SurveyModel.fromJson(element))
            .toList();
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
    return responses;
  }
}
