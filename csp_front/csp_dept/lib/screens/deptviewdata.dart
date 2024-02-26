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
        backgroundColor: Colors.teal[400],
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: Center(
              child: Text(
                'DATA SECTION',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          backgroundColor: Colors.teal[400],
        ),
        body: DataTable(columns: <DataColumn>[
          DataColumn(label: Text('Answer_entry_id')),
          DataColumn(label: Text('Id _number')),
          DataColumn(label: Text('Question')),
          // DataColumn(label: Text('Answer')),
          // DataColumn(label: Text('Time_Submit')),
        ], rows: <DataRow>[
          DataRow(cells: <DataCell>[
            DataCell(Text(citizen1.name)),
            DataCell(Text(citizen1.occupation)),
            DataCell(Text(citizen1.address)),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text(citizen2.name)),
            DataCell(Text(citizen2.occupation)),
            DataCell(Text(citizen2.address)),
          ]),
          DataRow(cells: <DataCell>[
            DataCell(Text(citizen3.name)),
            DataCell(Text(citizen3.occupation)),
            DataCell(Text(citizen3.address)),
          ]),
        ]));
  }
}
