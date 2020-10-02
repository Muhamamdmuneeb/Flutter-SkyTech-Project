import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skytech/model/get-user_data_by_id.dart';
import 'package:skytech/model/getId.dart';
import 'package:skytech/pages/clockincheck.dart';
import 'package:skytech/pages/homepage.dart';
import './pages/clockin.dart';
import './database/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var services;
  var check;
  var value=0;
  String _deviceid = 'unknow';
  @override
  void initState() {
    super.initState();
   initDeviceId();
    }
      void initDeviceId() async {
      String deviceid;
      deviceid = await DeviceId.getID;
      print(deviceid+"device id");
      var c=await getData().getDataId(deviceid);
      setState(() {
        check=c;
      });

    }


    @override
    Widget build(BuildContext context) {
        if(check==true){
          value=1;
        }else{
          value=2;
        }
      return MaterialApp(

        debugShowCheckedModeBanner: false,
        title: "Sky Tech",
        theme: ThemeData(
          primarySwatch: Colors.blue,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            backgroundColor: Color.fromRGBO(226, 227, 227,1),
          body: value==1 ? ClockinCheck() : HomePage(),
        )
          
        
      );
    }
  
 
}
