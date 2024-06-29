import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportDetailsPage extends StatelessWidget {

  final String crimeType;
  final String reportID;
  final String crimeDescription;
  final String address;
  final String email;
  final latitude;
  final longitude;
  final status;
  final isAuthority;


  const ReportDetailsPage({super.key, required this.email, required this.address, required this.crimeDescription, required this.crimeType, required this.longitude, required this.latitude, required this.status, required this.isAuthority, required this.reportID});

  void approveRequest(bool isAccepted, String reportID) async
  {
    var status = isAccepted? 2: 0;
    final response = await http.get(
      Uri.parse(
          'https://2uzjt8n986.execute-api.ap-south-1.amazonaws.com/prod/change-report-status?reportID=$reportID&status=$status'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (status == 2) const Text(
                  'Approved',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                SizedBox(height: 10,),
                Text(
                  'Crime Type: $crimeType',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  crimeDescription,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Address:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  address,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  email,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
            Text(
              'Latitude: $latitude, Longitude: $longitude',
              style: TextStyle(fontSize: 16),
            ),
                SizedBox(height: 20),
                if(isAuthority && status != 2)Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        approveRequest(true, reportID);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Accepted")));
                      },
                      child: Text('Accept', style: TextStyle(color: Colors.green),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        approveRequest(false, reportID);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Denied")));
                      },
                      child: Text('Deny', style: TextStyle(color: Colors.red),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
