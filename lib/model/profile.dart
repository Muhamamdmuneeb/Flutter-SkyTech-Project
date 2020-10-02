class ProfilePage{
 
  String firstname;
  String lastname;
  String empid;
  String device;
  
 ProfilePageMap(){
   var map = Map<String, dynamic>();
 
   map ['firstname'] = firstname;
   map['lastname'] = lastname;
   map['empid'] = empid;
   map['deviceid'] = device; 
  return map;
 }
 
}