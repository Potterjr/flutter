import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notification me'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay today = TimeOfDay.now();
  int min = 0;
  int hr = 0;
  int sec = 0;
  String tt = "Time Schedule";

  Future<void> _showNoti() async {
    const AndroidNotificationDetails notiDetails = AndroidNotificationDetails(
        "noti_01", "Basic_noti",
        channelDescription: "Basicnoti",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: notiDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        0,
        "Admin",
        "แสดง Notification ขณะนี้เวลา ${DateTime.now().hour}:${DateTime.now().minute < 10 ? '0' + DateTime.now().minute.toString() : DateTime.now().minute.toString()}",
        platformChannelDetails);
  }

  Future<void> _showOneMin_Noti(
      DateTime scheduleDate, String title, String body) async {
    const AndroidNotificationDetails notiDetails = AndroidNotificationDetails(
        "noti_02", "Basic_noti",
        channelDescription: "Basicnoti",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: notiDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(scheduleDate, tz.local), platformChannelDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _showSchedule_Noti(
      DateTime scheduleDate, String title, String body) async {
    const AndroidNotificationDetails notiDetails = AndroidNotificationDetails(
        "noti_02", "Basic_noti",
        channelDescription: "Basicnoti",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: notiDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(0, title, body,
        tz.TZDateTime.from(scheduleDate, tz.local), platformChannelDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: today,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null && timeOfDay != today) {
      setState(() {
        today = timeOfDay;
        hr = (DateTime.now().hour - today.hour).abs();
        min = (DateTime.now().minute - today.minute).abs() - 1;
        sec = (60 - DateTime.now().second);
        print("${hr} + ${min} + ${sec}");
        tt =
            "Set Time ${today.hour}:${today.minute < 10 ? '0' + today.minute.toString() : today.minute.toString()} ${today.period == DayPeriod.am ? 'AM' : 'PM'}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification me"),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.alarm),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 150,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.alarm),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        setState(() {
                          _showNoti();
                        });
                      },
                      label: const Text("Display Notification",
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          setState(() {
                            _showOneMin_Noti(
                                DateTime.now().add(const Duration(
                                    hours: 0, minutes: 1, seconds: 0)),
                                "Admin",
                                "ถึงเวลานัดหมาย ${DateTime.now().hour}:${DateTime.now().minute < 10 ? '0' + (DateTime.now().minute + 1).toString() : (DateTime.now().minute + 1).toString()}");
                          });
                        },
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Text('Show After 1 minute ',
                                style: const TextStyle(fontSize: 20)),
                            Icon(Icons.alarm),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: OutlinedButton(
                style: ElevatedButton.styleFrom(primary: Colors.amber),
                onPressed: () {
                  setState(() {
                    _selectTime(context);
                    _showSchedule_Noti(
                        DateTime.now().add(
                            Duration(hours: hr, minutes: min, seconds: sec)),
                        "Admin",
                        "ถึงเวลานัดหมาย ${today.hour}:${today.minute < 10 ? '0' + (today.minute + 1).toString() : (today.minute + 1).toString()} ");
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tt, style: const TextStyle(fontSize: 20)),
                    const Icon(Icons.alarm),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
