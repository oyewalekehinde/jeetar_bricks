import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticService {
  late final FirebaseAnalytics _service;
  String? _deviceName;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  get instance => _service;
  // AnalyticService() :

  AnalyticService() {
    _service = FirebaseAnalytics.instance;
    _getDeviceName();
  }

  void addEvent({required name, Map<String, Object>? parameters}) {
    FirebaseAnalytics.instance.logEvent(name: name, parameters: {
      ...?parameters,
      "date": DateTime.now().toString(),
      "deviceOS": Platform.isAndroid ? "Android" : "iOS",
      "deviceName": _deviceName.toString()
    });
  }

  void _getDeviceName() {
    if (Platform.isAndroid) {
      deviceInfo.androidInfo.then((value) => _deviceName = value.model);
    } else {
      deviceInfo.iosInfo.then((value) => _deviceName = value.utsname.machine);
    }
  }

  set userId(String userId) {
    _service.setUserId(id: userId);
  }

  void userProperties(
      {required String name, required Map<String, String> props}) {
    userId = name;
    props.forEach((key, value) {
      _service.setUserProperty(name: key, value: value);
    });
  }
}
