import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../shared/di.dart';
import '../shared/notifications/firebase_notification_manager.dart';
import '../shared/utils/storage.dart';
import 'app_configs.dart';
import '../firebase_options.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

class AppStartUp {
  Future<void> setUp() async {
    getIt.allowReassignment = true;
    await initializedFirebase();
    await registerServices(getIt);

    loadStartUpConfig();
    await firebasePushNotification();
  }

  Future<void> registerServices(ioc) async {
    setupSharedServices(ioc);
  }

  void loadStartUpConfig() async {
    // clear cached token if the app is a newly installed.
    var isFirstTime =
        await LocalStorageUtils.read(AppConstants.isUserFirstTime);
    if (isFirstTime != "true") {
      await const FlutterSecureStorage().deleteAll();
    }
  }

  Future<void> initializedFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> firebasePushNotification() async {
    FirebaseNotificationManager notificationManager =
        FirebaseNotificationManager();
    await notificationManager.registerNotification();
    try {
      await notificationManager.deviceToken;
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }
}
