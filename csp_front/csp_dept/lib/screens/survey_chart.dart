// ignore_for_file: camel_case_types

import 'dart:convert';
import 'dart:math';
import 'package:csp_dept/models/dept_data.dart';
import 'package:csp_dept/models/survey_model.dart';
import 'package:csp_dept/urls.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Survey_chart extends StatefulWidget {
  const Survey_chart({super.key});

  @override
  State<Survey_chart> createState() => _Survey_chartState();
}

class _Survey_chartState extends State<Survey_chart> {
  Client client = http.Client();
  late Future<List<SurveyOptions>> futureSurveyData;

  @override
  void initState() {
    super.initState();
    futureSurveyData = _retrieveSurvey();
  }

  Future<List<SurveyOptions>> _retrieveSurvey() async {
    final postModel = Provider.of<DeptDataClass>(context, listen: false);
    postModel.getPostData();
    final response = await client.get(showop(postModel.post?.name ?? ""));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData
          .map((element) => SurveyOptions.fromJson(element))
          .toList();
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to retrieve survey data: ${response.statusCode}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return [];
    }
  }

  Widget _buildpiechart(List<SurveyOptions> data) {
    int sumOfValues(Map<String, int> map) {
      int sum = 0;
      for (var value in map.values) {
        sum += value;
      }
      return sum;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: data.map((response) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${response.question} (total responses: ${sumOfValues(response.options)})", // Assuming `question` is a property in SurveyOptions
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPieChart(response.options),
                  const SizedBox(height: 20), // Add spacing between charts
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPieChart(Map<String, int> data) {
    List<Color> pieColor = [];
    List<String> options = [];

    Color getRandomColor() {
      Random random = Random();
      List<Color> pieChartColors = const [
        Color(0xFF698996), // Primary color
        Color(0xFF8CA2A8), // Lighter shade
        Color(0xFF97B1A6),
        Color(0xFF4D666E), // Darker shade
        // Add more shades as needed
      ];
      int ind = random.nextInt(pieChartColors.length);
      pieColor.add(pieChartColors[ind]);
      return pieChartColors[ind];
    }

    List<PieChartSectionData> sections = [];

    data.forEach((key, value) {
      sections.add(
        PieChartSectionData(
          titleStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          value: value.toDouble(), // convert int to double
          showTitle: true,
          radius: 70,
          color: getRandomColor(),
        ),
      );
      options.add("$key:$value");
    });

    return SizedBox(
      height: 400, // Set height
      child: Column(
        children: [
          Expanded(
            child: PieChart(
              swapAnimationDuration: const Duration(milliseconds: 750),
              swapAnimationCurve: Curves.easeInOutQuint,
              PieChartData(
                sections: sections,
              ),
            ),
          ),
          SizedBox(
            height: 200, // Set height
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 20, // Adjust width as needed
                    height: 20, // Adjust height as needed
                    color: pieColor[index],
                  ),
                  title: Text(options[index],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SurveyOptions>>(
      future: futureSurveyData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Center(
            child: LottieBuilder.asset(
                height: 500, width: 400, 'assets/emptyDB.json'),
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: _buildpiechart(snapshot.data ?? []));
        }
      },
    );
  }
}
