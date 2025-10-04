import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

// ignore: unused_element
bool _permissionDenied = false;

@pragma('vm:entry-point')
Future<Iterable<CallLogEntry>> getCallLogs() async {
  Iterable<CallLogEntry> cLog = Iterable.empty();
  List<Contact> contacts = List.empty();
  Map<String, String> numAndName = {};
  try {
    cLog = await CallLog.get();
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts();
      for (var contact in contacts) {
        print(contact.displayName);
        print(contact.phones);
        print(contact.addresses);
        print(contact.emails);
        print(contact.accounts);

        if (contact.phones.isNotEmpty) {
          print(contact.phones[0]);
        }
        for (var phone in contact.phones) {
          numAndName[phone.number] = contact.displayName;
          print(contact.displayName);
          print(phone.number);
        }
      }
      for (var log in cLog) {
        if (numAndName.containsKey(log.number)) {
          log.name = numAndName[log.number];
          print("name found ${log.name}");
        } else {
          log.name = null;
          print("name not found ${log.name}");
        }

        // String displayName = contacts
        //     .firstWhere(
        //       (x) => x.phones.any((g) => g.number == log.number.toString()),
        //     )
        //     .displayName;
      }
    } else {
      _permissionDenied = true;
      print("No permissuib");
    }
  } on PlatformException catch (e, s) {
    print(e);
    print(s);
  }
  return cLog;
}
