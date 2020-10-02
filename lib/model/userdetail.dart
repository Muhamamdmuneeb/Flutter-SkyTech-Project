class UserDetail{
  String lastname;
  String firstname;
  String empid;
  String deviceid;
  String currentdate;
  String currenttime;
  String lat;
  String long;
  UserDetailMap(){
     var userdetailmap = Map<String, dynamic>();
        userdetailmap['clockinfirstname'] = firstname;
        userdetailmap['clockinlastname'] = lastname;
        userdetailmap['clockinempid'] = empid;
        userdetailmap['clockindeviceid'] = deviceid;
        userdetailmap['clockincurrentdate'] = currentdate;
        userdetailmap['clockincurrentTime'] = currenttime;
        userdetailmap['clockinlat'] = lat;
        userdetailmap['clockinlong'] = long;
        userdetailmap['clockoutfirstname'] = "";
        userdetailmap['clockoutlastname'] = "";
        userdetailmap['clockoutempid'] = "";
        userdetailmap['clockoutdeviceid'] = "";
        userdetailmap['clockoutcurrentdate'] = "";
        userdetailmap['clockoutcurrentTime'] = "";
        userdetailmap['clockoutlat'] = "";
        userdetailmap['clockoutlong'] = "";
   return userdetailmap;
  }


}