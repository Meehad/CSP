import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      body:
      Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
           Column(
  children: [
    Column(
  children: [
    ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/complaint');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.report, size: 30, color: Color.fromARGB(255, 44, 44, 44)),
          SizedBox(width: 8),
          Text(
            'Report a Complaint',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 40),
    ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/survey');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.poll, size: 30, color: Color.fromARGB(255, 48, 48, 48)),
          SizedBox(width: 8),
          Text(
            'Take a Survey',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 48, 48, 48),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 40),
    ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/feedback');
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.feedback, size: 30, color: Color.fromARGB(255, 45, 45, 45)),
          SizedBox(width: 8),
          Text(
            'Provide Feedback',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 48, 48, 48),
            ),
          ),
        ],
      ),
    ),
    const SizedBox(height: 40),
     CarouselSlider(
              options: CarouselOptions(
                height: 300.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.9,
              ),
              items: [
                // Add your image items here
                Image.network('https://www.mediaoneonline.com/h-upload/2023/11/17/1397946-navakerala-sadass.webp', fit: BoxFit.cover),
                Image.network('https://img.etimg.com/thumb/width-640,height-480,imgsize-99240,resizemode-75,msid-94473942/news/politics-and-nation/bharat-jodo-yatra-enters-malappuram-in-kerala/rahul-gandhi-resumes-bharat-jodo-yatra-from-aluva-uc-college-in-kerala.jpg', fit: BoxFit.cover)
                
              
                // Add more images as needed
              ],)
  ],
)
  
  ],
)

        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      backgroundColor: Colors.green,
      
       
    )
    ;
  }
}
