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
  List<NotedCaller> callers = [];
  Map<NotedCaller, TextEditingController> controllers = {};

  @override
  void initState() {
    setCallLog();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Count is ${callers.length}"),
        for (var caller in callers)
          ListTile(
            title: Text(caller.displayName),
            subtitle: Text(caller.myCallType?.name ?? "no type"),
            trailing: Text(
              caller.notes.isNotEmpty
                  ? caller.notes[0].content.toString()
                  : "No notes",
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext builder) => SimpleDialog(
                  title: Text(caller.displayName),
                  children: [
                    TextField(
                      controller: controllers[caller],
                      minLines: 5,
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          // print("Setting state $value");
                          Note note = Note(
                            type: NoteType.plainText,
                            content: value,
                          );
                          if (caller.notes.isEmpty) {
                            caller.notes.add(note);
                          }
                          caller.notes[0] = note;
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
      callers = result.map((x) => NotedCaller.fromCallLog(x, [])).toList();
      for (var caller in callers) {
        controllers[caller] = TextEditingController();
      }
      print("${callers.length} callers retrieved");
    });
  }
}
