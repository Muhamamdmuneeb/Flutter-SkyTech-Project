import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:skytech/pages/signup.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String _deviceid = 'unknow';
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
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    var media = MediaQuery.of(context).size.height / 100;
    var value;
    var mediaWidth = MediaQuery.of(context).size.width / 100;
   
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("SkyTech"),
            content: Form(
              key: formKey,
              child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Enter the Password';
                  }
                  return null;
                },
                controller: password,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(hintText: 'Enter the password'),
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              Row(
                children: <Widget>[
                  new FlatButton(
                    child: new Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          if (password.text.trim() == 'mqfmdqusz') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'The Password is incorrect');
                          }
                        }
                      },
                      child: new Text("OK"))
                ],
              ),
            ],
          );
        },
      );
    }

    return ListView(
      children: [
        SizedBox(height: 7 * media),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: double.infinity,
            height: 13 * media,
            child: Image.asset(
              'assets/images/logo.jpeg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 8.7 * media),
        Center(
            child: Text(
              'Profile Not Found' ,
              style: GoogleFonts.fredokaOne(
                  fontSize: 3.6 * media,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7 * media),
            )),
        SizedBox(height: 8.7 * media),
        GradientButton(
          elevation: 2,
          increaseWidthBy: 31.7 * mediaWidth,
          increaseHeightBy: 2.9 * media,
          child: Text('Create Profile',
              style: GoogleFonts.lato(
                  fontSize: 2.9 * media, fontWeight: FontWeight.bold)),
          callback: () {
            _showDialog();
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
          shadowColor: Gradients.backToFuture.colors.last.withOpacity(0.25),
        ),
      ],
    );
  }
}
