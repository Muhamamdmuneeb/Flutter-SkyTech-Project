import 'dart:convert';
import 'package:http/http.dart' as http;
class GetAllData{
  Future<List>getData(deviceId)async{
    List<ListData> data1=[];
    var i=0;
   var url='https://skytech-5d5eb.firebaseio.com/usersInfo.json';
   var response =await http.get(url);
   Map<String,dynamic> data=jsonDecode(response.body);
    print(data.toString()+"Check in get data ");

    if(data!=null){

      data.forEach((key,value){
        if(value['deviceid']==deviceId) {
          data1.add(ListData(
              clockInDate: value['clockindate'],
              clockInLat: value['clockinlat'],
              clockInLong: value['clockinlong'],
              clockInTime: value['clockintime'],
              clockOutDate: value['clockoutdate'],
              clockOutLat: value['clockoutlat'],
              clockOutLong: value['clockoutlong'],
              clockOutTime: value['clockouttime'],
              totalTime: value['totaltime']
          ));
        }
        });
      }else{
      return null;
    }
    if(data1==null){
      return null;
    }else{
      print(data1.toString()+"check data again");
      return data1;

    }

  }
}




class ListData{
  String clockInLat;
  String clockInLong;
  String clockInTime;
  String clockInDate;
  String clockOutLat;
  String clockOutLong;
  String clockOutTime;
  String clockOutDate;
  String totalTime;
  ListData({
   this.clockInDate,
   this.clockInLat,
   this.clockInLong,
   this.clockInTime,
   this.clockOutDate,
   this.clockOutLat,
   this.clockOutLong,
   this.clockOutTime,
    this.totalTime
});
}
