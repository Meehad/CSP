// ignore_for_file: non_constant_identifier_names

class SurveyQModel {
  final String name;
  final String question;
  final bool is_options;
  final List<String> options;
  final String time;

  SurveyQModel({
    required this.name,
    required this.question,
    required this.is_options,
    required this.options,
    required this.time,
  });

  factory SurveyQModel.fromJson(Map<String, dynamic> json) {
    return SurveyQModel(
      name: json['name'] ?? "",
      question: json['question'] ?? "",
      is_options: json['is_options'] ?? false,
      options: List<String>.from(json['options'] ?? []),
      time: json['time'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'question': question,
      'is_options': is_options,
      'options': options,
      'time': time,
    };
  }
}