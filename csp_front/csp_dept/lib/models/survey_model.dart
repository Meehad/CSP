class SurveyModel {
  final String id_number;
  final String question;
  final String answer;
  final String time_sub;

  SurveyModel(
      {required this.id_number,
      required this.question,
      required this.answer,
      required this.time_sub});

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
        id_number: json['id_number'] ?? "",
        question: json['question'] ?? "",
        answer: json['answer'] ?? "",
        time_sub: json['time_sub'] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {
      'id_nmuber': id_number,
      'question': question,
      'answer': answer,
      'time_sub': time_sub,
    };
  }
}
