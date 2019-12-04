import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl1 = "https://iampac.de";
const baseUrl = "http://10.0.75.1:8000";
const contactDetails = "http://10.0.75.1:8000";

class API {
  static Future getUsers() {
    var url = baseUrl1 + "/Contacts";
    return http.get(url);
  }
}

class DetailApi {
  static Future getDetails(id) {
    var url = contactDetails + "/ContactDetails/"+id;
    return http.get(url);
  }
}