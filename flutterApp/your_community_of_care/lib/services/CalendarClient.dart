/// Provides the `YouTubeApi` class.
import 'package:googleapis/calendar/v3.dart' as v3;

/// Provides the `GoogleSignIn` class
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:login_and_database/models/client_visit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class CalendarClient {
  var _credentials;

  static const _scopes = const [v3.CalendarApi.calendarEventsScope];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    clientId:
        '988340059004-udr9if3aovh2broo15k6v449nsptf7ms.apps.googleusercontent.com',
    scopes: <String>[
      'https://www.googleapis.com/auth/calendar',
    ],
  );

  CalendarClient() {
    //login();
    _googleSignIn.signIn();
  }

  Future<List<ClientMeeting>> getCalender(DateTime dateTime) async {
    var httpClient = (await _googleSignIn.authenticatedClient())!;
    var calendar = CalendarApi(httpClient);

    String calendarId = "primary";
    String description;

    List<ClientMeeting> clientList = [];

    var calEvents = calendar.events.list("primary");
    await calEvents.then((Events events) {
      //events.items.forEach((Event event) {print(event.summary);});
      events.items?.forEach((Event event) {
        print(event.start!.dateTime!.year);
        if (dateTime.day == event.start!.dateTime!.day) {
          // ignore: unnecessary_new
          clientList.add(new ClientMeeting(
            day: event.start!.dateTime!.day,
            month: event.start!.dateTime!.month,
            year: event.start!.dateTime!.year,
            hour: event.start!.dateTime!.hour - 6,
            minute: event.start!.dateTime!.minute,
            description: event.description!,
          ));
        }
      });
    });
    return clientList;
  }
}
