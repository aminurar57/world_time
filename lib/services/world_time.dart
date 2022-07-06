import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String? location; //location name for the UI
  String? time; //the time in that location
  String? flag; //url to an asset flag icon
  String? url; //location url for api end points
  bool? isDaytime; //true -> daytime, false -> nighttime

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try{
      //Make a response
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url')); //Asia/Kolkata
      Map data  = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      String hours = data['utc_offset'].substring(1,3);
      String mins = data['utc_offset'].substring(4,6);
      // print(datetime);
      //print(mins);

      //create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(hours)));
      now = now.add(Duration(minutes: int.parse(mins)));

      //now.add(Duration(hours: offset));
      //print(now);

      //set the time property
      isDaytime = now.hour>6 && now.hour<17 ? true : false; //day or night
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error: $e');
      time = 'could not get the time';
    }

  }

}
