// ignore_for_file: non_constant_identifier_names

class FeedModel {
  final String id_number;
  final String event_name;
  final String feed;
  final String rating;
  final String date;

  FeedModel(
      {
        required this.id_number,
        required this.event_name,
        required this.feed,
        required this.rating,
        required this.date
      });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id_number: json['id_number'] ?? "",
      event_name: json['event_name'] ?? "",
      feed: json['feed'] ?? "",
      rating: json['rating'] ?? "",
      date: json['date_marked'] ?? "");
  }
  Map<String, dynamic> toMap() {
    return {
      'id_nmuber': id_number,
      'event_name': event_name,
      'feed': feed,
      'rating': rating,
      'date_marked': date,
    };
  }
}

class AvgFeedModel {
  final String event_name;
  final String? avg_rating;

  AvgFeedModel(
      {
        required this.event_name,
        required this.avg_rating,
      });

  factory AvgFeedModel.fromJson(Map<String, dynamic> json) {
    return AvgFeedModel(
      event_name: json['event_name'] ?? "",
      avg_rating: json['avg_rating'] ?? "",);
  }
  Map<String, dynamic> toMap() {
    return {
      'event_name': event_name,
      'avg_rating': avg_rating,
    };
  }
}