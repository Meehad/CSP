import 'package:flutter/material.dart';


class Citizen {
  final String name;
  final int age;
  final String dob;
  final String address;
  final String occupation;
  final String aadhaarNo;

  Citizen({
    required this.name,
    required this.age,
    required this.dob,
    required this.address,
    required this.occupation,
    required this.aadhaarNo,
  });
}

// ignore: camel_case_types
class deptviewdata extends StatefulWidget {
  const deptviewdata({super.key});

  @override
  State<deptviewdata> createState() => _deptviewdataState();
}

// ignore: camel_case_types
class _deptviewdataState extends State<deptviewdata> {


   Citizen citizen1 = Citizen(
      name: "Anshad K",
      age: 21,
      dob: "27/06/2003",
      address: "Mannarmala(PO),679325(PIN)",
      occupation: "NULL",
      aadhaarNo: "1234-5678-9012",
    );

    Citizen citizen2 = Citizen(
      name: "Meehad",
      age: 21,
      dob: "05/12/2003",
      address: "Vaniyambalam",
      occupation: "NULL",
      aadhaarNo: "9876-5432-1098",
    );

    Citizen citizen3 = Citizen(
      name: "Shafad",
      age: 21,
      dob: "10/05/2003",
      address: "Chemmaniyod",
      occupation: "NULL",
      aadhaarNo: "5678-9012-3456",
    );
     Citizen citizen4 = Citizen(
      name: "Wissam",
      age: 21,
      dob: "03/08/2003",
      address: "Wandoor",
      occupation: "NULL",
      aadhaarNo: "2345-6789-0123",
    );

    Citizen citizen5 = Citizen(
      name: "Shaheel Kotta",
      age: 21,
      dob: "12/12/2003",
      address: "Pookottur",
      occupation: "NULL",
      aadhaarNo: "6789-0123-4567",
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: const Color.fromRGBO(146, 245, 142, 1),
      appBar: AppBar(
        title:  const Padding(
          padding: EdgeInsets.only(right: 50.0),
          child: Center(
            child: Text(
              'DATA SECTION',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0), // Add padding to the entire ListView
          children: [
            CitizenCard(citizen1),
            CitizenCard(citizen2),
            CitizenCard(citizen3),
            CitizenCard(citizen4),
            CitizenCard(citizen5),
          ],
        ),
     
    );
  }
}

class CitizenCard extends StatelessWidget {
  final Citizen citizen;

  const CitizenCard(this.citizen);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCitizenDetailsDialog(context, citizen);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Text(citizen.name),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCitizenDetailsDialog(BuildContext context, Citizen citizen) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("CITIZEN DETAILS"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DetailItem("Name", citizen.name),
              DetailItem("Age", citizen.age.toString()),
              DetailItem("DOB", citizen.dob),
              DetailItem("Address", citizen.address),
              DetailItem("Occupation", citizen.occupation),
              DetailItem("Aadhaar No", citizen.aadhaarNo),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                                 primary: Colors.white, // background color
                              onPrimary: Colors.green, // text color
                               elevation: 5, // elevation
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // rounded corners
                                ),
                        ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("CLOSE"),
            ),
          ],
        );
      },
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;

  const DetailItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}