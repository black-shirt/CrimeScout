import 'package:flutter/material.dart';

class PermissionsDenied extends StatelessWidget
{
  const PermissionsDenied({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off_outlined,size: 50,color: Colors.black,),
          SizedBox(height: 10),
          Text("Please enable GPS service and give",style: TextStyle(color: Colors.black, fontSize: 19)),
          SizedBox(height: 5),
          Text("location permission, and reload",style: TextStyle(color: Colors.black, fontSize: 19)),
          SizedBox(height: 5),
          Text("this screen to use this feature",style: TextStyle(color: Colors.black, fontSize: 19)),
        ],
      ),
    );
  }

}