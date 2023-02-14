
import 'dart:convert';
import 'package:http/http.dart';
import 'package:instagramclone/models/member_model.dart';

class Network {

  static String BASE = "fcm.googleapis.com";
  static String api = "/fcm/send";
  static Map<String, String> headers = {
    "Authorization" : "key=AAAAbc0TBSc:APA91bF9S_DJOeaqZzTNHOAug1f8EXv0IL8kWjgeBoZRZAAwaLvdz9MTUGxcY10CG5ktHcxSZxWwGNcb_5S-1XJxHb1dC4PVEBcvhznejCn6h07mB7A4zNwzU-mrDO-efkyTY-nQJ-Wc",
    "Content-Type" : "application/json"
  };

  static Future<String?> POST(Map<String, dynamic> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers : headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future sendNotification(String name, Member someone) async {
    Map<String, dynamic> params = {
      "notification":
      {
        "body": name + " is your new subscriber",
        "title": "😎 New Followers 😎"
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": someone.device_token
    };
    POST(params);
  }

}

