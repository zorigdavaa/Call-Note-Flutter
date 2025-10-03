import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

// ignore: unused_element
bool _permissionDenied = false;

@pragma('vm:entry-point')
Future<Iterable<CallLogEntry>> getCallLogs() async {
  Iterable<CallLogEntry> cLog = Iterable.empty();
  List<Contact> contacts = List.empty();
  try {
    cLog = await CallLog.get();
    if (await FlutterContacts.requestPermission(readonly: true)) {
      contacts = await FlutterContacts.getContacts();
    } else {
      _permissionDenied = true;
    }

    for (var log in cLog) {
      String displayName = contacts
          .firstWhere(
            (x) => x.phones.any((g) => g.number == log.number.toString()),
          )
          .displayName;
      log.name = displayName;
    }
  } on PlatformException catch (e, s) {
    print(e);
    print(s);
  }
  return cLog;
}
