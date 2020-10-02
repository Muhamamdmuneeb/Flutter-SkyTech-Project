import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skytech/database/repository.dart';
import '../model/get_data_for_table.dart';
import 'package:skytech/pages/clockin.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  var firstname;
  var lastname;
  var empid;
  var deviceid;
  var loader=true;
@override
  void initState() {
    super.initState();
  initDeviceId();
    }
    void initDeviceId() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
       setState(() {
         firstname = prefs.getString('firstname');
         lastname = prefs.getString('lastname');
         empid = prefs.getString('empid');
         deviceid=  prefs.getString('deviceid');
         loader=false;
       });
      print(deviceid.toString());
    }
    var count=0;

    @override
    Widget build(BuildContext context) {
      var media = MediaQuery.of(context).size.height / 100;
      return Scaffold(
        backgroundColor:  Color.fromRGBO(226, 227, 227,1),
        appBar:PreferredSize(
            preferredSize: Size.fromHeight(100.0), // here the desired height
            child: AppBar(
                    elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white10,
              flexibleSpace:loader==true ?CircularProgressIndicator():Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 5,),
                  Text("Name: "+ firstname, style: TextStyle( fontSize: 15, color: Colors.black),),
                  SizedBox(height: 5,),
                  Text("Device Id: "+deviceid.toString(),style: TextStyle(fontSize: 15,  color: Colors.black),),
                  SizedBox(height: 5,),
                  Text("Employee Id: "+empid.toString(),style: TextStyle( fontSize: 15, color: Colors.black ),),
                ],
              ),
            ),
        ),

        body:FutureBuilder(
          future: GetAllData().getData(deviceid),
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.waiting ) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Center(child: Text("Loading..."));
            }else{
              if(projectSnap.error!=null||projectSnap.data==null){
                return Center(child: Text("No data found"),);
              }else{

                return  ListView.builder(
                  itemCount: projectSnap.data.length,
                  itemBuilder: (context, index) {
                    count++;

                    return Card(
                      color: Colors.deepPurpleAccent ,
                      elevation: 7 ,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ) ,
                      child: ListTile(
                        title: Padding(
                            padding: const EdgeInsets.all(5) ,
                            child: Text("Details "+count.toString() , style: TextStyle(
                                fontFamily: 'Arial Black' , fontWeight: FontWeight
                                .bold , color: Colors.white))) ,
                        subtitle: Column(
                          children: <Widget>[

                            Row(
                              children: <Widget>[
                                Icon(Icons.date_range , color: Colors.white ,) ,
                                Text(" ClockIn Date: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(projectSnap.data[index].clockInDate ,
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,
                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.date_range , color: Colors.white ,) ,
                                Text(" ClockOut Date: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].clockOutDate,
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,


                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,

                            Row(

                              children: <Widget>[
                                Icon(Icons.access_time , color: Colors.white ,) ,
                                Text(" ClockIn Time: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].clockInTime,
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.access_time , color: Colors.white ,) ,
                                Text(" ClockOut Time: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    '${projectSnap.data[index].clockOutTime}',
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.location_on , color: Colors.white ,) ,
                                Text(" ClockIn Lat: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].clockInLat.toString(),
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.location_on , color: Colors.white ,) ,
                                Text(" ClockIn Long: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].clockInLong.toString(),
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.location_on , color: Colors.white ,) ,
                                Text(" ClockOut Lat: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].clockOutLat.toString(),
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.location_on , color: Colors.white ,) ,
                                Text(" ClockOut Long: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].clockOutLong.toString(),
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,
                            Row(

                              children: <Widget>[
                                Icon(Icons.time_to_leave , color: Colors.white ,) ,
                                Text(" Total Time: " , style: TextStyle(
                                    fontFamily: 'Arial Black' ,
                                    fontWeight: FontWeight.bold ,
                                    color: Colors.white)) ,
                                Flexible(child: Text(
                                    projectSnap.data[index].totalTime.toString(),
                                    style: TextStyle(fontFamily: 'Arial Black' ,
                                        fontWeight: FontWeight.bold, color: Colors.white))) ,

                              ] ,
                            ) ,
                            Divider(height: 10 , thickness: 2 ,) ,



                          ] ,
                        ) ,


                      ) ,
                    );


                  },
                );
              }
            }

          },

        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.only(left:8,right: 8),
            child: OutlineButton(

                borderSide: BorderSide(color: Colors.blue),
                shape: StadiumBorder(),

                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ClockIn()));
                },
                child: Text(
                  'Go Back',
                  style: GoogleFonts.robotoCondensed(
                      color: Colors.blue,
                      fontSize: 2.9 * media,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7 * media),
                )),
          ),
        ),

      );
    }
}
