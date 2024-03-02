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

class DeptViewData extends StatefulWidget {
  const DeptViewData({Key? key}) : super(key: key);

  @override
  State<DeptViewData> createState() => _DeptViewDataState();
}

class _DeptViewDataState extends State<DeptViewData> {
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
    name: "Shaheel kotta",
    age: 21,
    dob: "10/05/2003",
    address: "Pokottur",
    occupation: "NULL",
    aadhaarNo: "5678-9012-3456",
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
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Card(
        elevation: 8.0,
        margin: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
              dataTextStyle: TextStyle(fontStyle: FontStyle.normal),
              columns: <DataColumn>[
                DataColumn(label: Text('Answer Entry ID')),
                DataColumn(label: Text('ID Number')),
                DataColumn(label: Text('Question')),
              ],
              rows: <DataRow>[
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
                DataRow(cells: <DataCell>[
                  DataCell(Text(citizen4.name)),
                  DataCell(Text(citizen4.occupation)),
                  DataCell(Text(citizen4.address)),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
