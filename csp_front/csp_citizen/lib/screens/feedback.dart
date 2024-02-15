import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double rating = 3.0; // Default rating value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Feedback'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeedbackCard(
                'assets/rahul.jpg',
                'Rahul\'s Image',
                'Description for Rahul\'s Image',
              ),
              const SizedBox(height: 16),
              // Additional cards
              _buildFeedbackCard(
                'assets/oppie.jpg',
                'The development of the atomic bomb',
                'Description for Image 2',
              ),
              const SizedBox(height: 16),
              _buildFeedbackCard(
                'assets/Navakerala.jpg',
                'NavaKerala',
                'Description for Image 3',
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
    );
  }

  Widget _buildFeedbackCard(
      String imagePath, String title, String description) {
    return Card(
      elevation: 3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Image.asset(
          imagePath,
          height: 150, // Adjust the height as needed
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RatingBar.builder(
            initialRating: rating,
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
              setState(() {
                rating = newRating;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            description,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter your feedback here...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
          width: 50,
        ),
        // ignore: unnecessary_const
        ElevatedButton(
          onPressed: () {

            // Add logic to submit feedback for this card
            // ignore: avoid_print
            print('Feedback submitted for $title');
          },
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 58, 58, 58), // Background color
            onPrimary: const Color.fromARGB(255, 213, 213, 213), // Text color
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  2), // Adjust the border radius as needed
            ),
          ),
          child: const Text(
            'Submit Feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: FeedbackPage(),
  ));
}
