import 'dart:convert';

import 'package:crime_scout/Screens/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Requests extends StatefulWidget
{
  final userEmail;
  final userType;
  const Requests({super.key, required this.userEmail, required this.userType});

  @override
  State<StatefulWidget> createState() {
    return _RequestsState();
  }
}

class _RequestsState extends State<Requests>
{
  bool _isLoading = true;
  late var reports;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() async
  {
    final response = await http.get(
      Uri.parse(
          'https://2uzjt8n986.execute-api.ap-south-1.amazonaws.com/prod/get-user-reports?email=${widget.userEmail}'),
    );
    reports = await jsonDecode(response.body);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.userType != 'C'?
      Column(
        children: [
          SizedBox(height: 10,),
          Container(
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 7),
            decoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
                    style: BorderStyle.solid,
                    width: 1,
                    color: CupertinoColors.black)
                )
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.add_alert),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                    'Hit and run detected by Sabarmati Cam module',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 23,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 7),
            decoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
                    style: BorderStyle.solid,
                    width: 1,
                    color: CupertinoColors.black)
                )
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.add_alert),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                    'Chances of fight/riots are high in motera! as detected by acoustic sensors',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 23,
          ),
        ],
      )
          :
      _isLoading? const Center(child: CircularProgressIndicator(),):
          SingleChildScrollView(
            child: Column(
              children: [
                ...reports.map((e) =>
                ReportDetailsPage(
                  reportID: e['reportID'],
                  isAuthority: false,
                  status: e['status'],
                  address: e['address'],
                  crimeDescription: e['crimeDescription'],
                  crimeType: e['crimeType'],
                  email: e['userEmail'],
                  latitude: e['lat'],
                  longitude: e['lng'],
                 )
                )
              ],
            ),
          )
    );
  }

}
