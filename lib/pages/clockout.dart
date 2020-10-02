import 'dart:async';
import 'dart:convert';
import 'package:device_id/device_id.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:skytech/controller/google_sheet_controller.dart';
import 'package:skytech/model/getId.dart';
import 'package:skytech/model/get_key_of_dataInfo.dart';
import 'package:skytech/model/google_sheet.dart';
import 'package:skytech/model/update_user_data.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skytech/database/services.dart';
import 'package:skytech/model/clockoutuserdetail.dart';
import 'package:skytech/model/userlocation.dart';
import 'package:skytech/pages/tablepage.dart';

class ClockOut extends StatefulWidget {
  final checkdata;
  ClockOut({this.checkdata});
  @override
  _ClockOutState createState() => _ClockOutState();
}

class _ClockOutState extends State<ClockOut> {
final StopWatchTimer _stopWatchTimer = StopWatchTimer();
var timer;
  String _deviceid = 'Unknown';


  var firstname;
  var lastname;
  var empid;
  var deviceid;
  var clockintime;
  var clockindate;
  var clockinlat;
  var clockinlong;
  Location location = Location();
  UserLocation _currentLocation;

  UserLocation userPosition;
  StreamSubscription<LocationData> positionSubscription;
  String _timeString;
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  String datestring;
 var clockoutTime;
 var loader=true;
 var key;
  @override
  void initState() {
    super.initState();
    initDeviceId();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    datestring = dateFormat.format(DateTime.now());
    positionSubscription =
        location.onLocationChanged.handleError((error) => print(error)).listen(
              (newPosition) => setState(() {
                _currentLocation = UserLocation(
                  latitude: newPosition.latitude,
                  longitude: newPosition.longitude,
                );
              }),
            );
  }
  var services;
void initDeviceId() async {
    if(widget.checkdata==false){
      if (!mounted) {
        return;
      }
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
        clockintime = prefs.getString('clockintime');
        clockindate = prefs.getString('clockindate');
        clockinlat = prefs.getString('clockinlat');
        clockinlong = prefs.getString('clockinlong');
        loader=false;
      });

      await prefs.setString('firstname',firstname);
      await prefs.setString('lastname', lastname);
      await prefs.setString('empid', empid);
      await prefs.setString('deviceid', deviceid);


    }else{
      if (!mounted) {
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        firstname = prefs.getString('firstname');
        lastname = prefs.getString('lastname');
        empid = prefs.getString('empid');
        deviceid = prefs.getString('deviceid');
        clockintime = prefs.getString('clockintime');
        clockindate = prefs.getString('clockindate');
        clockinlat = prefs.getString('clockinlat');
        clockinlong = prefs.getString('clockinlong');
        loader=false;
      });
    }

  key=await getUserKey().getUserKey1();
}
void gettime()async{
  if (!mounted) {
    return;
  }

  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  http.Response response = await http.get('http://worldtimeapi.org/api/timezone/$currentTimeZone');
  Map data=jsonDecode(response.body);

    clockoutTime=data['datetime'].substring(11,19);


}


  @override
  void dispose() {
    positionSubscription?.cancel();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size.height / 100;
_stopWatchTimer.rawTime.listen((value){
  setState(() {
    timer = StopWatchTimer.getDisplayTime(value);
  });
});

    return Scaffold(
      backgroundColor:  Color.fromRGBO(226, 227, 227,1),
      body: loader==true?Center(child: CircularProgressIndicator(),):ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              height: 9 * media,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height:2* media,
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
                lastname==null?"XYZ":'$lastname,',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    letterSpacing: 0.7 * media),
              ),
              Text(
                firstname==null?"XYZ":firstname,
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
                'ID# : ',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
              Text(
                empid==null?"XYZ":empid,
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
                'Device ID:',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
              Text(
                '$deviceid',
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
              _currentLocation != null
                  ? Text(
                      '${_currentLocation.latitude}',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 2.5 * media, letterSpacing: 0.7 * media),
                    )
                  : Text('Waiting Latitude'),
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
              _currentLocation != null
                  ? Text(
                      '${_currentLocation.longitude}',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 2.5 * media, letterSpacing: 0.7 * media),
                    )
                  : Text('Waiting Latitude'),
            ],
          ),
          SizedBox(height: 2.2 * media),
          InkWell(
            onTap: () async {
             await  gettime();
               SharedPreferences prefs = await SharedPreferences.getInstance();
               await prefs.setString('clockinCheck', 'checkin');
               _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
               Map<String,dynamic> data={
                 'clockoutdate':datestring,
                 'clockouttime':clockoutTime,
                 'clockoutlat':_currentLocation.latitude.toString(),
                 'clockoutlong':_currentLocation.longitude.toString(),
                 'totaltime':timer,
                 'check':true

               };


              var result = await updateUserInfo().updateUserData(key, data);
              if (result > 0) {
                FeedbackForm feedbackForm = FeedbackForm(
                   firstname,
                  lastname,
                  empid,
                  clockintime,
                  clockindate,
                  deviceid,
                  clockinlat.toString(),
                  clockinlong.toString(),
                  datestring,
                  clockoutTime,
                  _currentLocation.latitude.toString(),
                  _currentLocation.longitude.toString().trim(),
                );

                FormController formController = FormController((String response){
                  print("Response: $response");
                  if(response == FormController.STATUS_SUCCESS){
                    //
                    Fluttertoast.showToast(msg: "Feedback Submitted");
                  } else {
                    Fluttertoast.showToast(msg: "Error Occurred!");
                  }
                });



                // Submit 'feedbackForm' and save it in Google Sheet

                formController.submitForm(feedbackForm);
                Fluttertoast.showToast(msg: "Data Save Sucessfully");
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => TablePage()));
              } else {
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
                      colors: <Color>[Color(0xffd15252), Color(0xffff8080)]),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(
                      Radius.circular(20) //         <--- border radius here
                      ),
                ),
                child: Center(
                  child: Text(
                    'Clock Out',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last Clock in at :',
                style: GoogleFonts.robotoCondensed(
                    fontSize: 2.5 * media,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.7 * media),
              ),
              Flexible(
                child: Text(
                  '${clockindate}',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 2.5 * media, letterSpacing: 0.7 * media),
                ),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Flexible(
                child: Text(
                  '${clockintime}',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 2.5 * media, letterSpacing: 0.7 * media),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}
