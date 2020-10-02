import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skytech/model/add_user_data.dart';
import 'package:skytech/model/profile.dart';
import 'package:skytech/pages/clockin.dart';
import '../database/services.dart';
import 'package:device_id/device_id.dart';
class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var dataadd=ProfilePage();

  final formKey = GlobalKey<FormState>();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController empid = TextEditingController();
   var value;
 String _deviceid = 'Unknown';
@override
  void initState() {
  
    super.initState();
    initDeviceId();
    }

  Future<void> initDeviceId() async {
    String deviceid;
    deviceid = await DeviceId.getID;
    try {} on PlatformException catch (e) {
      print(e.message);
    }
 if (!mounted) {
return;
 }
    setState(() {
      _deviceid = '$deviceid';
    });
      
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size.height / 100;
    var mediaWidth = MediaQuery.of(context).size.width / 100;
   
    return Scaffold(
        body: ListView(children: [
      SizedBox(height: 15 * media),
      Center(
          child: Text(
        'Create Profile',
        style: GoogleFonts.fredokaOne(
            fontSize: 3.6 * media,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.7 * media),
      )),
      SizedBox(height: 2.9 * media),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 8.8 * media),
              TextFormField(
                  controller: firstname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First Name Is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "First Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.8 * mediaWidth,
                      ),
                    ),
                  )),
              SizedBox(height: 1.4 * media),
              TextFormField(
                  controller: lastname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last Name Is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.8 * mediaWidth,
                      ),
                    ),
                  )),
              SizedBox(height: 1.4 * media),
              TextFormField(
                  controller: empid,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Employee ID Is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Employee ID #",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.8 * mediaWidth,
                      ),
                    ),
                  )),
              SizedBox(height: 8.4 * media),
              GradientButton(
                elevation: 2,
                increaseWidthBy: 31.7 * mediaWidth,
                increaseHeightBy: 2.9 * media,
                child: Text('Submit',
                    style: GoogleFonts.lato(
                        fontSize: 3.6 * media, fontWeight: FontWeight.bold)),
                callback: () async {
                    Map<String,dynamic>data={
                      'firstname' :firstname.text.trim(),
                      'lastname' :lastname.text.trim(),
                      'empid' :empid.text.trim(),
                      'deviceid' :  _deviceid
                    };
                  if (formKey.currentState.validate()) {
                     var result = await addData().addUserData(data);
                             if(result==200){
                               SharedPreferences prefs = await SharedPreferences.getInstance();
                               await prefs.setString('firstname',firstname.text.trim());
                               await prefs.setString('lastname', lastname.text.trim());
                               await prefs.setString('empid', empid.text.trim());
                               await prefs.setString('deviceid', _deviceid);
                              Fluttertoast.showToast(msg: "SignUp Successfully");
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (context)=>ClockIn(
                                    
                                )
                              ));
                             }
                             else{
                               Fluttertoast.showToast(msg: "Not SignUp");
                             }
                           print(result);
                           }
                         
                  },
                
                gradient: Gradients.buildGradient(
                  AlignmentDirectional.topStart,
                  AlignmentDirectional.bottomEnd,
                  <Color>[
                    Color(0xFF8b41f2),
                    Color(0xFFa96bff),
                    Color(0xFF8b41f2),
                  ],
                ),
                shadowColor:
                    Gradients.backToFuture.colors.last.withOpacity(0.25),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
