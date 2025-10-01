import 'package:call_log/call_log.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
Future<Iterable<CallLogEntry>> getCallLogs() async {
  print('Background Services are Working!');
  Iterable<CallLogEntry> cLog = Iterable.empty();
  try {
    cLog = await CallLog.get();
    print('Queried call log entries');
    for (CallLogEntry entry in cLog) {
      print('-------------------------------------');
      print('F. NUMBER  : ${entry.formattedNumber}');
      print('C.M. NUMBER: ${entry.cachedMatchedNumber}');
      print('NUMBER     : ${entry.number}');
      print('NAME       : ${entry.name}');
      print('TYPE       : ${entry.callType}');
      print(
        'DATE       : ${DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)}',
      );
      print('DURATION   : ${entry.duration}');
      print('ACCOUNT ID : ${entry.phoneAccountId}');
      print('ACCOUNT ID : ${entry.phoneAccountId}');
      print('SIM NAME   : ${entry.simDisplayName}');
      print('-------------------------------------');
    }
  } on PlatformException catch (e, s) {
    print(e);
    print(s);
  }
  return cLog;
}
