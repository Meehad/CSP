// ignore_for_file: non_constant_identifier_names

class UserModel {
  final String name;
  final String id_number;
  final String phone_number;
  final String image;
  final String date_of_birth;

  UserModel(
      {
      required this.name,
      required this.id_number,
      required this.phone_number,
      required this.image,
      required this.date_of_birth});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
        id_number: json['id_number'] ?? "",
        phone_number: json['phone_number'] ?? "",
        image: json['image'] ?? "",
        date_of_birth: json['date_of_birth'] ?? "");
  }
}
