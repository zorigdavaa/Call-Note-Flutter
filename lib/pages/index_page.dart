import 'package:call_log/call_log.dart';
import 'package:call_note/Models/caller.dart';
import 'package:call_note/data/call_log_retriever.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<CallLogEntry> callers = List.empty();

  @override
  void initState() {
    setCallLog();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: callers.map((x) => Text(x.number ?? "No Number")).toList(),
    );
  }

  Future setCallLog() async {
    final Iterable<CallLogEntry> result = await getCallLogs();
    setState(() {
      callers = result.toList();
    });
  }
}
