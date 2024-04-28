import 'dart:convert';
import 'package:csp_dept/models/event_data.dart';
import 'package:csp_dept/models/event_models.dart';
import 'package:csp_dept/screens/deptevent.dart';
import 'package:csp_dept/screens/deptviewdata.dart';
import 'package:csp_dept/screens/drawer.dart';
import 'package:csp_dept/urls.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Depthome extends StatefulWidget {
  const Depthome({super.key});

  @override
  State<Depthome> createState() => _DepthomeState();
}

class _DepthomeState extends State<Depthome> {
  List<EventModel> events = [];
  Client client = http.Client();
  String imagePath = "";
  int i = 0;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _retrieveEvents();

    // Get post data using the DataClass provider
    final postModel = Provider.of<EventClass>(context, listen: false);
    postModel.getPostData();

    final postEvent = Provider.of<EventClass>(context, listen: false);
    postEvent.getPostData();
  }

  _retrieveEvents() async {
    events = [];
    List response = jsonDecode((await client.get(showEvents)).body);
    for (var element in response) {
      events.add(EventModel.fromJson(element));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              'CSP',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const NavBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/survey');
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 90, right: 90, top: 15, bottom: 15),
                child: Text('CREATE FORM', style: TextStyle(fontSize: 20)),
              ),
            ).animate().fadeIn(delay: 1000.ms).scaleY(),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DeptEvent()),
                );
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 65, right: 65, top: 15, bottom: 15),
                child: Text('PUBLISH AN EVENT', style: TextStyle(fontSize: 20)),
              ),
            ).animate().fadeIn(delay: 1200.ms).scaleY(),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Deptview()),
                );
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 105, right: 105, top: 15, bottom: 15),
                child: Text('VIEW DATA', style: TextStyle(fontSize: 20)),
              ),
            ).animate().fadeIn(delay: 1400.ms).scaleY(),
            const SizedBox(height: 60),
            events.isNotEmpty
                ? CarouselSlider(
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
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: [
                      for (int i = 0; i < events.length; i++)
                        Image.network(
                          imageU(events[i].event_img),
                          fit: BoxFit.cover,
                        ),
                    ],
                  )
                : const CircularProgressIndicator(),

            // Dot indicator
            events.isNotEmpty
                ? DotsIndicator(
                    dotsCount: events.length,
                    position: _currentIndex.toInt(),
                    decorator: DotsDecorator(
                      color: Colors.black,
                      size: const Size.square(6.0),
                      activeColor: Colors.white,
                      activeSize: const Size.square(8.0),
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
