import 'package:csp_citizen/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final postModel = Provider.of<DataClass>(context, listen: false);
    postModel.getPostData();
  }

  Widget build(BuildContext context) {
    final postModel = Provider.of<DataClass>(context);
    // This method is return every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('${widget.title} : ${postModel.post?.name ?? ""}'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person)),
        ],
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 50),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/complaint');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.report,
                              size: 30, color: Color.fromARGB(255, 44, 44, 44)),
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
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.poll,
                              size: 30, color: Color.fromARGB(255, 48, 48, 48)),
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
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 255, 255, 255)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(16)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.feedback,
                              size: 30, color: Color.fromARGB(255, 45, 45, 45)),
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
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        viewportFraction: 0.9,
                      ),
                      items: [
                        // Add your image items here
                        Image.network(
                            'https://images.moneycontrol.com/static-mcnews/2021/04/P-Vijayan-770x433.jpg?impolicy=website&width=770&height=431',
                            fit: BoxFit.cover),
                        Image.network(
                            "https://1.bp.blogspot.com/-FwixDe2oaT0/YNidS5zzGEI/AAAAAAAA7_E/roj_M-86vcEG6wZUM0pSflsFkBBH7M9iwCLcBGAsYHQ/s0/govt-of-kerala-mobile-apps.webp")
                            

                        // Add more images as needed
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ]),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      backgroundColor: Colors.green,
    );
  }
}
