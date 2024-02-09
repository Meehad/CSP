// class User {
//   final int id;
//   final String name;
//   final String imageUrl;
//   final int phoneNumber;
//   final String dob;

//   User(
//       {required this.id,
//       required this.name,
//       required this.imageUrl,
//       required this.phoneNumber,
//       required this.dob});
// }

// final User currentUser = User(
//     id: 2012022023,
//     name: 'Tyler Durden',
//     imageUrl: 'assets/profile1.jpg',
//     phoneNumber: 9128329110,
//     dob: '21/05/1995');

// List<User> profiles = [
//   currentUser,
// ];

class UserModel {
  final String name;
  final String id_number;
  final String phone_number;
  final String image;
  final String date_of_birth;

  UserModel(
      {required this.name,
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
