import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Native Code Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Native Code Demo'),
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
  var _isLoading = false;
  String batteryLevel = 'Unknown battery Lvel';
  static const String domain = 'course.flutter.dev/battery';

  static const platform = MethodChannel(domain);

  Future<void> _getBatteryLevel() async {
    var _myBatteryLevel;
    try {
      setState(() {
        _isLoading = true;
      });
      _myBatteryLevel = await platform.invokeMethod('getBatteryLevel');
    } on PlatformException catch (err) {
      _myBatteryLevel =
          'PlatformException to get the battery level ${err.message}';
    } catch (err) {
      _myBatteryLevel = 'Default exception to  get the battery level';
    }
    setState(() {
      batteryLevel = _myBatteryLevel;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //Get the battery level!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: _isLoading == true
                  ? CircularProgressIndicator()
                  : Text(
                      '$batteryLevel',
                    ),
            ),
            TextButton.icon(
              onPressed: _getBatteryLevel,
              icon: Icon(Icons.battery_charging_full),
              label: Text('Get Battery Level'),
            )
          ],
        ));
  }
}
