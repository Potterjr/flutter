// ignore_for_file: prefer_const_constructors, camel_case_types, unused_import, unused_local_variable, unused_label
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class show_noti extends StatefulWidget {
  const show_noti({Key? key}) : super(key: key);

  @override
  State<show_noti> createState() => _show_notiState();
}

class _show_notiState extends State<show_noti> {
  Future<void> showno() async {
    Person admin = const Person(name: 'Admin', key: 'Admin');

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'test',
      'test',
      channelDescription: 'test',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    styleInformation:
    MessagingStyleInformation(admin,
        conversationTitle: "uasihau",
        messages: <Message>[Message("testaaa", DateTime.now(), admin)]);

    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'test',
        'test',
      ),
    );

//show noti
    await flutterLocalNotificationsPlugin.show(
        0, 'Basic Nofi', 'Body Noti', platformChannelDetails);
  }

  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  Future<void> showschduled_Notification(DateTime scheduleDate) async {
    //Setup phase
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Nopphagaw_noti_001',
      'BasicNofi',
      channelDescription: 'Basic Nofi',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    //End Setup
    // show noti
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'แจ้งเตือนนนน',
      'บัดซบ!!!',
      tz.TZDateTime.from(scheduleDate, tz.local),
      platformChannelDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
  TimeOfDay selectTime=TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
  final TimeOfDay? timeOfDay = await showTimePicker( 
    context: context,
    initialTime: selectTime,
    initialEntryMode: TimePickerEntryMode.dial,
   );
   if(timeOfDay != null && timeOfDay != selectTime)
    {
     setState() {
      selectTime = timeOfDay;
     };
    }
}
                                       
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("noti app"),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amberAccent,
                  ),
                  onPressed: () {
                    showno();
                  },
                  child: const Text("show noti"),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 32, 228, 14),
                  ),
                  onPressed: () {
                    showschduled_Notification(DateTime.now().add(Duration(seconds:5)),
               
                    );
                  },
                  child: const Text("show noti2"),
                ),
              ),
            ),
                 SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 32, 228, 14),
                  ),
                  onPressed: () {
                    _selectTime(context);
               
                    
                  },
                  child: Text("Choose Time ${selectTime.hour}:${selectTime.minute}"),
                ),
              ),
            ),
          ],
        ));
  }
}
