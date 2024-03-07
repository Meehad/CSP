// ignore_for_file: non_constant_identifier_names

class EventModel {
  final String event_name;
  final String name;
  final String event_details;
  final String event_img;
  final String date;

  EventModel(
      {required this.event_name,
      required this.name,
      required this.event_details,
      required this.event_img,
      required this.date});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        event_name: json['event_name'] ?? "",
        name: json['name'] ?? "",
        event_details: json['event_details'] ?? "",
        event_img: json['event_img'] ?? "",
        date: json['date'] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'event_name': event_name,
      'event_details': event_details,
      'event_img': event_img,
      'date': date,
    };
  }
}
