import 'dart:convert';
import 'dart:math';
import 'package:crime_scout/Screens/report.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserSpecificFeature extends StatefulWidget
{
  String userEmail;
  String userType;
  UserSpecificFeature({super.key, required this.userEmail, required this.userType});

  @override
  State<StatefulWidget> createState() {
    return _UserSpecificFeatureState();
  }

}

class _UserSpecificFeatureState extends State<UserSpecificFeature> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCrimeType = 'Theft';
  String _crimeDescription = '';
  String _address = '';
  String _stayAnonymous = "F";
  bool _isLoading = true;
  late var reports;

  String generateAlphanumericCode(int length) {
    const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join('');
  }

  @override
  void initState() {
    if(widget.userType != "C")
      {
        _fetchData();
      }
    super.initState();
  }

  void _fetchData() async
  {
    final response = await http.get(
      Uri.parse(
          'https://2uzjt8n986.execute-api.ap-south-1.amazonaws.com/prod/get-reports'),
    );
    reports = await jsonDecode(response.body);
    setState(() {
      _isLoading = false;
    });
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      final response = await http.post(
        body: json.encode(
            {
              "reportID": generateAlphanumericCode(6),
              "crimeDescription": _crimeDescription,
              'address': _address,
              'lat': 23,
              'lng': 73,
              'crimeType': _selectedCrimeType,
              'userEmail': _stayAnonymous == "T"? "Anonymous" : widget.userEmail,
              'status': 1
            }
        ),
        Uri.parse(
            'https://2uzjt8n986.execute-api.ap-south-1.amazonaws.com/prod/add-report'),
      );
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Report Submitted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.userType == 'C'?Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Select Crime Type:', style: TextStyle(fontSize: 17),),
                RadioListTile<String>(
                  title: const Text('Theft'),
                  value: 'Theft',
                  groupValue: _selectedCrimeType,
                  onChanged: (value) {
                    setState(() {
                      _selectedCrimeType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Assault'),
                  value: 'Assault',
                  groupValue: _selectedCrimeType,
                  onChanged: (value) {
                    setState(() {
                      _selectedCrimeType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Riots'),
                  value: 'Riots',
                  groupValue: _selectedCrimeType,
                  onChanged: (value) {
                    setState(() {
                      _selectedCrimeType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Murder'),
                  value: 'Murder',
                  groupValue: _selectedCrimeType,
                  onChanged: (value) {
                    setState(() {
                      _selectedCrimeType = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Hit and Run'),
                  value: 'Hit and Run',
                  groupValue: _selectedCrimeType,
                  onChanged: (value) {
                    setState(() {
                      _selectedCrimeType = value!;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Crime Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _crimeDescription = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _address = value!;
                  },
                ),
                CheckboxListTile(
                  title: Text('Stay Anonymous'),
                  value: _stayAnonymous == "T"? true:false,
                  onChanged: (value) {
                    setState(() {
                      if(value == true)
                        {
                          _stayAnonymous = 'T';
                        }
                      else{
                        _stayAnonymous = 'F';
                      }
                    });
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ):
      _isLoading? const Center(child: CircularProgressIndicator(),):
      SingleChildScrollView(
        child: Column(
          children: [
            ...reports.map((e) =>
                ReportDetailsPage(
                  reportID: e['reportID'],
                  status: e['status'],
                  address: e['address'],
                  crimeDescription: e['crimeDescription'],
                  crimeType: e['crimeType'],
                  email: e['userEmail'],
                  latitude: e['lat'],
                  longitude: e['lng'],
                  isAuthority: true,
                )
            )
          ],
        ),
      )
    );
  }
}
