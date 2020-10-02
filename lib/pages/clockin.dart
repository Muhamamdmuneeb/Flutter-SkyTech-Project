import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:skytech/database/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:skytech/model/add_user_dataInfo.dart';
import 'package:skytech/model/getId.dart';
import 'package:skytech/model/userdetail.dart';
import 'package:skytech/model/userlocation.dart';
import 'package:skytech/pages/clockout.dart';
import './tablepage.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
class ClockIn extends StatefulWidget {
  final data;
  ClockIn({
    this.data
  });
  @override
  _ClockInState createState() => _ClockInState();
}

class _ClockInState extends State<ClockIn> {
  String _deviceid = 'Unknown';
  var userdetailadd = UserDetail();

  var firstname;
  var lastname;
  var empid;
  var deviceid;
  var clockinTime;
  Location location = Location();
  UserLocation _currentLocation;
  UserLocation userPosition;
StreamSubscription<LocationData> positionSubscription;
  String _timeString;
 DateFormat dateFormat = DateFormat("dd-MM-yyyy");
String datestring;
  @override
  void initState() {
    super.initState();
    initDeviceId();
    gettime();
    datestring = dateFormat.format(
  DateTime.now()
  );
  
    positionSubscription = location
      .onLocationChanged
      .handleError((error) => print(error))
      .listen(
        (newPosition) => setState(() {
          _currentLocation = UserLocation(
            latitude: newPosition.latitude,
            longitude: newPosition.longitude,
          );
        }),
      );

  }
  var loader=true;
  var services;
  void gettime()async{
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    http.Response response = await http.get('http://worldtimeapi.org/api/timezone/$currentTimeZone');
    Map data=jsonDecode(response.body);
    setState(() {
      clockinTime=data['datetime'].substring(11,19);
    });


  }

  @override
void dispose() {
  positionSubscription?.cancel();
  super.dispose();
}


void initDeviceId() async {

  String deviceid1;
  deviceid1 = await DeviceId.getID;
    services = await  getId().getid(deviceid1);
    print(services.toString()+"check services");
    SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        firstname= services['firstname'];
        lastname=services['lastname'];
        empid=services['empid'];
        deviceid=services['deviceid'];
        loader=false;
      });

    await prefs.setString('firstname',firstname);
    await prefs.setString('lastname', lastname);
    await prefs.setString('empid', empid);
    await prefs.setString('deviceid', deviceid);


  }
  @override
  Widget build(BuildContext context) {



    var media = MediaQuery.of(context).size.height / 100;
    var mediaWidth = MediaQuery.of(context).size.width / 100;
  
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 227, 227,1),
      body: loader==true?Center(child: CircularProgressIndicator(),):ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 9 * media,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit:BoxFit.fitHeight,

              ),
            ),
          ),
          SizedBox(
            height: 2 * media,
          ),
          Center(
              child: Text(
            'Profile Found',
            style: GoogleFonts.fredokaOne(
                fontSize: 4.6 * media,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.7 * media),
          )),
          SizedBox(
            height: 4.7 * media,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                lastname!=null?'$lastname,':"XYZ",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media, letterSpacing: 0.7 * media),
              ),  Text( firstname!=null?firstname:"XYZ",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media, letterSpacing: 0.7 * media),
              ),
            ],
          ),
          SizedBox(height: 2.2 * media),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ID# :  ',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
              Text(
                empid!=null?empid:"XYZ",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media, letterSpacing: 0.7 * media),
              )
            ],
          ),
          SizedBox(height: 2.2 * media),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Device ID:  ',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
              Flexible(
                child: Text(
                  deviceid!=null?deviceid:"XYZ",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 2.2 * media, letterSpacing: 0.7 * media),
                ),
              )
            ],
          ),
          SizedBox(height: 2.2 * media),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Current Date: ',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
              Text(
                '$datestring',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media, letterSpacing: 0.7 * media),
              )
            ],
          ),

          SizedBox(height: 2.2 * media),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Latitude:',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
            _currentLocation!=null?
              Text(
                 '${_currentLocation.latitude}',   style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media, letterSpacing: 0.7 * media),) : Text('Waiting Latitude'),
             
              
            ],
          ),
          SizedBox(height: 2.2 * media),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Longitude:',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
               _currentLocation!=null?
              Text(
                 '${_currentLocation.longitude}',   style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media, letterSpacing: 0.7 * media),) : Text('Waiting Latitude'),
            ],
          ),
          SizedBox(height: 2.2 * media),
          InkWell(
            onTap: () async{
               gettime();

                  Map<String,dynamic> data={

                    'firstname': firstname,
        'lastname':lastname,
        'empid' : empid,
        'deviceid' : deviceid,
        'clockindate' : datestring,
        'clockintime' : clockinTime,
        'clockinlat' : _currentLocation.latitude.toString(),
        'clockinlong' : _currentLocation.longitude.toString(),
        'clockoutdate' : "",
        'clockouttime' : "",
        'clockoutlat' : "",
        'clockoutlong' : "",
        'totaltime':"",
         'check':false
                  };
     var result = await addUserInfo().addUserData(data);
                             if(result ==200) {
                              SharedPreferences prefs = await SharedPreferences.getInstance();

                              await prefs.setString('clockintime', clockinTime);
                              await prefs.setString('clockindate', datestring);
                              await prefs.setString('clockinlat', _currentLocation.latitude.toString());
                              await prefs.setString('clockinlong', _currentLocation.longitude.toString());
                                print(result.toString() + 'id check');   
                              Fluttertoast.showToast(msg: "Data Save Sucessfully");
                                Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ClockOut(checkdata: true,)));
                             }
                             else{
                               Fluttertoast.showToast(msg: "Not save");
                             }
                           print(result);
                           
                         
                  },
                         
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 18 * media,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xff29ffc6), Color(0xff20e3b2)]),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                      Radius.circular(20) //         <--- border radius here
                      ),
                ),
                child: Center(
                  child: Text(
                    'Clock In',
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 4.4 * media,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7 * media),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.2 * media),
          Center(
            child: OutlineButton(
                borderSide: BorderSide(color: Colors.blue),
                shape: StadiumBorder(),
                onPressed: (){
                     Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TablePage()));
                },
                child: Text(
                  'Show Log',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.blue,
                      fontSize: 2.9 * media,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7 * media),
                )),
          )
        ],
      ),
    );
  }

void getdata() async{
print(widget.data.toString());
}
 
}

