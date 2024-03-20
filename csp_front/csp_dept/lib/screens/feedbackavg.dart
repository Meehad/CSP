import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Define a data model for the events
class EventAvg {
  String title;
  double averageRating;
  List<String> feedback;

  EventAvg({required this.title, required this.averageRating, required this.feedback});
}

class EventListPage extends StatelessWidget {
  // Sample list of events
  final List<EventAvg> events = [
    EventAvg(
      title: 'Event 1',
      averageRating: 4.5,
      feedback: ['Great event!', 'Could be better.'],
    ),
    EventAvg(
      title: 'Event 2',
      averageRating: 3.8,
      feedback: ['Enjoyed it.', 'Too crowded.'],
    ),
    // Add more events as needed
  ];

  EventListPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index].title),
            subtitle: Row(
              children: [
                const Text('Average Rating: '),
                RatingBar.builder(
                  initialRating: events[index].averageRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 20,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
            onTap: () {
              // Navigate to detail page and pass event index
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(event: events[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EventDetailPage extends StatelessWidget {
  final EventAvg event;

  EventDetailPage({Key? key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title, style: const TextStyle(color: Color.fromARGB(255, 218, 217, 217))),
      ),
      body: ListView.builder(
        itemCount: event.feedback.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Feedback ID: ${event.title}_$index',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Event Name: ${event.title}',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(thickness: 1, color: Colors.grey),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("User Rating :"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RatingBar.builder(
                          initialRating: event.averageRating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 24.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (newRating) {
                            // This callback is not required in this context
                          },
                          ignoreGestures: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Feedback: ${event.feedback[index]}',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Date: ${DateTime.now().toString()}',
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
