import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_incall/flutter_incall.dart';
import 'package:light/light.dart';
import 'package:provider/provider.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:sparrow/helpers/DarkMode/dark_provider.dart';

Color primaryColor = Colors.green;

class SensorScreen extends StatefulWidget {
  const SensorScreen({Key? key}) : super(key: key);

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  bool _isNear = false;
  late StreamSubscription<dynamic> _streamSubscription;

  var prox_status = 'OFF';
  var light_status = 'OFF';

  Future<void> _enableProximitySensor() async {
    FlutterError.onError = (FlutterErrorDetails details) {
      if (foundation.kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };
    setState(() {
      prox_status = 'ON';
    });
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        IncallManager().turnScreenOff();
      });
    });
  }

  // turn off the proximity sensor
  Future<void> _disableProximitySensor() async {
    setState(() {
      prox_status = 'OFF';
    });
  }

  // light sensor
  String _luxString = 'Unknown';
  late Light _light;
  late StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
    });
    final provider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    if (luxValue < 15) {
      provider.toggleTheme(true);
    } else {
      provider.toggleTheme(false);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      setState(() {
        light_status = 'ON';
      });
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  _changeTheme() {
    final provider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    // provider.toggleTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          foregroundColor: Colors.black,
          title: Text("Control your sensors")),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                // borderRadius: BorderRadius.circular(20),
                "Proximity : $prox_status",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              // proximity sensor turn on/off
              RaisedButton(
                  child: Text("ON"),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    _enableProximitySensor();
                  }),
              RaisedButton(
                  child: Text("OFF"),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    _disableProximitySensor();
                  }),

              Divider(
                color: Colors.black,
              ),

              Text(
                // borderRadius: BorderRadius.circular(20),
                "Light Sensor : $light_status",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              // proximity sensor turn on/off
              RaisedButton(
                  child: Text("ON"),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    initPlatformState();
                  }),
              RaisedButton(
                  child: Text("OFF"),
                  color: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                  }),

                  Text("Dark Mode"),

                  Switch.adaptive(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  _changeTheme();
                }),

              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
