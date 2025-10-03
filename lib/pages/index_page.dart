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
  List<NotedCaller> callers = List.empty();

  @override
  void initState() {
    setCallLog();
    // TODO: implement initState
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Count is ${callers.length}"),
        for (var caller in callers)
          ListTile(
            title: Text(caller.displayName),
            subtitle: Text(caller.myCallType?.name ?? "no type"),
            trailing: caller.notes.isNotEmpty
                ? Text(caller.notes[0].toString())
                : null,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext builder) => SimpleDialog(
                  title: Text(caller.displayName),
                  children: [
                    TextField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          caller.notes[0] = value;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),

        // callers
        //     .map(
        //       (x) => ListTile(
        //         // leading: Text(x.number ?? "No Number"),
        //         title: Text(x.number ?? "No Number"),
        //         subtitle: Text(x.name ?? "No Number"),
        //         trailing: Text(x.number ?? "No Number"),
        //       ),
        //     )
        //     .toList(),
      ],
    );
  }

  Future setCallLog() async {
    final Iterable<CallLogEntry> result = await getCallLogs();
    setState(() {
      callers = result
          .map((x) => NotedCaller.fromCallLog(x, List.empty()))
          .toList();
      print("${callers.length} callers retrieved");
    });
  }
}
