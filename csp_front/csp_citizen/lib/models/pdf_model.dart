// pdf_model.dart

// ignore_for_file: non_constant_identifier_names, camel_case_types

class pdfModel {
  final String title;
  final String pdf_file;
  final int id;

  pdfModel({
    required this.title,
    required this.pdf_file,
    required this.id,
  });

  factory pdfModel.fromJson(Map<String, dynamic> json) {
    return pdfModel(
      title: json['title'] ?? "",
      pdf_file: json['pdf_file'] ?? "",
      id: json['id'] ?? 0, // Assume default value is 0 for id
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'pdf_file': pdf_file,
      'id': id,
    };
  }
}
