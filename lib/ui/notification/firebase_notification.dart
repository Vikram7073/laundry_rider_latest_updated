import 'dart:convert';
import 'package:http/http.dart'as https;

Future send_notification(List? tokenlst, String ? message) async {

  print("---->$message");
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAAvYevL08:APA91bHqtBZGBX0-Cn3iF2YnCdMvC0X6FwnLnQ4npT4Y0PWOEkQ7CiiWUmwrxtdvTEOKsi5rByj8p5gWGJgRTAz0nTJQ4EJWKPuGGC0lRzDqlwTVMo7ubIlLVuMO_bvUpaabkpQ7fhQx'
    };
    var request =
    https.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "registration_ids": tokenlst,
      "notification": {
        "body": message??"",
        "content_available": true,
        "priority": "high",
        "Title": "Laundry Notifications."
      },
      "data": {
        "priority": "high",
        "sound": "app_sound.wav",
        "content_available": true,
        "bodyText": message,
      }
    });
    request.headers.addAll(headers);
    https.StreamedResponse response = await request.send();
    print(await response.stream.bytesToString());
    final data = json.decode(await response.stream.bytesToString());
  //  print(await data);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  } catch (e) {
    print(e.toString());
  }
}
