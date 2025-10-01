import 'package:call_note/pages/index_page.dart';
import 'package:call_note/pages/test_page.dart';
import 'package:flutter/material.dart';

List<Widget> pages = [IndexPage(), TestPage()];

class PagesRoot extends StatefulWidget {
  const PagesRoot({super.key});

  @override
  State<PagesRoot> createState() => _PagesRootState();
}

class _PagesRootState extends State<PagesRoot> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 184, 205, 170),
        title: Text("Test Apssp bar"),
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Test"),
        ],
        currentIndex: index,
      ),
    );
  }
}
