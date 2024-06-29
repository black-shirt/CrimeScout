import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:crime_scout/Screens/requests.dart';
import 'package:crime_scout/Screens/specific.dart';
import 'package:flutter/material.dart';
import 'map.dart';
import 'package:http/http.dart' as http;
import 'notifications.dart';


class HomeScreen extends StatefulWidget
{
  String userEmail;
  HomeScreen({super.key, required this.userEmail});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>
{

  Widget bodyContent = const HomeScreenMap();
  int index = 1;
  String appBarTitle = "Track Crimes";
  String userType = "";
  bool _isLoading = true;

  void getUserType() async
  {
    final response = await http.get(
      Uri.parse(
          'https://2uzjt8n986.execute-api.ap-south-1.amazonaws.com/prod/getUserType?email=${widget.userEmail}'),
    );
    final responseBody = await jsonDecode(response.body);
    userType = responseBody["type"];
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getUserType();
    super.initState();
  }

  void _openNotificationScreen()
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Notifications(),));
  }


  @override
  Widget build(BuildContext context) {
    if(index == 0) {
      if(userType == 'C')
      {
        appBarTitle="My Reports";
      }
      else {
        appBarTitle = "IoT Alerts";
      }
    } else if(index == 1)
      {
        appBarTitle="Reported Crimes";
      }
    else if(index == 2) {
      if(userType == 'C')
        {
          appBarTitle = "Add Report";
        }
      else {
        appBarTitle = "Review Reports";
      }
    }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade400,
          title: Text(appBarTitle,style: const TextStyle(color: Colors.white)),
          // actions: [
          //   IconButton(
          //       onPressed: _openNotificationScreen,
          //       icon: const Icon(Icons.notifications_none_rounded,color: Colors.white,size: 27,))
          // ],
        ),



        body: _isLoading? const Center(child: CircularProgressIndicator(),) : bodyContent,

        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.textIn,
          initialActiveIndex: 1,
          items:  [
            TabItem(icon: userType =='C'?Icons.account_circle : Icons.camera_alt_outlined, title: userType =='C'?'Requests': 'Alerts'),
            const TabItem(icon: Icons.map, title: "Map"),
            TabItem(icon: userType == 'C'? Icons.add_box_rounded: Icons.pending_actions, title: userType =='C'?"Add": "Review"),
          ],
          onTap: (localIndex) {
            if(localIndex == 0)
            {
              setState(() {
                index = 0;
                bodyContent =  Requests(userEmail: widget.userEmail, userType: userType,);
              });
            }
            else if(localIndex == 1)
            {
              setState(() {
                index = 1;
                bodyContent =  const HomeScreenMap();
              });
            }
            if(localIndex == 2)
            {
              setState(() {
                index = 2;
                bodyContent =  UserSpecificFeature(userEmail: widget.userEmail, userType: userType,);
              });
            }
          },
        ),
      );
    }
  }
