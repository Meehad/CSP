// ignore_for_file: non_constant_identifier_names

class DeptModel {
  final String name;
  final String dept_id;
  final String head;
  final String image;
  DeptModel(
      {required this.name,
      required this.dept_id,
      required this.head,
      required this.image});

  factory DeptModel.fromJson(Map<String, dynamic> json) {
    return DeptModel(
        name: json['name'] ?? "",
        dept_id: json['dept_id'] ?? "",
        head: json['head'] ?? "",
        image: json['image'] ?? "");
  }
}
