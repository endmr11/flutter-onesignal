import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> initOneSignal() async {
    await OneSignal.shared.setAppId("");
    await OneSignal.shared.getDeviceState().then((value) {
      print(value!.userId);
    });
    await OneSignal.shared.consentGranted(true);
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    await OneSignal.shared.setRequiresUserPrivacyConsent(true);
    await OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      print("OSNotificationReceivedEvent: ${event.notification}");
      event.complete(event.notification);
    });

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      print("OSNotificationOpenedResult: $result");
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("OSPermissionStateChanges: $changes");
    });

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      print("OSSubscriptionStateChanges: $changes");
    });

    OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
      print("OSEmailSubscriptionStateChanges: $emailChanges");
    });
  }

  @override
  void initState() {
    super.initState();
    initOneSignal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OneSignal")),
      body: Container(),
    );
  }
}
